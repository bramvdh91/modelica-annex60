within IBPSA.Experimental.Pipe.BaseClasses;
model HeatLossPipeStatic
  "A static heat loss model for comparison and reference"
  extends Fluid.Interfaces.PartialTwoPortTransport;

  parameter Modelica.SIunits.Diameter diameter "Pipe diameter";
  parameter Modelica.SIunits.Length length "Pipe length";

  parameter Modelica.SIunits.Area A_cross=Modelica.Constants.pi*diameter*
      diameter/4 "Cross sectional area";

  parameter Types.ThermalCapacityPerLength C;
  parameter Types.ThermalResistanceLength R;
  final parameter Modelica.SIunits.Time tau_char=R*C;

  Modelica.SIunits.Temp_K Tin_a(start=T_ini) "Temperature at port_a for in-flowing fluid";
  Modelica.SIunits.Temp_K Tout_b(start=T_ini) "Temperature at port_b for out-flowing fluid";
  Modelica.SIunits.Temperature T_amb=heatPort.T "Environment temperature";
  Modelica.SIunits.HeatFlowRate Qloss "Heat losses from pipe to environment";
  Modelica.SIunits.EnthalpyFlowRate portA=inStream(port_a.h_outflow);
  Modelica.SIunits.EnthalpyFlowRate portB=inStream(port_b.h_outflow);

protected
  Real psi(min=0, max=1, unit="1")
    "Temperature drop factor for heat losses in pipe";
  Modelica.SIunits.Velocity velocity "Flow velocity within pipe";
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Default medium state";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(state=sta_default)
    "Heat capacity of medium";
  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
        p=Medium.p_default,
        T=Medium.T_default,
        X=Medium.X_default)
      "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
      annotation (Dialog(group="Advanced", enable=use_rho_nominal));

public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat port to connect environment"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatLoss annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,38})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Qloss)
    annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.5;
  parameter Modelica.Media.Interfaces.Types.Temperature T_ini=Medium.T_default
    "Initial output temperature";
equation
  dp = 0;

  velocity = abs(port_a.m_flow/(rho_default*A_cross));

  psi = Modelica.Math.exp(-length/(tau_char*velocity));

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
  Tout_b = T_amb + (Tin_a - T_amb) * psi;
  Qloss = IBPSA.Utilities.Math.Functions.spliceFunction(
    pos= (Tin_a-Tout_b)*cp_default,
    neg= 0,
    x= port_a.m_flow,
    deltax= m_flow_nominal/1000)  *port_a.m_flow;

  connect(heatLoss.port, heatPort)
    annotation (Line(points={{0,48},{0,100}}, color={191,0,0}));
  connect(realExpression.y, heatLoss.Q_flow)
    annotation (Line(points={{-13,0},{-6,0},{0,0},{0,28}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
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
<p>Heat losses are only considered in design direction. For heat loss
consideration in both directions use one of these models at both ends of a <a
href=\"modelica://IBPSA.Experimental.Pipe.PipeAdiabaticPlugFlow\">IBPSA.Experimental.Pipe.PipeAdiabaticPlugFlow</a>
model.</p>
<p>Instead of the dynamic modeling approach utilizing the delay time as in <a
href=\"modelica://IBPSA.Experimental.Pipe.BaseClasses.HeatLossPipeDelay\">IBPSA.Experimental.Pipe.BaseClasses.HeatLossPipeDelay</a>,
this model approximates the heat losses over the pipe with a static equation
utilizing the current flow velocity. This is based on the thermal model as
described in Liu [2014]. </p>
<h4>References</h4>
<p> Liu, X.: Combined Analysis of Electricity and Heat Networks, PhD Thesis,
2014 </p>
</html>", revisions="<html>
<ul>
<li>June 9, 2017 by Marcus Fuchs:<br>First implementation based on <a
href=\"modelica://IBPSA.Experimental.Pipe.BaseClasses.HeatLossPipeDelay\">IBPSA.Experimental.Pipe.BaseClasses.HeatLossPipeDelay</a>
for <a href=\"https://github.com/bramvdh91/modelica-ibpsa/issues/76\">issue
76</a> </li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end HeatLossPipeStatic;
