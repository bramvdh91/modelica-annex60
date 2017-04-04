within IBPSA.Experimental.Pipe.Examples.UseCases.TypeA_NoFlowReversal;
model UCPipeA01AD_MSL_Basic "Demonstrating basic functionality of pipe model"

  extends Modelica.Icons.Example;

  package Medium = IBPSA.Media.Water;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.9
    "Nominal mass flow rate";

  parameter Modelica.SIunits.Pressure dp_test = 200
    "Differential pressure for the test used in ramps";

  Modelica.Blocks.Sources.Constant PAtm(k=101325) "Atmospheric pressure"
      annotation (Placement(transformation(extent={{126,66},{146,86}})));
  Fluid.Sources.Boundary_pT source(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    nPorts=1,
    T=293.15) "Source with high pressure during experiment"
    annotation (Placement(transformation(extent={{-88,18},{-68,38}})));
  Fluid.Sources.Boundary_pT         sink(          redeclare package Medium =
        Medium,
    nPorts=1,
    use_p_in=true,
    T=283.15) "Sink at with constant pressure"
                          annotation (Placement(transformation(extent={{140,18},
            {120,38}})));
  Fluid.Sensors.MassFlowRate         masFloSer(redeclare package Medium =
        Medium) "Mass flow rate sensor for the two pipes in series"
    annotation (Placement(transformation(extent={{88,20},{108,40}})));
  Modelica.Blocks.Sources.Constant constTemp(k=273.15 + 60)
    "Constant supply temperature signal"
    annotation (Placement(transformation(extent={{-118,0},{-98,20}})));
  Modelica.Blocks.Sources.Constant constDP(k=dp_test)
    "Add pressure difference between source and sink"
    annotation (Placement(transformation(extent={{-156,30},{-136,50}})));
  Modelica.Blocks.Math.Add add "Combine input signal of two ramps"
    annotation (Placement(transformation(extent={{-118,50},{-98,70}})));
  Fluid.Sensors.TemperatureTwoPort TempSink(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal) "Temperature at the pipe's sink side"
    annotation (Placement(transformation(extent={{56,20},{76,40}})));
  Fluid.Sensors.TemperatureTwoPort TempSource(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal) "Temperature at the pipe's source side"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeMSL(
    nNodes=10,
    redeclare package Medium = Medium,
    length=100,
    diameter=0.1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    flowModel(
    m_flow_small =         1e-4),
    T_start=293.15) "Dynamic pipe from MSL for reference test"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  inner Modelica.Fluid.System system "System for MSL pipe model"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
equation
  connect(PAtm.y,sink. p_in)
                            annotation (Line(points={{147,76},{154,76},{154,36},
          {142,36}},
                   color={0,0,127}));
  connect(sink.ports[1],masFloSer. port_b) annotation (Line(
      points={{120,28},{108,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(constTemp.y, source.T_in) annotation (Line(
      points={{-97,10},{-90,10},{-90,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(constDP.y, add.u2) annotation (Line(
      points={{-135,40},{-128,40},{-128,54},{-120,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, source.p_in) annotation (Line(
      points={{-97,60},{-94,60},{-94,36},{-90,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(masFloSer.port_a, TempSink.port_b) annotation (Line(
      points={{88,30},{76,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source.ports[1], TempSource.port_a) annotation (Line(
      points={{-68,28},{-60,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(PAtm.y, add.u1) annotation (Line(points={{147,76},{154,76},{154,100},{
          -128,100},{-128,66},{-120,66}}, color={0,0,127}));
  connect(TempSource.port_b, pipeMSL.port_a)
    annotation (Line(points={{-40,30},{0,30}}, color={0,127,255}));
  connect(pipeMSL.port_b, TempSink.port_a)
    annotation (Line(points={{20,30},{56,30}}, color={0,127,255}));
  annotation (Documentation(info="<html>
<p>This use case aims at demonstrating most basic functionalities of the pipe
model. The pressure difference between <code>source</code> and <code>sink</code> is kept constant, as
is the supply temperature at <code>source</code>.</p>
<p>The main focus of this use case is that the model checks <code>True</code> in pedantic mode
and simulates without warnings or errors.</p>
<h4 id=\"typical-use-and-important-parameters\">Typical use and important parameters</h4>
<p>The pressure difference between <code>source</code> and <code>sink</code> can be adjusted via the
<code>dp_test</code> variable.</p>
<h4 id=\"implementation\">Implementation</h4>
<p>In order for the MSL pipe model to check <code>True</code> in pedantic mode and simulate
without warnings, the following modifications have been added:</p>
<ul>
<li><code>energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial</code> to fix the initial
temperature values</li>
<li><code>flowModel(m_flow_small = 1e-4)</code> and <code>T_start=293.15</code> to avoid Dymola errors
regarding circular references for the start temperature and <code>m_flow_small</code> via
the <code>system</code> component</li>
</ul>
</html>", revisions="<html>
<ul>
<li>May 18, 2016 by Marcus Fuchs: <br>
First implementation</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-180,-120},{180,120}},
          preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-180,-120},{180,120}})),
    experiment(StopTime=2000, Interval=1),
    __Dymola_experimentSetupOutput);
end UCPipeA01AD_MSL_Basic;
