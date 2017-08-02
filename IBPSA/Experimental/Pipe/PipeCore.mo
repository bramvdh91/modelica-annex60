within IBPSA.Experimental.Pipe;
model PipeCore
  "Pipe model using spatialDistribution for temperature delay with modified delay tracker"
  extends IBPSA.Fluid.Interfaces.PartialTwoPort;

  parameter Modelica.SIunits.Diameter diameter "Pipe diameter";
  parameter Modelica.SIunits.Length length "Pipe length";
  parameter Modelica.SIunits.Length thicknessIns "Thickness of pipe insulation";

  /*parameter Modelica.SIunits.ThermalConductivity k = 0.005 
    "Heat conductivity of pipe's surroundings";*/

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.1
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(
    m_flow_nominal) "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.SIunits.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
    annotation (Dialog(group="Geometry"));

  parameter IBPSA.Experimental.Pipe.Types.ThermalResistanceLength R=1/(lambdaI*2
      *Modelica.Constants.pi/Modelica.Math.log((diameter/2 + thicknessIns)/(
      diameter/2)));
  parameter IBPSA.Experimental.Pipe.Types.ThermalCapacityPerLength C=
      rho_default*Modelica.Constants.pi*(diameter/2)^2*cp_default;
  parameter Modelica.SIunits.ThermalConductivity lambdaI=0.026
    "Heat conductivity";

  parameter Modelica.SIunits.HeatCapacity walCap=length*((diameter + 2*
      thickness)^2 - diameter^2)*Modelica.Constants.pi/4*cpipe*rho_wall
    "Heat capacity of pipe wall";
  parameter Modelica.SIunits.SpecificHeatCapacity cpipe=500 "For steel";
  parameter Modelica.SIunits.Density rho_wall=8000 "For steel";

  // fixme: shouldn't dp(nominal) be around 100 Pa/m?
  // fixme: propagate use_dh and set default to false

  IBPSA.Experimental.Pipe.PipeAdiabaticPlugFlow pipeAdiabaticPlugFlow(
    redeclare final package Medium = Medium,
    final m_flow_small=m_flow_small,
    final allowFlowReversal=allowFlowReversal,
    dh=diameter,
    length=length,
    m_flow_nominal=m_flow_nominal,
    from_dp=from_dp,
    thickness=thickness,
    T_ini_in=T_ini_in,
    T_ini_out=T_ini_out)
    "Model for temperature wave propagation with spatialDistribution operator and hydraulic resistance"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));




  parameter Modelica.SIunits.Length thickness=0.002 "Pipe wall thickness";

  parameter Modelica.SIunits.Temperature T_ini_in=Medium.T_default
    "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Temperature T_ini_out=Medium.T_default
    "Initialization temperature at pipe outlet"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean initDelay=false
    "Initialize delay for a constant mass flow rate if true, otherwise start from 0"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.MassFlowRate m_flowInit=0
    annotation (Dialog(tab="Initialization", enable=initDelay));

  Modelica.SIunits.Temperature TempAv(start=T_ini_out)
    "Average temperature in pipe";
  Modelica.SIunits.HeatFlowRate Qloss(start=0)
    "Average heat loss from pipe";


