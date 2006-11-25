From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 06/21] ACPI: ibm-acpi: prepare to cleanup
	fan_read and fan_write
Date: Sat, 25 Nov 2006 18:43:56 -0200
Message-ID: <20061125204356.6604.61150.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20061125204155.6604.35338.stgit-H32KNTuDSMjdPi8JTuvWk31TOOPCyuNQ5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>

This patch lays some groundwork for a fan_read and fan_write cleanup in the
next patches.  To do so, it provides a new fan_init initializer, and also some
constants (through enums).

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 drivers/acpi/ibm_acpi.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 491c413..4c836e2 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -231,6 +231,31 @@ struct ibm_thermal_sensors_struct {
 	s32 temp[IBMACPI_MAX_THERMAL_SENSORS];
 };
 
+enum fan_status_access_mode {
+	IBMACPI_FAN_NONE = 0,		/* No fan status or control */
+	IBMACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
+	IBMACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
+};
+
+enum fan_control_access_mode {
+	IBMACPI_FAN_WR_NONE = 0,	/* No fan control */
+	IBMACPI_FAN_WR_ACPI_SFAN,	/* Use ACPI SFAN */
+	IBMACPI_FAN_WR_TPEC,		/* Use ACPI EC reg 0x2f */
+	IBMACPI_FAN_WR_ACPI_FANS,	/* Use ACPI FANS and EC reg 0x2f */
+};
+
+enum fan_control_commands {
+	IBMACPI_FAN_CMD_SPEED 	= 0x0001,	/* speed command */
+	IBMACPI_FAN_CMD_LEVEL 	= 0x0002,	/* level command  */
+	IBMACPI_FAN_CMD_ENABLE	= 0x0004,	/* enable/disable cmd */
+};
+
+enum {					/* Fan control constants */
+	fan_status_offset = 0x2f,	/* EC register 0x2f */
+	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
+					 * 0x84 must be read before 0x85 */
+};
+
 static int ibm_thinkpad_ec_found;
 
 struct ibm_struct {
@@ -1659,8 +1684,59 @@ static int volume_write(char *buf)
 	return 0;
 }
 
-static int fan_status_offset = 0x2f;
-static int fan_rpm_offset = 0x84;
+static enum fan_status_access_mode fan_status_access_mode;
+static enum fan_control_access_mode fan_control_access_mode;
+static enum fan_control_commands fan_control_commands;
+
+static int fan_init(void)
+{
+	u8 status;
+
+	fan_status_access_mode = IBMACPI_FAN_NONE;
+	fan_control_access_mode = IBMACPI_FAN_WR_NONE;
+	fan_control_commands = 0;
+
+	if (gfan_handle) {
+		/* 570, 600e/x, 770e, 770x */
+		fan_status_access_mode = IBMACPI_FAN_RD_ACPI_GFAN;
+	} else {
+		/* all other ThinkPads: note that even old-style
+		 * ThinkPad ECs supports the fan control register */
+		if (likely(acpi_ec_read(fan_status_offset, &status))) {
+			fan_status_access_mode = IBMACPI_FAN_RD_TPEC;
+		} else {
+			printk(IBM_ERR
+			       "ThinkPad ACPI EC access misbehaving, "
+			       "fan status and control unavailable\n");
+			return 0;
+		}
+	}
+
+	if (sfan_handle) {
+		/* 570, 770x-JL */
+		fan_control_access_mode = IBMACPI_FAN_WR_ACPI_SFAN;
+		fan_control_commands |= IBMACPI_FAN_CMD_LEVEL;
+	} else {
+		if (!gfan_handle) {
+			/* gfan without sfan means no fan control */
+			/* all other models implement TP EC 0x2f control */
+
+			if (fans_handle) {
+				/* X31, X40 */
+				fan_control_access_mode =
+				    IBMACPI_FAN_WR_ACPI_FANS;
+				fan_control_commands |=
+				    IBMACPI_FAN_CMD_SPEED |
+				    IBMACPI_FAN_CMD_ENABLE;
+			} else {
+				fan_control_access_mode = IBMACPI_FAN_WR_TPEC;
+				fan_control_commands |= IBMACPI_FAN_CMD_ENABLE;
+			}
+		}
+	}
+
+	return 0;
+}
 
 static int fan_read(char *p)
 {
@@ -1849,6 +1925,7 @@ static struct ibm_struct ibms[] = {
 	 .name = "fan",
 	 .read = fan_read,
 	 .write = fan_write,
+	 .init = fan_init,
 	 .experimental = 1,
 	 },
 };

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
