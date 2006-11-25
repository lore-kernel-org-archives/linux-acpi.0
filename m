From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 13/21] ACPI: ibm-acpi: fix and extend fan control functions
Date: Sat, 25 Nov 2006 18:46:17 -0200
Message-ID: <20061125204617.6604.18870.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:22671 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967190AbWKYUqO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 15:46:14 -0500
In-Reply-To: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This patch extend fan control functions, implementing enable/disable for
all write access modes, implementing level control for all level-capable
write access modes.

The patch also updates the documentation, explaining levels auto and
disengaged.

ABI changes:
	1. Support level 0 as an equivalent to disable
	2. Add support for level auto and level disengaged when doing
	   EC 0x2f fan control
	3. Support enable/disable for all level-based write access modes
	4. Add support for level command on FANS thinkpads, as per
	   thinkwiki reports

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

 Documentation/ibm-acpi.txt |   65 +++++++++++++++++++++++++++++++-------------
 drivers/acpi/ibm_acpi.c    |   39 +++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
index 333b8eb..cbd3a60 100644
--- a/Documentation/ibm-acpi.txt
+++ b/Documentation/ibm-acpi.txt
@@ -571,27 +571,57 @@ directly accesses hardware registers and
 WITH CAUTION! To use this feature, you need to supply the
 experimental=1 parameter when loading the module.
 
-This feature attempts to show the current fan speed. The speed is read
-directly from the hardware registers of the embedded controller. This
-is known to work on later R, T and X series ThinkPads but may show a
-bogus value on other models.
+This feature attempts to show the current fan speed, control mode and
+other fan data that might be available.  The speed is read directly
+from the hardware registers of the embedded controller.  This is known
+to work on later R, T and X series ThinkPads but may show a bogus
+value on other models.
+
+Most ThinkPad fans work in "levels".  Level 0 stops the fan.  The higher
+the level, the higher the fan speed, although adjacent levels often map
+to the same fan speed.  7 is the highest level, where the fan reaches
+the maximum recommended speed.  Level "auto" means the EC changes the
+fan level according to some internal algorithm, usually based on
+readings from the thermal sensors.  Level "disengaged" means the EC
+disables the speed-locked closed-loop fan control, and drives the fan as
+fast as it can go, which might exceed hardware limits, so use this level
+with caution.
+
+The fan usually ramps up or down slowly from one speed to another,
+and it is normal for the EC to take several seconds to react to fan
+commands.
 
 The fan may be enabled or disabled with the following commands:
 
 	echo enable  >/proc/acpi/ibm/fan
 	echo disable >/proc/acpi/ibm/fan
 
+Placing a fan on level 0 is the same as disabling it.  Enabling a fan
+will try to place it in a safe level if it is too slow or disabled.
+
 WARNING WARNING WARNING: do not leave the fan disabled unless you are
-monitoring the temperature sensor readings and you are ready to enable
-it if necessary to avoid overheating.
+monitoring all of the temperature sensor readings and you are ready to
+enable it if necessary to avoid overheating.
+
+An enabled fan in level "auto" may stop spinning if the EC decides the
+ThinkPad is cool enough and doesn't need the extra airflow.  This is
+normal, and the EC will spin the fan up if the varios thermal readings
+rise too much.
+
+On the X40, this seems to depend on the CPU and HDD temperatures.
+Specifically, the fan is turned on when either the CPU temperature
+climbs to 56 degrees or the HDD temperature climbs to 46 degrees.  The
+fan is turned off when the CPU temperature drops to 49 degrees and the
+HDD temperature drops to 41 degrees.  These thresholds cannot
+currently be controlled.
+
+The fan level can be controlled with the command:
 
-The fan only runs if it's enabled *and* the various temperature
-sensors which control it read high enough. On the X40, this seems to
-depend on the CPU and HDD temperatures. Specifically, the fan is
-turned on when either the CPU temperature climbs to 56 degrees or the
-HDD temperature climbs to 46 degrees. The fan is turned off when the
-CPU temperature drops to 49 degrees and the HDD temperature drops to
-41 degrees. These thresholds cannot currently be controlled.
+	echo 'level <level>' > /proc/acpi/ibm/thermal
+
+Where <level> is an integer from 0 to 7, or one of the words "auto"
+or "disengaged" (without the quotes).  Not all ThinkPads support the
+"auto" and "disengaged" levels.
 
 On the X31 and X40 (and ONLY on those models), the fan speed can be
 controlled to a certain degree. Once the fan is running, it can be