public
  IBPSA.Experimental.Pipe.BaseClasses.HeatLossPipeDelay reverseHeatLoss(
    redeclare package Medium = Medium,
    diameter=diameter,
    length=length,
    C=C,
    R=R,
    m_flow_small=m_flow_small,
    T_ini=T_ini_in)
    annotation (Placement(transformation(extent={{-46,-10},{-66,10}})));

  IBPSA.Experimental.Pipe.BaseClasses.HeatLossPipeDelay heatLoss(
    redeclare package Medium = Medium,
    diameter=diameter,
    length=length,
    C=C,
    R=R,
    m_flow_small=m_flow_small,
    T_ini=T_ini_out)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  IBPSA.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-40,10},{-20,-10}})));
  IBPSA.Experimental.Pipe.BaseClasses.TimeDelay timeDelay(
    length=length,
    diameter=diameter,
    rho=rho_default,
    initDelay=initDelay,
    m_flowInit=m_flowInit)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));


  Fluid.Sensors.TemperatureTwoPort senTemIn(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=T_ini_in)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Fluid.Sensors.TemperatureTwoPort senTemOut(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=T_ini_out)
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor bouTemp
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Interfaces.RealOutput TemAv
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput Qlos
    annotation (Placement(transformation(extent={{100,46},{120,66}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Qloss)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=TempAv)
    annotation (Placement(transformation(extent={{60,80},{80,100}})));

  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Default medium state";

  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced"));

  parameter Modelica.SIunits.DynamicViscosity mu_default=
      Medium.dynamicViscosity(Medium.setState_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default))
    "Default dynamic viscosity (e.g., mu_liquidWater = 1e-3, mu_air = 1.8e-5)"
    annotation (Dialog(group="Advanced"));

  parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(state=sta_default)
    "Heat capacity of medium";
  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
equation
  der(TempAv) = (senTemIn.T - senTemOut.T)*senMasFlo.m_flow/rho_default/(
    Modelica.Constants.pi*(diameter/2)^2)/length + Qloss/(C*length);
  Qloss = -(TempAv - bouTemp.T)/R*length;


  connect(senMasFlo.m_flow, timeDelay.m_flow) annotation (Line(
      points={{-30,-11},{-30,-40},{-12,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(reverseHeatLoss.heatPort, heatPort) annotation (Line(points={{-56,10},
          {-56,40},{0,40},{0,100}}, color={191,0,0}));
  connect(heatLoss.heatPort, heatPort) annotation (Line(points={{50,10},{50,40},
          {0,40},{0,100}}, color={191,0,0}));

  connect(timeDelay.tauRev, reverseHeatLoss.tau) annotation (Line(points={{11,-36},
          {24,-36},{24,28},{-50,28},{-50,10}}, color={0,0,127}));
  connect(timeDelay.tau, heatLoss.tau) annotation (Line(points={{11,-44},{32,-44},
          {32,28},{44,28},{44,10}}, color={0,0,127}));

  connect(senMasFlo.port_b, pipeAdiabaticPlugFlow.port_a)
    annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
  connect(bouTemp.port, heatPort)
    annotation (Line(points={{20,90},{0,90},{0,100}}, color={191,0,0}));
  connect(realExpression1.y, TemAv)
    annotation (Line(points={{81,90},{110,90}}, color={0,0,127}));
  connect(realExpression.y, Qlos) annotation (Line(points={{81,70},{92,70},{92,56},
          {110,56}}, color={0,0,127}));
  connect(reverseHeatLoss.port_a, senMasFlo.port_a)
    annotation (Line(points={{-46,0},{-40,0}}, color={0,127,255}));
  connect(port_a, senTemIn.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  connect(senTemIn.port_b, reverseHeatLoss.port_b)
    annotation (Line(points={{-70,0},{-66,0}}, color={0,127,255}));
  connect(port_b, senTemOut.port_b)
    annotation (Line(points={{100,0},{86,0}}, color={0,127,255}));
  connect(heatLoss.port_b, senTemOut.port_a)
    annotation (Line(points={{60,0},{66,0}}, color={0,127,255}));
  connect(heatLoss.port_a, pipeAdiabaticPlugFlow.port_b)
    annotation (Line(points={{40,0},{10,0}}, color={0,127,255}));
  annotation (
    Line(points={{70,20},{72,20},{72,0},{100,0}}, color={0,127,255}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,30},{100,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-100,50},{100,40}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-40},{100,-50}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{0,100},{40,62},{20,62},{20,38},{-20,38},{-20,62},{-40,62},{0,
              100}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,30},{28,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,202,187})}),
    Documentation(revisions="<html>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">July 4, 2016 by Bram van der Heijde:<br>Introduce <code></span><span style=\"font-family: Courier New,courier;\">pipVol</code></span><span style=\"font-family: MS Shell Dlg 2;\">.</span></li>
<li>October 10, 2015 by Marcus Fuchs:<br>Copy Icon from KUL implementation and rename model; Replace resistance and temperature delay by an adiabatic pipe; </li>
<li>September, 2015 by Marcus Fuchs:<br>First implementation. </li>
</ul>
</html>", info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Implementation of a pipe with heat loss using the time delay based heat losses and the spatialDistribution operator for the temperature wave propagation through the length of the pipe. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The heat loss component adds a heat loss in design direction, and leaves the enthalpy unchanged in opposite flow direction. Therefore it is used in front of and behind the time delay. The delay time is calculated once on the pipe level and supplied to both heat loss operators. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This component uses a modified delay operator.</span></p>
</html>"));
end PipeCore;
