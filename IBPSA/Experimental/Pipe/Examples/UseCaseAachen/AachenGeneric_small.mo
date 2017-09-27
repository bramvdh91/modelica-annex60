within IBPSA.Experimental.Pipe.Examples.UseCaseAachen;
model AachenGeneric_small
  "Model automatically generated with uesmodels at 2016-12-12 12:20:05.947837"

  parameter Modelica.SIunits.Temperature T_amb = 283.15
    "Ambient temperature around pipes";

  package Medium = IBPSA.Media.Water(T_default=273.15+70);

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.SupplySource supplysupply(
    redeclare package Medium = Medium,
    p_supply=1000000)
         annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={493.7179687603422,553.1762970021425})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.DemandSink stationA3041(
    redeclare package Medium = Medium,
    m_flow_nominal=0.11950286806883365)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=0,
      origin={800.9859902302968,526.1729700647633})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.DemandSink stationA1465(
    redeclare package Medium = Medium,
    m_flow_nominal=0.11950286806883365)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=0,
      origin={611.1243642944979,403.76432359947466})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.DemandSink stationA3609(
    redeclare package Medium = Medium,
    m_flow_nominal=0.11950286806883365)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=0,
      origin={633.6055705813698,272.3579181095751})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.DemandSink stationA3610(
    redeclare package Medium = Medium,
    m_flow_nominal=0.11950286806883365)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=0,
      origin={686.7253869769394,537.5230184715364})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe64406433(
    redeclare package Medium = Medium,
    length=13.336702541819008,
    diameter=0.05,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=348.47096074174937,
      origin={556.218624532212,174.67068591991458})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe64296433(
    redeclare package Medium = Medium,
    length=15.292538353453127,
    diameter=0.1,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=82.14527038648444,
      origin={509.8758644051187,249.87558972114402})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe65136542(
    redeclare package Medium = Medium,
    length=28.783990857058694,
    diameter=0.04,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=173.171267850555,
      origin={680.3354218323283,540.6210459983621})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe65136519(
    redeclare package Medium = Medium,
    length=6.808999925417844,
    diameter=0.125,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=352.1363874766592,
      origin={522.1920924580121,549.2436157829097})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe64186419(
    redeclare package Medium = Medium,
    length=0.9000000000000282,
    diameter=0.05,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=352.1363874766566,
      origin={555.9212006793877,555.5889358746955})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe64196414(
    redeclare package Medium = Medium,
    length=1.2910375054579482,
    diameter=0.1,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=262.13638747665823,
      origin={551.4118820400488,550.7098421905534})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe64183610(
    redeclare package Medium = Medium,
    length=15.18956285715749,
    diameter=0.04,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=352.13638747665885,
      origin={623.2051202056496,546.2960702017486})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe65136541(
    redeclare package Medium = Medium,
    length=12.049656021478087,
    diameter=0.1,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=82.13826471784333,
      origin={525.6563584649152,364.21776974712316})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe65136522(
    redeclare package Medium = Medium,
    length=13.16857497799242,
    diameter=0.04,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=78.47096074174978,
      origin={622.4947839189052,217.8879811345225})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe65136520(
    redeclare package Medium = Medium,
    length=9.387039205049568,
    diameter=0.04,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=172.13638747665874,
      origin={571.8693021110371,409.1860056658961})));

  IBPSA.Experimental.Pipe.Examples.UseCaseAachen.Components.PipeA60 pipe64146415(
    redeclare package Medium = Medium,
    length=15.627494060500709,
    diameter=0.1,
    T_amb=T_amb,
    m_flow_nominal=1,
    thicknessIns=0.05,
    lambdaIns=0.03)
      annotation(Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=262.1363874766586,
      origin={541.6402280416291,479.9593111479972})));

