within Annex60.Fluid.HeatPumps.Validation;
model Carnot_TCon_LimitedCapacity
  "Test model for Carnot_TCon with limited heating capacity"
  extends Examples.Carnot_TCon(heaPum(QCon_flow_max=250000));
  annotation (experiment(StopTime=3600),
__Dymola_Commands(file="modelica://Annex60/Resources/Scripts/Dymola/Fluid/HeatPumps/Validation/Carnot_TCon_LimitedCapacity.mos"
        "Simulate and plot"),
Documentation(info="<html>
<p>
This example extends from
<a href=\"modelica://Annex60.Fluid.HeatPumps.Examples.Carnot_TCon\">
Annex60.Fluid.HeatPumps.Examples.Carnot_TCon</a>
but limits the heating capacity.
</p>
</html>", revisions="<html>
<ul>
<li>
February 5, 2016, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end Carnot_TCon_LimitedCapacity;
