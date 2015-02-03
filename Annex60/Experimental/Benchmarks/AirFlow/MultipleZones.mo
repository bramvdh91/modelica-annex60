within Annex60.Experimental.Benchmarks.AirFlow;
model MultipleZones "Test case for air flow between multiple zones"
  extends Modelica.Icons.Example;

  package Medium = Modelica.Media.Air.SimpleAir;
  parameter Boolean forceErrorControlOnFlow = true;

  Airflow.Multizone.ZoneHallway zoneHallway(redeclare package Medium = Medium,
      forceErrorControlOnFlow=forceErrorControlOnFlow)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Airflow.Multizone.SimpleZone simpleZone(redeclare package Medium = Medium,
      forceErrorControlOnFlow=forceErrorControlOnFlow)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Airflow.Multizone.OutsideEnvironment outsideEnvironment(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Airflow.Multizone.ZoneHallway zoneHallway1(redeclare package Medium = Medium,
      forceErrorControlOnFlow=forceErrorControlOnFlow)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Airflow.Multizone.ZoneHallway zoneHallway2(redeclare package Medium = Medium,
      forceErrorControlOnFlow=forceErrorControlOnFlow)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Airflow.Multizone.ZoneHallway zoneHallway3(redeclare package Medium = Medium,
      forceErrorControlOnFlow=forceErrorControlOnFlow)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Airflow.Multizone.SimpleZone simpleZone1(TRoom=293.15, redeclare package
      Medium = Medium,
    forceErrorControlOnFlow=forceErrorControlOnFlow)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Airflow.Multizone.SimpleZone simpleZone2(TRoom=303.15, redeclare package
      Medium = Medium,
    forceErrorControlOnFlow=forceErrorControlOnFlow)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Airflow.Multizone.SimpleZone simpleZone3(TRoom=300.15, redeclare package
      Medium = Medium,
    forceErrorControlOnFlow=forceErrorControlOnFlow)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Airflow.Multizone.OutsideEnvironment outsideEnvironment1
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Airflow.Multizone.OutsideEnvironment outsideEnvironment2
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Airflow.Multizone.OutsideEnvironment outsideEnvironment3
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(zoneHallway3.port_b_toOutside, outsideEnvironment3.port_b)
    annotation (Line(
      points={{10,44},{60,44}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway3.port_a_toOutside, outsideEnvironment3.port_a)
    annotation (Line(
      points={{10,56},{60,56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway2.port_b_toOutside, outsideEnvironment2.port_b)
    annotation (Line(
      points={{10,4},{60,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway2.port_a_toOutside, outsideEnvironment2.port_a)
    annotation (Line(
      points={{10,16},{60,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway1.port_b_toOutside, outsideEnvironment1.port_b)
    annotation (Line(
      points={{10,-36},{60,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway1.port_a_toOutside, outsideEnvironment1.port_a)
    annotation (Line(
      points={{10,-24},{60,-24}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway.port_b_toOutside, outsideEnvironment.port_b) annotation (
      Line(
      points={{10,-76},{60,-76}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway.port_a_toOutside, outsideEnvironment.port_a) annotation (
      Line(
      points={{10,-64},{60,-64}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(simpleZone.port_b, zoneHallway.port_b_toZone) annotation (Line(
      points={{-60,-76},{-10,-76}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(simpleZone.port_a, zoneHallway.port_a_toZone) annotation (Line(
      points={{-60,-64},{-10,-64}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway.port_a2, zoneHallway1.port_a1) annotation (Line(
      points={{-6,-60},{-6,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway.port_b2, zoneHallway1.port_b1) annotation (Line(
      points={{6,-60},{6,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(simpleZone1.port_b, zoneHallway1.port_b_toZone) annotation (Line(
      points={{-60,-36},{-10,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(simpleZone1.port_a, zoneHallway1.port_a_toZone) annotation (Line(
      points={{-60,-24},{-10,-24}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway1.port_a2, zoneHallway2.port_a1) annotation (Line(
      points={{-6,-20},{-6,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway1.port_b2, zoneHallway2.port_b1) annotation (Line(
      points={{6,-20},{6,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(simpleZone2.port_b, zoneHallway2.port_b_toZone) annotation (Line(
      points={{-60,4},{-10,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(simpleZone2.port_a, zoneHallway2.port_a_toZone) annotation (Line(
      points={{-60,16},{-10,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway2.port_a2, zoneHallway3.port_a1) annotation (Line(
      points={{-6,20},{-6,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneHallway2.port_b2, zoneHallway3.port_b1) annotation (Line(
      points={{6,20},{6,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(simpleZone3.port_b, zoneHallway3.port_b_toZone) annotation (Line(
      points={{-60,44},{-10,44}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(simpleZone3.port_a, zoneHallway3.port_a_toZone) annotation (Line(
      points={{-60,56},{-10,56}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=3600),
    __Dymola_experimentSetupOutput);
end MultipleZones;