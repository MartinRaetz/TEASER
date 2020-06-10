
within Room_070505.uka_070505;
model uka_070505
  "This is the simulation model of uka_070505 with traceable ID 0"

  AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped multizone(
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    buildingID=0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start = 293.15,
    VAir = 117.65599999999999,
    ABuilding=42.019999999999996,
    ASurTot=108.93999999999998,
    numZones = 1,
    internalGainsMode = 1,
    zoneParam = {
      uka_070505_DataBase.uka_070505_UKA_070505()
      },
  heatAHU=true,
  coolAHU=true,
  dehuAHU=false,
  huAHU=true,
  BPFDehuAHU=0.2,
  HRS=true,
  sampleRateAHU=1800,
  effFanAHU_sup=0.7,
  effFanAHU_eta=0.7,
  effHRSAHU_enabled=0.25,
  effHRSAHU_disabled=0.0,
  dpAHU_sup=1800,
  dpAHU_eta=1000,
  zone(ROM(extWallRC(thermCapExt(each der_T(fixed=true))),
           intWallRC(thermCapInt(each der_T(fixed=true))),floorRC
           (thermCapExt(each der_T(fixed=true))),roofRC(thermCapExt(each
           der_T(fixed=true))))),
   redeclare model thermalZone =
        AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZoneAirExchange,
   redeclare model corG =
        AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
  redeclare model AHUMod = AixLib.Airflow.AirHandlingUnit.AHU)
    "Multizone"
    annotation (Placement(transformation(extent={{32,-8},{52,12}})));

  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=
      "D:/mre-jba/Py/TEASER/teaser/data/input/inputdata/weatherdata/RealData_TRY_mix_Aachen_2020010100_2020043023.mos")
    "Weather data reader"
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));

  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://Room_070505/uka_070505/InternalGains_uka_070505.txt"),
    columns=2:4)
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{72,-42},{56,-26}})));

  Modelica.Blocks.Sources.CombiTimeTable tableAHU(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="AHU",
    columns=2:5,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://Room_070505/uka_070505/AHU_uka_070505.txt"))
    "Boundary conditions for air handling unit"
    annotation (Placement(transformation(extent={{-64,-6},{-48,10}})));

  Modelica.Blocks.Sources.CombiTimeTable tableTSet(
    tableOnFile=true,
    tableName="Tset",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://Room_070505/uka_070505/TsetHeat_uka_070505.txt"),
    columns=2:2)
    "Set points for heater"
    annotation (Placement(transformation(extent={{72,-66},{56,-50}})));

    Modelica.Blocks.Sources.CombiTimeTable tableTSetCool(
      tableOnFile=true,
      tableName="Tset",
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://Room_070505/uka_070505/TsetCool_uka_070505.txt"),
      columns=2:2)
      "Set points for cooler"
    annotation (Placement(transformation(extent={{72,-90},{56,-74}})));

equation
  connect(weaDat.weaBus, multizone.weaBus) annotation (Line(
      points={{-62,40},{-32,40},{-32,6},{34,6}},
      color={255,204,51},
      thickness=0.5));

  connect(tableInternalGains.y, multizone.intGains)
    annotation (Line(points={{55.2,-34},{48,-34},{48,-9}}, color={0,0,127}));

  connect(tableAHU.y, multizone.AHU)
    annotation (Line(points={{-47.2,2},{14,2},{33,2}}, color={0,0,127}));

  connect(tableTSet.y, multizone.TSetHeat) annotation (Line(points={{55.2,-58},
          {36.8,-58},{36.8,-9}}, color={0,0,127}));

  connect(tableTSetCool.y, multizone.TSetCool) annotation (Line(points={{55.2,-58},
          {36.8,-58},{36.8,-9}}, color={0,0,127}));

  annotation (experiment(
      StartTime=0,
      StopTime=10454400,
      Interval=3600,
      __Dymola_Algorithm="dassl"),
      __Dymola_experimentSetupOutput(equidistant=true,
      events=false,
      states=False,
      derivatives=False,
      inputs=False,
      auxiliaries=False),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Line(points={{80,-82}}, color={28,108,200}),
        Rectangle(
          extent={{-80,20},{80,-80}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-80,20},{0,100},{80,20}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-52,-10},{62,-48}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="TB")}));
end uka_070505;
