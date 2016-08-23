within Annex60.Experimental.Pipe.Validation;
model ValidationMSLAIT
  "Validation pipe against data from Austrian Institute of Technology with standard library components"
extends Modelica.Icons.Example;

  Fluid.Sources.MassFlowSource_T Point1(
    redeclare package Medium = Medium,
    use_T_in=true,
    use_m_flow_in=true,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={82,-42})));
  package Medium = Annex60.Media.Water;
  Fluid.Sources.MassFlowSource_T Point4(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1)           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,70})));
  Fluid.Sources.MassFlowSource_T Point3(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=2)           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-46,-50})));
  Fluid.Sources.MassFlowSource_T Point2(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1)           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-70,70})));
  Modelica.Blocks.Sources.CombiTimeTable DataReader(table=pipeDataAIT151218.data)
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Data.PipeDataAIT151218 pipeDataAIT151218
    annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
  Modelica.Blocks.Sources.RealExpression m_flow_p3(y=-DataReader.y[7])
    annotation (Placement(transformation(extent={{-100,-80},{-60,-60}})));
  Modelica.Blocks.Sources.RealExpression m_flow_p4(y=-DataReader.y[8])
    annotation (Placement(transformation(extent={{64,80},{24,100}})));
  Modelica.Blocks.Sources.RealExpression m_flow_p2(y=-DataReader.y[6])
    annotation (Placement(transformation(extent={{-16,80},{-56,100}})));
  Modelica.Blocks.Sources.RealExpression T_p1(y=DataReader.y[1])
    annotation (Placement(transformation(extent={{18,-74},{58,-54}})));
  Fluid.Sensors.Temperature senTem_p3(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-70,-32},{-90,-12}})));
  Fluid.Sensors.Temperature senTem_p2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Fluid.Sensors.Temperature senTem_p4(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{30,56},{50,76}})));
  Fluid.Sensors.Temperature senTem_p1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-20})));
  Fluid.Sources.FixedBoundary ExcludedBranch(          redeclare package Medium
      = Medium, nPorts=2)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,70})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  Fluid.Sensors.Temperature senTemIn_p2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  parameter Modelica.SIunits.Length Lcap=1
    "Length over which transient effects typically take place";
  parameter Boolean pipVol=true
    "Flag to decide whether volumes are included at the end points of the pipe";
  parameter Boolean allowFlowReversal=false
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)";
  Modelica.Fluid.Pipes.DynamicPipe MSLpip0(
    nParallel=1,
    diameter=0.0825,
    redeclare package Medium = Medium,
    use_HeatTransfer=true,
    length=20,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    nNodes=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,-10})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  parameter Types.ThermalResistanceLength R=1/(lambdaI*2*Modelica.Constants.pi
      /Modelica.Math.log((diameter/2 + thicknessIns)/(diameter/2)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=R/
        MSLpip0.length)
    annotation (Placement(transformation(extent={{120,-20},{140,0}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=
        MSLpip0.nNodes) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={102,-10})));
  Modelica.Fluid.Pipes.DynamicPipe MSLpip1(
    nParallel=1,
    diameter=0.0825,
    redeclare package Medium = Medium,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    nNodes=10,
    length=115) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={38,10})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector1(m=
       MSLpip1.nNodes) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor1(R=R/
        MSLpip1.length)
    annotation (Placement(transformation(extent={{68,20},{88,40}})));
  Modelica.Fluid.Pipes.DynamicPipe MSLpip2(
    nParallel=1,
    redeclare package Medium = Medium,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    nNodes=10,
    length=76,
    diameter=diameter)
               annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-70,40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector2(m=
       MSLpip2.nNodes) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,34})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor2(R=R/
        MSLpip2.length)
    annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
  Modelica.Fluid.Pipes.DynamicPipe MSLpip3(
    nParallel=1,
    diameter=0.0825,
    redeclare package Medium = Medium,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    nNodes=10,
    length=38) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-46,-12})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector3(m=
       MSLpip3.nNodes) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-28,-12})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor3(R=R/
        MSLpip3.length) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-30})));
  Modelica.Fluid.Pipes.DynamicPipe MSLpip4(
    nParallel=1,
    diameter=0.0825,
    redeclare package Medium = Medium,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    nNodes=10,
    length=29) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={10,40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector4(m=
       MSLpip4.nNodes) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-4,76})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor4(R=R/
        MSLpip4.length) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-4,104})));
  Modelica.Fluid.Pipes.DynamicPipe MSLpip5(
    nParallel=1,
    diameter=0.0825,
    redeclare package Medium = Medium,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    nNodes=10,
    length=20) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-10,10})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector5(m=
       MSLpip5.nNodes) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-36,120})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor5(R=R/
        MSLpip5.length)
    annotation (Placement(transformation(extent={{-28,124},{-8,144}})));
  parameter Modelica.SIunits.ThermalConductivity lambdaI=0.024
    "Heat conductivity";
  parameter Modelica.SIunits.Length thicknessIns=0.045
    "Thickness of pipe insulation";
  parameter Modelica.SIunits.Diameter diameter=0.085
    "Diameter of circular pipe";