@@ -604,12 +634,9 @@ about 3700 to about 7350. Values outside
 any effect or the fan speed eventually settles somewhere in that
 range. The fan cannot be stopped or started with this command.
 
-On the 570, temperature readings are not available through this
-feature and the fan control works a little differently. The fan speed
-is reported in levels from 0 (off) to 7 (max) and can be controlled
-with the following command:
-
-	echo 'level <level>' > /proc/acpi/ibm/thermal
+The ThinkPad's ACPI DSDT code will reprogram the fan on its own when
+certain conditions are met.  It will override any fan programming done
+through ibm-acpi.
 
 EXPERIMENTAL: WAN -- /proc/acpi/ibm/wan
 ---------------------------------------
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 001a5e9..7ea4a26 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1833,10 +1833,13 @@ static int fan_init(void)
 				    IBMACPI_FAN_WR_ACPI_FANS;
 				fan_control_commands |=
 				    IBMACPI_FAN_CMD_SPEED |
+				    IBMACPI_FAN_CMD_LEVEL |
 				    IBMACPI_FAN_CMD_ENABLE;
 			} else {
 				fan_control_access_mode = IBMACPI_FAN_WR_TPEC;
-				fan_control_commands |= IBMACPI_FAN_CMD_ENABLE;
+				fan_control_commands |=
+				    IBMACPI_FAN_CMD_LEVEL |
+				    IBMACPI_FAN_CMD_ENABLE;
 			}
 		}
 	}
@@ -1948,9 +1951,20 @@ static int fan_read(char *p)
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 	}
 
-	if (fan_control_commands & IBMACPI_FAN_CMD_LEVEL)
-		len += sprintf(p + len, "commands:\tlevel <level>"
-			       " (<level> is 0-7)\n");
+	if (fan_control_commands & IBMACPI_FAN_CMD_LEVEL) {
+		len += sprintf(p + len, "commands:\tlevel <level>");
+
+		switch (fan_control_access_mode) {
+		case IBMACPI_FAN_WR_ACPI_SFAN:
+			len += sprintf(p + len, " (<level> is 0-7)\n");
+			break;
+
+		default:
+			len += sprintf(p + len, " (<level> is 0-7, "
+				       "auto, disengaged)\n");
+			break;
+		}
+	}
 
 	if (fan_control_commands & IBMACPI_FAN_CMD_ENABLE)
 		len += sprintf(p + len, "commands:\tenable, disable\n");
@@ -1973,6 +1987,17 @@ static int fan_set_level(int level)
 			return -EINVAL;
 		break;
 
+	case IBMACPI_FAN_WR_ACPI_FANS:
+	case IBMACPI_FAN_WR_TPEC:
+		if ((level != IBMACPI_FAN_EC_AUTO) &&
+		    (level != IBMACPI_FAN_EC_DISENGAGED) &&
+		    ((level < 0) || (level > 7)))
+			return -EINVAL;
+
+		if (!acpi_ec_write(fan_status_offset, level))
+			return -EIO;
+		break;
+
 	default:
 		return -ENXIO;
 	}
@@ -2060,7 +2085,11 @@ static int fan_write_cmd_level(const cha
 {
 	int level;
 
-	if (sscanf(cmd, "level %d", &level) != 1)
+	if (strlencmp(cmd, "level auto") == 0)
+		level = IBMACPI_FAN_EC_AUTO;
+	else if (strlencmp(cmd, "level disengaged") == 0)
+		level = IBMACPI_FAN_EC_DISENGAGED;
+	else if (sscanf(cmd, "level %d", &level) != 1)
 		return 0;
 
 	if ((*rc = fan_set_level(level)) == -ENXIO)
