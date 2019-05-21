credentials += {
  import scala.sys.process._
  val pwd: String = "security find-generic-password -a mpallmann -s com.apple.network.eap.user.item.wlan.ssid.Zalando_Air -w".!!.trim()
  Credentials(
    "Sonatype Nexus Repository Manager",
    "maven.zalando.net",
    "mpallmann",
    pwd
  )
}