equation
  connect(m_flow_p3.y, Point3.m_flow_in) annotation (Line(
      points={{-58,-70},{-54,-70},{-54,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Point2.m_flow_in, m_flow_p2.y) annotation (Line(
      points={{-62,80},{-62,90},{-58,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Point4.m_flow_in, m_flow_p4.y) annotation (Line(
      points={{18,80},{18,90},{22,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_p1.y, Point1.T_in) annotation (Line(
      points={{60,-64},{78,-64},{78,-54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(DataReader.y[5], Point1.m_flow_in) annotation (Line(
      points={{21,-90},{26,-90},{26,-72},{74,-72},{74,-52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(DataReader.y[9], prescribedTemperature.T)
    annotation (Line(points={{21,-90},{30,-90},{38,-90}}, color={0,0,127}));
  connect(senTem_p1.port, MSLpip0.port_a)
    annotation (Line(points={{60,-20},{70,-20},{80,-20}}, color={0,127,255}));
  connect(MSLpip0.port_a, Point1.ports[1])
    annotation (Line(points={{80,-20},{80,-32},{82,-32}}, color={0,127,255}));
  connect(MSLpip0.port_b, ExcludedBranch.ports[1])
    annotation (Line(points={{80,0},{80,60},{82,60}},      color={0,127,255}));
  connect(prescribedTemperature.port, thermalResistor.port_b) annotation (Line(
        points={{60,-90},{60,-90},{146,-90},{146,-10},{140,-10}}, color={191,0,0}));
  connect(MSLpip0.heatPorts, thermalCollector.port_a) annotation (Line(points={{
          84.4,-9.9},{92,-9.9},{92,-10}}, color={127,0,0}));
  connect(thermalResistor.port_a, thermalCollector.port_b)
    annotation (Line(points={{120,-10},{116,-10},{112,-10}}, color={191,0,0}));
  connect(thermalCollector1.port_b, thermalResistor1.port_a)
    annotation (Line(points={{60,30},{68,30}}, color={191,0,0}));
  connect(MSLpip1.heatPorts, thermalCollector1.port_a) annotation (Line(points={
          {37.9,14.4},{37.9,30.2},{40,30.2},{40,30}}, color={127,0,0}));
  connect(thermalResistor1.port_b, thermalResistor.port_b) annotation (Line(
        points={{88,30},{146,30},{146,-10},{140,-10}}, color={191,0,0}));
  connect(MSLpip1.port_a, ExcludedBranch.ports[2])
    annotation (Line(points={{48,10},{78,10},{78,60}}, color={0,127,255}));
  connect(senTem_p2.port, MSLpip2.port_b)
    annotation (Line(points={{-40,50},{-70,50}}, color={0,127,255}));
  connect(MSLpip2.port_b, Point2.ports[1])
    annotation (Line(points={{-70,50},{-70,60}}, color={0,127,255}));
  connect(senTemIn_p2.port, MSLpip2.port_a) annotation (Line(points={{-90,10},{-84,
          10},{-70,10},{-70,30}}, color={0,127,255}));
  connect(thermalCollector2.port_a, MSLpip2.heatPorts) annotation (Line(points={
          {-60,34},{-65.6,34},{-65.6,40.1}}, color={191,0,0}));
  connect(thermalCollector2.port_b, thermalResistor2.port_a)
    annotation (Line(points={{-40,34},{-40,34}}, color={191,0,0}));
  connect(thermalResistor2.port_b, thermalResistor.port_b) annotation (Line(
        points={{-20,34},{-16,34},{-16,124},{-12,124},{146,124},{146,-10},{140,-10}},
        color={191,0,0}));
  connect(MSLpip3.port_b, Point3.ports[1]) annotation (Line(points={{-46,-22},{-46,
          -40},{-48,-40}}, color={0,127,255}));
  connect(senTem_p3.port, Point3.ports[2]) annotation (Line(points={{-80,-32},{-44,
          -32},{-44,-40}}, color={0,127,255}));
  connect(MSLpip3.port_a, MSLpip2.port_a) annotation (Line(points={{-46,-2},{-46,
          10},{-70,10},{-70,30}}, color={0,127,255}));
  connect(MSLpip3.heatPorts, thermalCollector3.port_a) annotation (Line(points={
          {-41.6,-12.1},{-40,-12.1},{-40,-12},{-38,-12}}, color={127,0,0}));
  connect(thermalCollector3.port_b, thermalResistor3.port_a)
    annotation (Line(points={{-18,-12},{-10,-12},{-10,-20}}, color={191,0,0}));
  connect(thermalResistor3.port_b, thermalResistor.port_b) annotation (Line(
        points={{-10,-40},{-10,-54},{146,-54},{146,-10},{140,-10}}, color={191,0,
          0}));
  connect(Point4.ports[1], MSLpip4.port_b)
    annotation (Line(points={{10,60},{10,55},{10,50}}, color={0,127,255}));
  connect(senTem_p4.port, MSLpip4.port_b)
    annotation (Line(points={{40,56},{10,56},{10,50}}, color={0,127,255}));
  connect(thermalCollector4.port_a, MSLpip4.heatPorts)
    annotation (Line(points={{-4,66},{-4,40.1},{5.6,40.1}}, color={191,0,0}));
  connect(thermalResistor4.port_a, thermalCollector4.port_b)
    annotation (Line(points={{-4,94},{-4,86}}, color={191,0,0}));
  connect(thermalResistor4.port_b, thermalResistor.port_b) annotation (Line(
        points={{-4,114},{-4,124},{146,124},{146,-10},{140,-10}}, color={191,0,0}));
  connect(MSLpip4.port_a, MSLpip1.port_b)
    annotation (Line(points={{10,30},{10,10},{28,10}}, color={0,127,255}));
  connect(MSLpip5.port_a, MSLpip1.port_b)
    annotation (Line(points={{0,10},{28,10}}, color={0,127,255}));
  connect(MSLpip5.port_b, MSLpip2.port_a)
    annotation (Line(points={{-20,10},{-70,10},{-70,30}}, color={0,127,255}));
  connect(thermalCollector5.port_a, MSLpip5.heatPorts) annotation (Line(points={
          {-36,110},{-36,110},{-36,64},{-12,64},{-12,14.4},{-10.1,14.4}}, color=
         {191,0,0}));
  connect(thermalCollector5.port_b, thermalResistor5.port_a)
    annotation (Line(points={{-36,130},{-36,134},{-28,134}}, color={191,0,0}));
  connect(thermalResistor5.port_b, thermalResistor.port_b) annotation (Line(
        points={{-8,134},{30,134},{30,124},{146,124},{146,-10},{140,-10}},
        color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=603900),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>The example contains <a href=\"modelica://Annex60.Experimental.Pipe.Data.PipeDataAIT151218\">experimental data</a> from a real district heating network. This data is used to validate a pipe model.</p>
<p>Pipes&apos; temperatures are not initialized, thus results of outflow temperature before apprixmately the first 10000 seconds should no be considered. </p>
<p><b><span style=\"color: #008000;\">Test bench schematic</span></b> </p>
<p><img src=\"modelica://Annex60/Resources/Images/Experimental/AITTestBench.png\"/> </p>
<p><b><span style=\"color: #008000;\">Calibration</span></b> </p>
<p>To calculate the length specific thermal resistance <code><span style=\"font-family: Courier New,courier;\">R</span></code> of the pipe, the thermal resistance of the surrounding ground is added. </p>
<p><code><span style=\"font-family: Courier New,courier;\">R=1/(0.208)+1/(2*lambda_g*Modelica.Constants.pi)*log(1/0.18)</span></code> </p>
<p>Where the thermal conductivity of the ground <code><span style=\"font-family: Courier New,courier;\">lambda_g = 2.4 </span></code>W/mK. </p>
<p><br><h4><span style=\"color: #008000\">Testing spatialDistribution influence on non-linear systems</span></h4></p>
<p>The model contains two parameters on the top level:</p>
<p><code><span style=\"font-family: Courier New,courier; color: #0000ff;\">parameter&nbsp;</span><span style=\"color: #ff0000;\">Boolean</span>&nbsp;pipVol=false&nbsp;</p><p><span style=\"font-family: Courier New,courier; color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;&QUOT;Flag&nbsp;to&nbsp;decide&nbsp;whether&nbsp;volumes&nbsp;are&nbsp;included&nbsp;at&nbsp;the&nbsp;end&nbsp;points&nbsp;of&nbsp;the&nbsp;pipe&QUOT;</span>;</code></p>
<p><code><span style=\"font-family: Courier New,courier; color: #0000ff;\">parameter&nbsp;</span><span style=\"color: #ff0000;\">Boolean</span>&nbsp;allowFlowReversal=true&nbsp;</code></p>
<p><code><span style=\"font-family: Courier New,courier; color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;&QUOT;=&nbsp;true&nbsp;to&nbsp;allow&nbsp;flow&nbsp;reversal,&nbsp;false&nbsp;restricts&nbsp;to&nbsp;design&nbsp;direction&nbsp;(port_a&nbsp;-&GT;&nbsp;port_b)&QUOT;</span>;</code></p>
<p><br><code><span style=\"font-family: Courier New,courier;\">pipVol </span></code>controls the presence of two additional mixing volumes at the in/outlets of <code><span style=\"font-family: Courier New,courier;\">PipeAdiabaticPlugFlow.</span></code> <code><span style=\"font-family: Courier New,courier;\">allowFlowReversal</span></code> controls whether flow reversal is allowed in the same component.</p>
<p><br>Below, the model translation statistics for different combinations of these parameters are presented:</p>
<p style=\"margin-left: 30px;\"><br><h4>pipVol=true, allowFlowReversal=true</h4></p>
<p style=\"margin-left: 30px;\">Translated Model</p>
<p style=\"margin-left: 30px;\">Constants: 1090 scalars</p>
<p style=\"margin-left: 30px;\">Free parameters: 6981 scalars</p>
<p style=\"margin-left: 30px;\">Parameter depending: 6928 scalars</p>
<p style=\"margin-left: 30px;\">Continuous time states: 30 scalars</p>
<p style=\"margin-left: 30px;\">Time-varying variables: 524 scalars</p>
<p style=\"margin-left: 30px;\">Alias variables: 616 scalars</p>
<p style=\"margin-left: 30px;\">Assumed default initial conditions: 66</p>
<p style=\"margin-left: 30px;\">Number of mixed real/discrete systems of equations: 0</p>
<p style=\"margin-left: 30px;\">Sizes of linear systems of equations: { }</p>
<p style=\"margin-left: 30px;\">Sizes after manipulation of the linear systems: { }</p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Sizes of nonlinear systems of equations: { }</span></h4></p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Sizes after manipulation of the nonlinear systems: { }</span></h4></p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Number of numerical Jacobians: 0</span></h4></p>
<p style=\"margin-left: 30px;\"><br><h4>pipVol=false, allowFlowReversal=true</h4></p>
<p style=\"margin-left: 30px;\">Translated Model</p>
<p style=\"margin-left: 30px;\">Constants: 500 scalars</p>
<p style=\"margin-left: 30px;\">Free parameters: 6946 scalars</p>
<p style=\"margin-left: 30px;\">Parameter depending: 6863 scalars</p>
<p style=\"margin-left: 30px;\">Continuous time states: 18 scalars</p>
<p style=\"margin-left: 30px;\">Time-varying variables: 409 scalars</p>
<p style=\"margin-left: 30px;\">Alias variables: 364 scalars</p>
<p style=\"margin-left: 30px;\">Assumed default initial conditions: 54</p>
<p style=\"margin-left: 30px;\">Number of mixed real/discrete systems of equations: 0</p>
<p style=\"margin-left: 30px;\">Sizes of linear systems of equations: { }</p>
<p style=\"margin-left: 30px;\">Sizes after manipulation of the linear systems: { }</p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Sizes of nonlinear systems of equations: {44}</span></h4></p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Sizes after manipulation of the nonlinear systems: {5}</span></h4></p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Number of numerical Jacobians: 1</span></h4></p>
<p style=\"margin-left: 30px;\"><br><h4>pipVol=false, allowFlowReversal=false</h4></p>
<p style=\"margin-left: 30px;\">Translated Model</p>
<p style=\"margin-left: 30px;\">Constants: 500 scalars</p>
<p style=\"margin-left: 30px;\">Free parameters: 6946 scalars</p>
<p style=\"margin-left: 30px;\">Parameter depending: 6866 scalars</p>
<p style=\"margin-left: 30px;\">Continuous time states: 18 scalars</p>
<p style=\"margin-left: 30px;\">Time-varying variables: 399 scalars</p>
<p style=\"margin-left: 30px;\">Alias variables: 371 scalars</p>
<p style=\"margin-left: 30px;\">Assumed default initial conditions: 54</p>
<p style=\"margin-left: 30px;\">Number of mixed real/discrete systems of equations: 0</p>
<p style=\"margin-left: 30px;\">Sizes of linear systems of equations: { }</p>
<p style=\"margin-left: 30px;\">Sizes after manipulation of the linear systems: { }</p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Sizes of nonlinear systems of equations: {5, 5}</span></h4></p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Sizes after manipulation of the nonlinear systems: {1, 1}</span></h4></p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Number of numerical Jacobians: 2</span></h4></p>
<p style=\"margin-left: 30px;\"><br><h4>pipVol=true, allowFlowReversal=false</h4></p>
<p style=\"margin-left: 30px;\">Translated Model</p>
<p style=\"margin-left: 30px;\">Constants: 1090 scalars</p>
<p style=\"margin-left: 30px;\">Free parameters: 6981 scalars</p>
<p style=\"margin-left: 30px;\">Parameter depending: 6932 scalars</p>
<p style=\"margin-left: 30px;\">Continuous time states: 30 scalars</p>
<p style=\"margin-left: 30px;\">Time-varying variables: 513 scalars</p>
<p style=\"margin-left: 30px;\">Alias variables: 623 scalars</p>
<p style=\"margin-left: 30px;\">Assumed default initial conditions: 66</p>
<p style=\"margin-left: 30px;\">Number of mixed real/discrete systems of equations: 0</p>
<p style=\"margin-left: 30px;\">Sizes of linear systems of equations: { }</p>
<p style=\"margin-left: 30px;\">Sizes after manipulation of the linear systems: { }</p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Sizes of nonlinear systems of equations: { }</span></h4></p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Sizes after manipulation of the nonlinear systems: { }</span></h4></p>
<p style=\"margin-left: 30px;\"><h4><span style=\"color: #008000\">Number of numerical Jacobians: 0</span></h4></p>
<p><br>It seems that when the solver has to account for the possibility of flow reversal (aFV=true) and the model includes no additional state for the water in the pipe (pipVol = false), very large nonlinear systems appear when translating. However, the advection equation, implemented by the <code><span style=\"font-family: Courier New,courier;\">spatialDistribution</span></code> function should inherently introduce a state. This state is clearly not recognized by the model translator. We see that if additional volumes are introduced, or if flow reversal is disabled the non-linear system is smaller or entirely eliminated. </p>
</html>", revisions="<html>
<ul>
<li>July 4, 2016 by Bram van der Heijde:<br>Added parameters to test the influence of allowFlowReversal and the presence of explicit volumes in the pipe.</li>
<li>January 26, 2016 by Carles Ribas:<br>First implementation. </li>
</ul>
</html>"), __Dymola_Commands(file=
          "modelica://Annex60/Resources/Scripts/Dymola/Experimental/Pipe/Validation/ValidationMSLAIT.mos"
        "Simulate and plot"));
end ValidationMSLAIT;