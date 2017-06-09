within IBPSA.Experimental.Pipe;
model PipeCoreStatic
  "Pipe model using static modeling components for comparison"
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

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Default medium state";

  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced", enable=use_rho_nominal));

  parameter Modelica.SIunits.DynamicViscosity mu_default=
      Medium.dynamicViscosity(Medium.setState_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default))
    "Default dynamic viscosity (e.g., mu_liquidWater = 1e-3, mu_air = 1.8e-5)"
    annotation (Dialog(group="Advanced", enable=use_mu_default));

  parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(state=sta_default)
    "Heat capacity of medium";

public
  BaseClasses.HeatLossPipeStatic                        reverseHeatLoss(
    redeclare package Medium = Medium,
    diameter=diameter,
    length=length,
    C=C,
    R=R,
    m_flow_small=m_flow_small,
    T_ini=T_ini_in)
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));

  BaseClasses.HeatLossPipeStatic                        heatLoss(
    redeclare package Medium = Medium,
    diameter=diameter,
    length=length,
    C=C,
    R=R,
    m_flow_small=m_flow_small,
    T_ini=T_ini_out)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  IBPSA.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-44,10},{-24,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
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

  Fluid.FixedResistances.HydraulicDiameter          res(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    from_dp=from_dp,
    length=length,
    fac=1,
    final dh=diameter)
                     "Pressure drop calculation for this pipe"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation

  connect(reverseHeatLoss.heatPort, heatPort) annotation (Line(points={{-70,10},
          {-70,40},{0,40},{0,100}}, color={191,0,0}));
  connect(heatLoss.heatPort, heatPort) annotation (Line(points={{50,10},{50,40},
          {0,40},{0,100}}, color={191,0,0}));

  connect(port_a, reverseHeatLoss.port_b)
    annotation (Line(points={{-100,0},{-80,0}},         color={0,127,255}));
  connect(reverseHeatLoss.port_a, senMasFlo.port_a)
    annotation (Line(points={{-60,0},{-52,0},{-44,0}}, color={0,127,255}));
  connect(heatLoss.port_b, port_b)
    annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
  connect(senMasFlo.port_b, res.port_a)
    annotation (Line(points={{-24,0},{-18,0},{-10,0}}, color={0,127,255}));
  connect(res.port_b, heatLoss.port_a)
    annotation (Line(points={{10,0},{20,0},{28,0},{40,0}}, color={0,127,255}));
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
          fillColor={215,202,187}),
        Ellipse(
          extent={{-92,94},{-50,52}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,20},{-20,-20}},
          lineColor={28,108,200},
          startAngle=30,
          endAngle=90,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={-70,74},
          rotation=180)}),
    Documentation(revisions="<html>
<ul>
<li>June 9, 2017 by Marcus Fuchs:<br>First implementation based on <a
href=\"modelica://IBPSA.Experimental.Pipe.PipeCore\">IBPSA.Experimental.Pipe.PipeCore</a>
for <a href=\"https://github.com/bramvdh91/modelica-ibpsa/issues/76\">issue
76</a> </li>
</ul>
</html>", info="<html>
<p>This model is intended as a static implementation of a pipe model for direct
comparison with the dynamic approach in <a
href=\"modelica://IBPSA.Experimental.Pipe.PipeCore\">IBPSA.Experimental.Pipe.PipeCore</a>.
Instead of a plug flow component, this model only uses a hydraulic resistance
model to represent the static hydraulic behavior of the pipe. In addition, the
heat losses are not calculated based on a fluid parcel's travel time but rather
based on the current flow velocity. </p>
</html>"));
end PipeCoreStatic;
