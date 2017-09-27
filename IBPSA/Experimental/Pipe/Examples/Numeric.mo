within IBPSA.Experimental.Pipe.Examples;
package Numeric

  model testNumeric2
    package Medium = IBPSA.Media.Water;

    IBPSA.Fluid.Sources.Boundary_pT
                              source(
      redeclare package Medium = Medium,
      use_p_in=true,
      use_T_in=false,
      T=303.15,
      nPorts=2) "Source with high pressure during experiment"
      annotation (Placement(transformation(extent={{-78,28},{-58,48}})));
    IBPSA.Fluid.Sources.Boundary_pT
                              source1(
      redeclare package Medium = Medium,
      use_p_in=true,
      use_T_in=false,
      T=303.15,
      nPorts=2) "Source with high pressure during experiment"
      annotation (Placement(transformation(extent={{90,26},{70,46}})));
    Modelica.Blocks.Sources.Constant constDP(k=4e5)
      "Add pressure difference between source and sink"
      annotation (Placement(transformation(extent={{-148,38},{-128,58}})));
    Modelica.Blocks.Sources.Constant constDP1(k=3e5)
      "Add pressure difference between source and sink"
      annotation (Placement(transformation(extent={{122,46},{142,66}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=291.15)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-24,80})));
    PipeHeatLossMod pipeHeatLossMod(
      diameter=0.1,
      length=300,
      thicknessIns=0.5,
      m_flow_nominal=10,
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-24,30},{-4,50}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(
                                                                            T=291.15)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={24,84})));
    PipeHeatLossMod pipeHeatLossMod1(
      diameter=0.1,
      length=300,
      thicknessIns=0.5,
      m_flow_nominal=10,
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{24,34},{44,54}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(
                                                                            T=291.15)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,2})));
    PipeHeatLossMod pipeHeatLossMod2(
      diameter=0.1,
      length=300,
      thicknessIns=0.5,
      m_flow_nominal=10,
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-48},{0,-28}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature3(
                                                                            T=291.15)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={28,6})));
    PipeHeatLossMod pipeHeatLossMod3(
      diameter=0.1,
      length=300,
      thicknessIns=0.5,
      m_flow_nominal=10,
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{28,-44},{48,-24}})));
  equation
    connect(constDP.y, source.p_in)
      annotation (Line(points={{-127,48},{-80,48},{-80,46}}, color={0,0,127}));
    connect(constDP1.y, source1.p_in) annotation (Line(points={{143,56},{122,56},{
            122,86},{92,86},{92,44}}, color={0,0,127}));
    connect(source.ports[1], pipeHeatLossMod.port_a) annotation (Line(points={{-58,40},
            {-40,40},{-40,40},{-24,40}},     color={0,127,255}));
    connect(fixedTemperature.port, pipeHeatLossMod.heatPort) annotation (Line(
          points={{-24,70},{-18,70},{-18,50},{-14,50}}, color={191,0,0}));
    connect(fixedTemperature1.port, pipeHeatLossMod1.heatPort) annotation (Line(
          points={{24,74},{30,74},{30,54},{34,54}}, color={191,0,0}));
    connect(pipeHeatLossMod.port_b, pipeHeatLossMod1.port_a) annotation (Line(
          points={{-4,40},{10,40},{10,44},{24,44}}, color={0,127,255}));
    connect(pipeHeatLossMod1.port_b, source1.ports[1]) annotation (Line(points=
            {{44,44},{58,44},{58,38},{70,38}}, color={0,127,255}));
    connect(fixedTemperature2.port, pipeHeatLossMod2.heatPort) annotation (Line(
          points={{-20,-8},{-14,-8},{-14,-28},{-10,-28}}, color={191,0,0}));
    connect(pipeHeatLossMod2.port_b, pipeHeatLossMod3.port_a) annotation (Line(
          points={{0,-38},{14,-38},{14,-34},{28,-34}}, color={0,127,255}));
    connect(source.ports[2], pipeHeatLossMod2.port_a) annotation (Line(points={
            {-58,36},{-38,36},{-38,-38},{-20,-38}}, color={0,127,255}));
    connect(pipeHeatLossMod3.port_b, source1.ports[2]) annotation (Line(points=
            {{48,-34},{60,-34},{60,34},{70,34}}, color={0,127,255}));
    connect(fixedTemperature3.port, pipeHeatLossMod3.heatPort) annotation (Line(
          points={{28,-4},{34,-4},{34,-24},{38,-24}}, color={191,0,0}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),
      experiment(StopTime=1000),
      __Dymola_experimentSetupOutput);
  end testNumeric2;

  model testNumeric
    package Medium = IBPSA.Media.Water;

    IBPSA.Fluid.Sources.Boundary_pT
                              source(
      redeclare package Medium = Medium,
      use_p_in=true,
      use_T_in=false,
      T=303.15,
      nPorts=1) "Source with high pressure during experiment"
      annotation (Placement(transformation(extent={{-78,28},{-58,48}})));
    IBPSA.Fluid.Sources.Boundary_pT
                              source1(
      redeclare package Medium = Medium,
      use_p_in=true,
      use_T_in=false,
      T=303.15,
      nPorts=1) "Source with high pressure during experiment"
      annotation (Placement(transformation(extent={{90,26},{70,46}})));
    Modelica.Blocks.Sources.Constant constDP1(k=3e5)
      "Add pressure difference between source and sink"
      annotation (Placement(transformation(extent={{122,46},{142,66}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=291.15)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-24,80})));
    PipeHeatLossMod pipeHeatLossMod(
      diameter=0.1,
      length=300,
      thicknessIns=0.5,
      m_flow_nominal=10,
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-24,30},{-4,50}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=1e5,
      duration=10,
      offset=3e5,
      startTime=10)
      annotation (Placement(transformation(extent={{-132,30},{-112,50}})));
  equation
    connect(constDP1.y, source1.p_in) annotation (Line(points={{143,56},{122,56},{
            122,86},{92,86},{92,44}}, color={0,0,127}));
    connect(source.ports[1], pipeHeatLossMod.port_a) annotation (Line(points={{-58,
            38},{-40,38},{-40,40},{-24,40}}, color={0,127,255}));
    connect(pipeHeatLossMod.port_b, source1.ports[1]) annotation (Line(points={{-4,
            40},{34,40},{34,36},{70,36}}, color={0,127,255}));
    connect(fixedTemperature.port, pipeHeatLossMod.heatPort) annotation (Line(
          points={{-24,70},{-18,70},{-18,50},{-14,50}}, color={191,0,0}));
    connect(ramp.y, source.p_in) annotation (Line(points={{-111,40},{-102,40},{
            -102,44},{-80,44},{-80,46}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})));
  end testNumeric;
end Numeric;
