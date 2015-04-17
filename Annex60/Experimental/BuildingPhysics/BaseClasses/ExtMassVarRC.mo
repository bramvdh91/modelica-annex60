within Annex60.Experimental.BuildingPhysics.BaseClasses;
model ExtMassVarRC "Wall consisting of variable number of RC elements"
  parameter Integer n(min = 1) "Number of RC-elements";
  parameter Modelica.SIunits.ThermalResistance RExt[n]
    "Vector of resistances for each RC-element" annotation(Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.ThermalResistance RExtLast
    "Resistance of remaining resistor RExtLast" annotation(Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.HeatCapacity CExt[n]
    "Vector of heat capacity of thermal masses for each RC-element" annotation(Dialog(group="Thermal mass"));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermResExt[n](R=RExt)
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermResExtLast(R=
        RExtLast)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-104,-10},{-84,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{82,-10},{102,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor thermCapExt[n](C=CExt)
    annotation (Placement(transformation(extent={{-10,-12},{10,-32}})));
equation
  // connecting inner elements thermCapExt[i]--thermResExt[i] to n-1 groups
  for i in 1:n-1 loop
    connect(thermCapExt[i].port, thermResExt[i].port_a);
    connect(thermResExt[i].port_b, thermCapExt[i+1].port);
  end for;
  // connecting last RC elements to outmost resistors and to connectors: port_a--thermResExtLast...thermResExt[n]--port_b
  connect(thermCapExt[n].port, thermResExt[n].port_a);
  connect(thermResExtLast.port_b, thermCapExt[1].port);
  connect(thermResExt[n].port_b, port_b);
  connect(thermResExtLast.port_a, port_a);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 120}}), graphics), Documentation(info="<html>
</html>",  revisions="<html>
<ul>
<li>April 17, 2015,&nbsp; by Moritz Lauster:<br>Implemented. </li>
</ul>
</html>"),  Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 120}}), graphics={  Rectangle(extent=  {{-86, 60}, {-34, 26}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{-28, 60}, {26, 26}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{32, 60}, {86, 26}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{0, 20}, {54, -14}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{-60, 20}, {-6, -14}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{-86, -20}, {-34, -54}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{-28, -20}, {26, -54}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{32, -20}, {86, -54}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{-60, -60}, {-6, -94}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{0, -60}, {54, -94}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{-60, 100}, {-6, 66}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{0, 100}, {54, 66}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{60, -60}, {114, -94}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{60, 20}, {116, -14}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{60, 100}, {116, 66}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{-120, -60}, {-66, -94}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{-120, 20}, {-66, -14}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{-120, 100}, {-66, 66}}, fillColor=  {255, 213, 170},
            fillPattern=                                                                                                    FillPattern.Solid, lineColor=  {175, 175, 175}), Rectangle(extent=  {{-90, 120}, {-120, -100}}, fillColor=  {255, 255, 255},
            fillPattern=                                                                                                    FillPattern.Solid, pattern=  LinePattern.None), Rectangle(extent=  {{120, 120}, {89, -100}}, fillColor=  {255, 255, 255},
            fillPattern=                                                                                                    FillPattern.Solid, pattern=  LinePattern.None), Line(points=  {{-90, 0}, {90, 0}}, color=  {0, 0, 0}, thickness=  0.5, smooth=  Smooth.None), Rectangle(extent=  {{-74, 12}, {-26, -10}}, lineColor=  {0, 0, 0},
            lineThickness=                                                                                                    0.5, fillColor=  {255, 255, 255},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{28, 12}, {76, -10}}, lineColor=  {0, 0, 0},
            lineThickness=                                                                                                    0.5, fillColor=  {255, 255, 255},
            fillPattern=                                                                                                    FillPattern.Solid), Line(points=  {{-1, 0}, {-1, -32}}, color=  {0, 0, 0}, thickness=  0.5, smooth=  Smooth.None), Rectangle(extent=  {{16, -32}, {-18, -44}},
            lineThickness=                                                                                                    0.5, fillColor=  {255, 255, 255},
            fillPattern=                                                                                                    FillPattern.Solid, pattern=  LinePattern.None), Line(points=  {{-18, -32}, {16, -32}}, pattern=  LinePattern.None, thickness=  0.5, smooth=  Smooth.None), Line(points=  {{-18, -44}, {16, -44}}, pattern=  LinePattern.None, thickness=  0.5, smooth=  Smooth.None), Text(extent=  {{-90, 142}, {90, 104}}, lineColor=  {0, 0, 255}, textString=  "%name")}));
end ExtMassVarRC;