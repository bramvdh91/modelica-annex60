within IBPSA.Fluid.FixedResistances;
model FixedResistance_dp
  "Fixed flow resistance with dp and m_flow as parameter"
  extends IBPSA.Fluid.BaseClasses.PartialFixedResistance(
    final m_flow_turbulent=
        if computeFlowResistance then
          deltaM*m_flow_nominal_pos
        else 0);

  parameter Real deltaM(min=1e-5) = 0.3
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Evaluate=true, Dialog(enable=not use_dh and not linearized));
  annotation (
    defaultComponentName="res",
    Documentation(info="<html>
<p>
This is a model of a resistance with a fixed flow coefficient.
The mass flow rate is computed as
</p>
<p align=\"center\" style=\"font-style:italic;\">
m&#775; = k
&radic;<span style=\"text-decoration:overline;\">&Delta;P</span>,
</p>
<p>where <i>k</i> is a constant and <i>&Delta;P</i> is the pressure drop. 
The constant <i>k</i> is equal to <code>k=m_flow_nominal/sqrt(dp_nominal)</code>, 
where <code>m_flow_nominal</code> and <code>dp_nominal</code> are parameters. 
In the region <code>abs(m_flow) &LT; m_flow_turbulent</code>, the square root 
is replaced by a differentiable function with finite slope. The value of 
<code>m_flow_turbulent</code> is computed as  <code>m_flow_turbulent = deltaM 
* abs(m_flow_nominal)</code>, where <code>deltaM=0.3</code> and 
<code>m_flow_nominal</code> are parameters that can be set by the user. 
</p>

<p>
The figure below shows the pressure drop for the parameters
<code>m_flow_nominal=5</code> kg/s,
<code>dp_nominal=10</code> Pa and
<code>deltaM=0.3</code>.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://IBPSA/Resources/Images/Fluid/FixedResistances/FixedResistanceDpM.png\"/>
</p>
<p>
If the parameter
<code>show_T</code> is set to <code>true</code>,
then the model will compute the
temperature at its ports. Note that this can lead to state events
when the mass flow rate approaches zero,
which can increase computing time.
</p>
<p>
The parameter <code>from_dp</code> is used to determine
whether the mass flow rate is computed as a function of the
pressure drop (if <code>from_dp=true</code>), or vice versa.
This setting can affect the size of the nonlinear system of equations.
</p>
<p>
If the parameter <code>linearized</code> is set to <code>true</code>,
then the pressure drop is computed as a linear function of the
mass flow rate.
</p>
<p>
Setting <code>allowFlowReversal=false</code> can lead to simpler
equations. However, this should only be set to <code>false</code>
if one can guarantee that the flow never reverses its direction.
This can be difficult to guarantee, as pressure imbalance after
the initialization, or due to medium expansion and contraction,
can lead to reverse flow.
</p>
<h4>Notes</h4>
<p>
For more detailed models that compute the actual flow friction,
models from the package
<a href=\"modelica://Modelica.Fluid\">
Modelica.Fluid</a>
can be used and combined with models from the
<code>IBPSA</code> library.
</p>
<h4>Implementation</h4>
<p>
The pressure drop is computed by calling a function in the package
<a href=\"modelica://IBPSA.Fluid.BaseClasses.FlowModels\">
IBPSA.Fluid.BaseClasses.FlowModels</a>,
This package contains regularized implementations of the equation
</p>
<p align=\"center\" style=\"font-style:italic;\">
  m = sign(&Delta;p) k  &radic;<span style=\"text-decoration:overline;\">&nbsp;&Delta;p &nbsp;</span>
</p>
<p>
and its inverse function.
</p>
<p>
To decouple the energy equation from the mass equations,
the pressure drop is a function of the mass flow rate,
and not the volume flow rate.
This leads to simpler equations.
</p>
</html>", revisions="<html>
<ul>
<li>
July 8, 2016 by Bram van der Heijde:<br/>
Split off from <code>use_dh=false</code> part of <code>IBPSA.Fluid.FixedResistances.FixedResistanceDpM</code>. 
</li>
<li>
November 26, 2014, by Michael Wetter:<br/>
Added the required <code>annotation(Evaluate=true)</code> so
that the system of nonlinear equations in
<a href=\"modelica://IBPSA.Fluid.FixedResistances.Examples.FixedResistancesExplicit\">
IBPSA.Fluid.FixedResistances.Examples.FixedResistancesExplicit</a>
remains the same.
</li>
<li>
November 20, 2014, by Michael Wetter:<br/>
Rewrote the warning message using an <code>assert</code> with
<code>AssertionLevel.warning</code>
as this is the proper way to write warnings in Modelica.
</li>
<li>
August 5, 2014, by Michael Wetter:<br/>
Corrected error in documentation of computation of <code>k</code>.
</li>
<li>
May 29, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
October 8, 2013, by Michael Wetter:<br/>
Removed parameter <code>show_V_flow</code>.
</li>
<li>
December 14, 2012 by Michael Wetter:<br/>
Renamed protected parameters for consistency with the naming conventions.
</li>
<li>
January 16, 2012 by Michael Wetter:<br/>
To simplify object inheritance tree, revised base classes
<code>IBPSA.Fluid.BaseClasses.PartialResistance</code>,
<code>IBPSA.Fluid.Actuators.BaseClasses.PartialTwoWayValve</code>,
<code>IBPSA.Fluid.Actuators.BaseClasses.PartialDamperExponential</code>,
<code>IBPSA.Fluid.Actuators.BaseClasses.PartialActuator</code>
and model
<code>IBPSA.Fluid.FixedResistances.FixedResistanceDpM</code>.
</li>
<li>
May 30, 2008 by Michael Wetter:<br/>
Added parameters <code>use_dh</code> and <code>deltaM</code> for easier parameterization.
</li>
<li>
July 20, 2007 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
          extent={{-102,86},{-4,22}},
          lineColor={0,0,255},
          textString="dp_nominal=%dp_nominal"), Text(
          extent={{-106,106},{6,60}},
          lineColor={0,0,255},
          textString="m0=%m_flow_nominal"),
        Text(
          extent={{-24,6},{26,-8}},
          lineColor={255,255,255},
          textString="dp")}));
end FixedResistance_dp;
