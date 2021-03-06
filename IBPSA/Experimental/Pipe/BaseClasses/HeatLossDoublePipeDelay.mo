within IBPSA.Experimental.Pipe.BaseClasses;
model HeatLossDoublePipeDelay
  "Heat loss model for pipe when second pipe is present with delay calculation at pipe level"
  extends Fluid.Interfaces.PartialTwoPortTransport;

  parameter Modelica.SIunits.Length length "Pipe length";
  parameter Modelica.SIunits.Diameter diameter "Pipe diameter";

  parameter Types.ThermalCapacityPerLength C
    "Capacitance of the water volume in J/(K.m)";
  parameter Types.ThermalResistanceLength Ra
    "Resistance for asymmetric problem, in Km/W";
  parameter Types.ThermalResistanceLength Rs
    "Resistance for symmetric problem, in Km/W";
  final parameter Modelica.SIunits.Time tau_char=sqrt(Ra*Rs)*C;

  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Tin_a
    "Temperature at port_a for in-flowing fluid";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Tout_b
    "Temperature at port_b for out-flowing fluid";
  Modelica.SIunits.Temperature T_amb=heatPort.T "Environment temperature";
  Real lambda;
  Modelica.SIunits.HeatFlowRate Qloss "Heat losses from pipe to environment";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.5;

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Default medium state";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(state=sta_default)
    "Heat capacity of medium";

public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Ambient temperature of pipe's surroundings" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealInput T_2in(unit="K", displayUnit="degC")
    "Inlet temperature of other pipe if present" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-100})));
  Modelica.Blocks.Interfaces.RealOutput T_2out(unit="K", displayUnit="degC")
    "Ambient temperature of pipe's surroundings" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,-100})));
  Modelica.Blocks.Interfaces.RealInput Tau_in(unit="s") "Delay time input"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,46})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Qloss)
    annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
equation
  dp = 0;

  port_a.h_outflow = inStream(port_b.h_outflow);

  port_b.h_outflow = Medium.specificEnthalpy_pTX(
    port_a.p,
    Tout_b,
    inStream(port_a.Xi_outflow)) "Calculate enthalpy of output state";

  Tin_a = Medium.temperature_phX(
    port_a.p,
    inStream(port_a.h_outflow),
    inStream(port_a.Xi_outflow));

  // Heat losses
  lambda = Modelica.Math.exp(Tau_in/tau_char);

  Tout_b = T_amb + (4*lambda*sqrt(Ra*Rs)*(Tin_a - T_amb) + (lambda^2 - 1)*(Rs
     - Ra)*(T_2in - T_amb))/(lambda^2*(Rs + Ra + 2*sqrt(Rs*Ra)) - (Rs + Ra - 2*
    sqrt(Rs*Ra)));

  T_2out = Tin_a;

  Qloss = IBPSA.Utilities.Math.Functions.spliceFunction(
    pos=(Tin_a - Tout_b)*cp_default,
    neg=0,
    x=port_a.m_flow,
    deltax=m_flow_nominal/1000)*port_a.m_flow;

  connect(heatPort, prescribedHeatFlow.port)
    annotation (Line(points={{0,100},{0,56}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, realExpression.y) annotation (Line(points=
          {{-4.44089e-016,36},{0,36},{0,0},{-17,0}}, color={0,0,127}));
  connect(heatPort, heatPort) annotation (Line(points={{0,100},{-7,100},{-7,100},
          {0,100}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,-68}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-52,2},{42,2},{42,8},{66,0},{42,-8},{42,-2},{-52,-2},{-52,2}},
          lineColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fillColor={170,213,255}),
        Polygon(
          points={{0,60},{38,2},{20,2},{20,-46},{-18,-46},{-18,2},{-36,2},{0,60}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Heat losses are only considered in design direction. For heat loss consideration in both directions use one of these models at both ends of a <code></span><span style=\"font-family: Courier New,courier;\">PipeAdiabaticPlugFlow</code></span><span style=\"font-family: MS Shell Dlg 2;\"> model.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This component requires the delay time and the instantaneous ambient temperature as an input. This component is to be used in double pipes and models influence from other pipes for flow in both directions. </span></p>
</html>", revisions="<html>
<ul>
<li>December 1, 2015 by Bram van der Heijde:<br>First implementation as double pipe version with delay as input.</li>
<li>September, 2015 by Marcus Fuchs:<br>First implementation. </li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end HeatLossDoublePipeDelay;
