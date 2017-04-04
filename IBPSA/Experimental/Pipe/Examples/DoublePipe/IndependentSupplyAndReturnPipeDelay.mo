within IBPSA.Experimental.Pipe.Examples.DoublePipe;
model IndependentSupplyAndReturnPipeDelay
  "Example in which supply and return circuit are hydraulically separated and delay time is calculated once at pipe level"
  import IBPSA;
  extends Modelica.Icons.Example;

  package Medium = IBPSA.Media.Water;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.5
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dp_test=200;

  Fluid.Sources.Boundary_pT supplySource(redeclare package Medium = Medium,
      use_p_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

  Fluid.Sources.Boundary_pT supplySink(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Fluid.Sources.Boundary_pT returnSink(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Fluid.Sources.Boundary_pT returnSource(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  IBPSA.Experimental.Pipe.DoublePipe_PipeDelay
                                       doublePipe(
    redeclare package Medium = Medium,
    length=100,
    H=2,
    redeclare
      IBPSA.Experimental.Pipe.BaseClasses.DoublePipeConfig.IsoPlusDoubleStandard.IsoPlusDR150S
      pipeData,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant PAtm(k=101325) "Atmospheric pressure"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,10})));
  Modelica.Blocks.Sources.Constant TSupply(k=273.15 + 45)
    "Atmospheric pressure" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,50})));
  Modelica.Blocks.Sources.Constant TReturn(k=273.15 + 30)
    "Atmospheric pressure" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-170,-50})));
  Modelica.Blocks.Math.Gain gain(k=dp_test)
    annotation (Placement(transformation(extent={{-156,16},{-136,36}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,38})));
  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-22})));

  IBPSA.Fluid.Sensors.TemperatureTwoPort senTemSupplyIn(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort senTemReturnOut(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,-30})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort senTemSupplyOut(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{30,20},{50,40}})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort senTemReturnIn(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,-30})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, table=[0,
        1; 3000,1; 5000,0; 10000,0; 12000,-1; 17000,-1; 19000,0; 30000,0;
        30010,-0.1; 50000,-0.1; 50010,0; 80000,0; 82000,-1; 100000,-1; 102000,
        0; 150000,0; 152000,1; 160000,1; 162000,0; 163500,0; 165500,1; 200000,
        1])
    annotation (Placement(transformation(extent={{-188,16},{-168,36}})));
  Modelica.Blocks.Sources.Constant TSupply1(k=273.15 + 55)
    "Atmospheric pressure" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-170,70})));
  Modelica.Blocks.Sources.Constant TReturn1(k=273.15 + 25)
    "Atmospheric pressure" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,-50})));
  IBPSA.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-30,46},{-10,66}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        278.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,90})));
equation
  connect(PAtm.y, supplySink.p_in) annotation (Line(points={{99,10},{92,10},{92,
          38},{82,38}}, color={0,0,127}));
  connect(PAtm.y, returnSource.p_in) annotation (Line(points={{99,10},{92,10},{
          92,-22},{82,-22}},
                          color={0,0,127}));
  connect(TSupply.y, supplySink.T_in) annotation (Line(points={{99,50},{96,50},
          {96,34},{82,34}}, color={0,0,127}));
  connect(TReturn.y, returnSink.T_in) annotation (Line(points={{-159,-50},{-159,
          -50},{-90,-50},{-90,-26},{-82,-26}},
                           color={0,0,127}));
  connect(gain.y,add. u2)
    annotation (Line(points={{-135,26},{-126,26},{-126,32},{-122,32}},
                                                          color={0,0,127}));
  connect(add.y, supplySource.p_in)
    annotation (Line(points={{-99,38},{-99,38},{-82,38}}, color={0,0,127}));
  connect(gain.y, add1.u1) annotation (Line(points={{-135,26},{-126,26},{-126,
          -16},{-122,-16}},
                      color={0,0,127}));
  connect(PAtm.y, add.u1) annotation (Line(points={{99,10},{92,10},{92,68},{
          -130,68},{-130,44},{-122,44}},
                                    color={0,0,127}));
  connect(add1.u2, add.u1) annotation (Line(points={{-122,-28},{-130,-28},{-130,
          44},{-122,44}},
                      color={0,0,127}));
  connect(returnSink.ports[1], senTemReturnOut.port_b) annotation (Line(points=
          {{-60,-30},{-55,-30},{-50,-30}}, color={0,127,255}));
  connect(senTemReturnOut.port_a, doublePipe.port_b2) annotation (Line(points={
          {-30,-30},{-20,-30},{-20,-6},{-10,-6}}, color={0,127,255}));
  connect(supplySource.ports[1], senTemSupplyIn.port_a)
    annotation (Line(points={{-60,30},{-50,30},{-50,30}}, color={0,127,255}));
  connect(doublePipe.port_b1, senTemSupplyOut.port_a) annotation (Line(points={
          {10,6},{20,6},{20,30},{30,30}}, color={0,127,255}));
  connect(senTemSupplyOut.port_b, supplySink.ports[1])
    annotation (Line(points={{50,30},{55,30},{60,30}}, color={0,127,255}));
  connect(doublePipe.port_a2, senTemReturnIn.port_b) annotation (Line(points={{
          10,-6},{20,-6},{20,-30},{30,-30}}, color={0,127,255}));
  connect(senTemReturnIn.port_a, returnSource.ports[1])
    annotation (Line(points={{50,-30},{55,-30},{60,-30}}, color={0,127,255}));
  connect(add1.y, returnSink.p_in)
    annotation (Line(points={{-99,-22},{-82,-22},{-82,-22}}, color={0,0,127}));
  connect(gain.u, combiTimeTable.y[1])
    annotation (Line(points={{-158,26},{-167,26}}, color={0,0,127}));
  connect(TSupply1.y, supplySource.T_in) annotation (Line(points={{-159,70},{
          -90,70},{-90,34},{-82,34}}, color={0,0,127}));
  connect(TReturn1.y, returnSource.T_in) annotation (Line(points={{99,-50},{86,
          -50},{86,-26},{82,-26}}, color={0,0,127}));
  connect(senTemSupplyIn.port_b, senMasFlo.port_a)
    annotation (Line(points={{-30,30},{-30,30},{-30,56}}, color={0,127,255}));
  connect(doublePipe.port_a1, senMasFlo.port_b)
    annotation (Line(points={{-10,6},{-10,6},{-10,56}}, color={0,127,255}));
  connect(fixedTemperature.port, doublePipe.heatPort)
    annotation (Line(points={{0,80},{0,45},{0,10}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{140,100}})),
    Icon(coordinateSystem(extent={{-200,-100},{140,100}})),
    experiment(StopTime=200000),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Experimental/Pipe/Examples/DoublePipe/IndependentSupplyAndReturnPipeDelay.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>Example in which the mass flow through a double pipe is not physically looped. The supply and return side are two hydraulically separated circuits, but with equal mass flow rate. </p>
</html>", revisions="<html>
<ul>
<li>February 15, 2016 by Bram van der Heijde:<br>Revision of documentation, added simulate and plot command</li>
<li></li>
</ul>
</html>"));
end IndependentSupplyAndReturnPipeDelay;
