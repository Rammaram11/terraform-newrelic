alert_policies = [
  {
  emails = "teampharos@wellsky.com"
  name   = "Consolo-Warning-TF"
  },
  {
    emails = "teampharos@wellsky.com, bd36c353.mediwareinformationsystems.onmicrosoft.com@amer.teams.ms"
    name   = "Consolo-Severe-Warning-TF"
  },
  {
    emails = "bd36c353.mediwareinformationsystems.onmicrosoft.com@amer.teams.mss"
    name   = "Consolo-Critical-Warning-TF"
  },
  {
    emails = "bd36c353.mediwareinformationsystems.onmicrosoft.com@amer.teams.ms"
    name   = "Consolo-Critical-TF"
  },
  {
    emails = "86949810.mediwareinformationsystems.onmicrosoft.com@amer.teams.ms"
    name   = "Consolo-CodeRed-TF"
    #86949810.mediwareinformationsystems.onmicrosoft.com@amer.teams.ms
  }
]

target_hosts = [ "elixir.consolo.lan", 
                 "memoryalpha.consolo.lan", 
                 "hhhkhshvr001",
                 "prodlb.consolo.lan",
                 "cronprod",
                 "dockerhost.consolo.lan",
                 "audits-app.consolo.lan",
                 "starbase4.consolo.lan",
                 "louwmintprd02.consolo.lan",
                 "wmstage",
                 "tomcat",
                 "tomcatdev",
                 "appserver01.consolo.lan",
                 "appserver02.consolo.lan",
                 "appserver03.consolo.lan",
                 "appserver04.consolo.lan",
                 "appserver05.consolo.lan",
                 "appserver06.consolo.lan",
                 "ms1prod.consolo.lan",
                 "prodmiscapps.consolo.lan",
                 "warehouse-app.consolo.lan",
                 "stagepuma1.consolo.lan",
                 "stagepuma2.consolo.lan",
                 "stagepuma3.consolo.lan",
                 "ms1stage.consolo.lan",
                 "asyncworker01.consolo.lan",
                 "asyncworker02.consolo.lan",
                 "asyncworker03.consolo.lan",
                 "asyncworker04.consolo.lan",
                 "asyncworker05.consolo.lan",
                 "asyncworker06.consolo.lan",
                 "highmemside1.consolo.lan",
                 "highmemsidepdf.consolo.lan",
                 "redisshard1.consolo.lan",
                 "redisshard2.consolo.lan",
                 "redisshard3.consolo.lan",
                 "officeredis1.consolo.lan",
                 "stageside1.consolo.lan",
                 "stageside2.consolo.lan",
                 "stagesidebilling.consolo.lan",
                 "ice.consolo.lan",
                 "ice2.consolo.lan",
                 "audits-db.consolo.lan",
                 "warehouse-db.consolo.lan",
                 "consolo-stage-hvr.colocation1.austin.kinnser.com",
                 "consolo-prod-hvr01.colocation1.austin.kinnser.com",
                 "pdfer.consolo.lan",
                 "warehouse-db-staging.consolo.lan"
               ]




synthetic_monitors = [
      {
        "target_url": "http://appserver01.consolo.lan:3000/health",
        "monitor_name": "Core-appserver01"
      },
      {
        "target_url": "http://appserver02.consolo.lan:3000/health",
        "monitor_name": "Core-appserver02"
      },
      {
        "target_url": "http://appserver03.consolo.lan:3000/health",
        "monitor_name": "Core-appserver03"
      },
      {
        "target_url": "http://appserver04.consolo.lan:3000/health",
        "monitor_name": "Core-appserver04"
      },
      {
        "target_url": "http://appserver05.consolo.lan:3000/health",
        "monitor_name": "Core-appserver05"
      },
      {
        "target_url": "http://appserver06.consolo.lan:3000/health",
        "monitor_name": "Core-appserver06"
      },
      {
        "target_url": "http://prodmiscapps.consolo.lan:3601/health",
        "monitor_name": "Prod-Messenger-Api"
      },
      {
        "target_url": "http://prodmiscapps.consolo.lan:3500/health",
        "monitor_name": "Prod-PatientPortal-Api"
      }
]

synthetic_monitor_period = "EVERY_MINUTE"
synthetic_monitor_type = "SIMPLE"

# syrio2.consolo.lan
# sansa.consolo.lan
# warehouse-app-staging.consolo.lan