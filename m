From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 09/21] ACPI: ibm-acpi: cleanup fan_write
Date: Sat, 25 Nov 2006 18:44:56 -0200
Message-ID: <20061125204456.6604.76963.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43409 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967185AbWKYUoy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 15:44:54 -0500
In-Reply-To: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This patch cleans up fan_write so that it is much easier to read and
extend.  It separates the proc api handling from the operations themselves.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

 drivers/acpi/ibm_acpi.c |  147 ++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 125 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 834485b..5258994 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1843,40 +1843,143 @@ static int fan_read(char *p)
 	return len;
 }
 
-static int fan_write(char *buf)
+static int fan_set_level(int level)
 {
-	char *cmd;
-	int level, speed;
-
-	while ((cmd = next_cmd(&buf))) {
-		if (sfan_handle &&
-		    sscanf(cmd, "level %d", &level) == 1 &&
-		    level >= 0 && level <= 7) {
-			/* 570, 770x-JL */
+	switch (fan_control_access_mode) {
+	case IBMACPI_FAN_WR_ACPI_SFAN:
+		if (level >= 0 && level <= 7) {
 			if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", level))
 				return -EIO;
-		} else if (!gfan_handle && strlencmp(cmd, "enable") == 0) {
-			/* all except 570, 600e/x, 770e, 770x */
-			if (!acpi_ec_write(fan_status_offset, 0x80))
-				return -EIO;
-		} else if (!gfan_handle && strlencmp(cmd, "disable") == 0) {
-			/* all except 570, 600e/x, 770e, 770x */
-			if (!acpi_ec_write(fan_status_offset, 0x00))
-				return -EIO;
-		} else if (fans_handle &&
-			   sscanf(cmd, "speed %d", &speed) == 1 &&
-			   speed >= 0 && speed <= 65535) {
-			/* X31, X40 */
+		} else
+			return -EINVAL;
+		break;
+
+	default:
+		return -ENXIO;
+	}
+	return 0;
+}
+
+static int fan_set_enable(void)
+{
+	switch (fan_control_access_mode) {
+	case IBMACPI_FAN_WR_ACPI_FANS:
+	case IBMACPI_FAN_WR_TPEC:
+		if (!acpi_ec_write(fan_status_offset, 0x80))
+			return -EIO;
+		break;
+
+	default:
+		return -ENXIO;
+	}
+	return 0;
+}
+
+static int fan_set_disable(void)
+{
+	switch (fan_control_access_mode) {
+	case IBMACPI_FAN_WR_ACPI_FANS:
+	case IBMACPI_FAN_WR_TPEC:
+		if (!acpi_ec_write(fan_status_offset, 0x00))
+			return -EIO;
+		break;
+
+	default:
+		return -ENXIO;
+	}
+	return 0;
+}
+
+static int fan_set_speed(int speed)
+{
+	switch (fan_control_access_mode) {
+	case IBMACPI_FAN_WR_ACPI_FANS:
+		if (speed >= 0 && speed <= 65535) {
 			if (!acpi_evalf(fans_handle, NULL, NULL, "vddd",
 					speed, speed, speed))
 				return -EIO;
 		} else
 			return -EINVAL;
-	}
+		break;
 
+	default:
+		return -ENXIO;
+	}
 	return 0;
 }
 
+static int fan_write_cmd_level(const char *cmd, int *rc)
+{
+	int level;
+
+	if (sscanf(cmd, "level %d", &level) != 1)
+		return 0;
+
+	if ((*rc = fan_set_level(level)) == -ENXIO)
+		printk(IBM_ERR "level command accepted for unsupported "
+		       "access mode %d", fan_control_access_mode);
+
+	return 1;
+}
+
+static int fan_write_cmd_enable(const char *cmd, int *rc)
+{
+	if (strlencmp(cmd, "enable") != 0)
+		return 0;
+
+	if ((*rc = fan_set_enable()) == -ENXIO)
+		printk(IBM_ERR "enable command accepted for unsupported "
+		       "access mode %d", fan_control_access_mode);
+
+	return 1;
+}
+
+static int fan_write_cmd_disable(const char *cmd, int *rc)
+{
+	if (strlencmp(cmd, "disable") != 0)
+		return 0;
+
+	if ((*rc = fan_set_disable()) == -ENXIO)
+		printk(IBM_ERR "disable command accepted for unsupported "
+		       "access mode %d", fan_control_access_mode);
+
+	return 1;
+}
+
+static int fan_write_cmd_speed(const char *cmd, int *rc)
+{
+	int speed;
+
+	if (sscanf(cmd, "speed %d", &speed) != 1)
+		return 0;
+
+	if ((*rc = fan_set_speed(speed)) == -ENXIO)
+		printk(IBM_ERR "speed command accepted for unsupported "
+		       "access mode %d", fan_control_access_mode);
+
+	return 1;
+}
+
+static int fan_write(char *buf)
+{
+	char *cmd;
+	int rc = 0;
+
+	while (!rc && (cmd = next_cmd(&buf))) {
+		if (!((fan_control_commands & IBMACPI_FAN_CMD_LEVEL) &&
+		      fan_write_cmd_level(cmd, &rc)) &&
+		    !((fan_control_commands & IBMACPI_FAN_CMD_ENABLE) &&
+		      (fan_write_cmd_enable(cmd, &rc) ||
+		       fan_write_cmd_disable(cmd, &rc))) &&
+		    !((fan_control_commands & IBMACPI_FAN_CMD_SPEED) &&
+		      fan_write_cmd_speed(cmd, &rc))
+		    )
+			rc = -EINVAL;
+	}
+
+	return rc;
+}
+
 static struct ibm_struct ibms[] = {
 	{
 	 .name = "driver",