equation
  // Connections between supplies, pipes, and stations
  connect(stationA3041.port_a, pipe65136542.port_a)
    annotation(Line(points={{790.986,526.173},{690.264,539.432}},                                         color={0,127,255}));
  connect(supplysupply.port_b, pipe65136519.port_a)
    annotation(Line(points={{503.718,553.176},{512.286,550.612}},                                         color={0,127,255}));
  connect(pipe65136522.port_a, pipe64406433.port_b)
    annotation(Line(points={{620.496,208.09},{566.017,172.672}},                                          color={0,127,255}));
  connect(pipe64406433.port_a, pipe64296433.port_a)
    annotation(Line(points={{546.42,176.669},{508.509,239.969}},                                           color={0,127,255}));
  connect(pipe65136541.port_a, pipe64296433.port_b)
    annotation(Line(points={{524.289,354.312},{511.242,259.782}},                                           color={0,127,255}));
  connect(pipe64183610.port_a, pipe65136542.port_b)
    annotation(Line(points={{613.299,547.664},{670.406,541.81}},                                          color={0,127,255}));
  connect(pipe64146415.port_a, pipe65136519.port_b)
    annotation(Line(points={{543.008,489.865},{532.098,547.875}},                                         color={0,127,255}));
  connect(pipe64183610.port_a, pipe64186419.port_b)
    annotation(Line(points={{613.299,547.664},{565.827,554.221}},                                         color={0,127,255}));
  connect(pipe64146415.port_a, pipe64196414.port_b)
    annotation(Line(points={{543.008,489.865},{550.044,540.804}},                                         color={0,127,255}));
  connect(pipe64183610.port_b, stationA3610.port_a)
    annotation(Line(points={{633.111,544.928},{676.725,537.523}},                                         color={0,127,255}));
  connect(pipe65136520.port_b, pipe65136541.port_b)
    annotation(Line(points={{561.963,410.554},{527.024,374.124}},                                          color={0,127,255}));
  connect(pipe65136522.port_b, stationA3609.port_a)
    annotation(Line(points={{624.493,227.686},{623.606,272.358}},                                         color={0,127,255}));
  connect(pipe65136520.port_a, stationA1465.port_a)
    annotation(Line(points={{581.775,407.818},{601.124,403.764}},                                          color={0,127,255}));
  connect(pipe65136520.port_b, pipe64146415.port_b)
    annotation(Line(points={{561.963,410.554},{540.272,470.053}},                                         color={0,127,255}));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{0,0},{
            1000,1245.37}})),
              experiment(
                StopTime=604800,
                Interval=3600,
                Tolerance=0.0001,
                __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>This model represents a generic district heating network auto-generated with the Python packages <em>uesgraphs</em> and <em>uesmodels</em>. </p>
<p>The building positions are taken from OpenStreetMap data for a district in the city of Aachen (The data can be queried from <a href=\"http://www.openstreetmap.org/#map=17/50.78237/6.05746\">http://www.openstreetmap.org/#map=17/50.78237/6.05746</a>). The package <em>uesgraphs</em> imports this data into a Python graph representation including the street network. The heating network is added with a simple algorithm following the street layout to connect 25 buildings to a given supply node. The pipe diameters are designed so that they approach a specific pressure drop of 200 Pa/m for the given maximum heat load of each building for a dT of 20 K between a network supply temperature of 60 degC and a return temperature of 40 degC.</p>
<p>The heat demands of the buildings are taken from a building simulation based on an archetype building model of a residential building. The building model was created using TEASER (<a href=\"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a>) and AixLib (<a href=\"https://github.com/RWTH-EBC/AixLib\">https://github.com/RWTH-EBC/AixLib</a>). The buildings&#39; peak load is 48.379 kW. The same heat demand is used for each of the 25 buildings.</p>
<p>The Modelica model is auto-generated from the <em>uesgraphs</em> representation of the network using the Python package <em>uesmodels</em>.</p>
</html>", revisions="<html>
<ul>
<li>December 12, 2016 by Marcus Fuchs:<br>First implementation. </li>
</ul>
</html>"));
end AachenGeneric_small;
