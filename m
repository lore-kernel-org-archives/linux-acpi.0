From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 15/21] ACPI: ibm-acpi: workaround for EC 0x2f initialization bug
Date: Sat, 25 Nov 2006 18:46:57 -0200
Message-ID: <20061125204657.6604.22139.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:44225 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967192AbWKYUqy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 15:46:54 -0500
In-Reply-To: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

A few ThinkPads fail to initialize EC register 0x2f both in the EC
firmware and ACPI DSDT.  If the BIOS and the ACPI DSDT also do not
initialize it, then the initial status of that register does not
correspond to reality.

On all reported buggy machines, EC 0x2f will read 0x07 (fan level 7) upon
cold boot, when the EC is actually in mode 0x80 (auto mode).  Since
returning a text string ("unknown") would break a number of userspace
programs, instead we correct the reading for the most probably correct
answer, and return it is in auto mode.

The workaround flags the status and level as unknown on module load/kernel
boot, until we are certain at least one fan control command was issued,
either by us, or by something else.

We don't work around the bug by doing a "fan enable" at module
load/startup (which would initialize the EC register) because it is not
known if these ThinkPad ACPI DSDT might have set the fan to level 7
instead of "auto" (we don't know if they can do this or not) due to a
thermal condition, and we don't want to override that, should they be
capable of it.

We should be setting the workaround flag to "status known" upon resume, as
both reports and a exaustive search on the DSDT tables at acpi.sf.net show
that the DSDTs always enable the fan on resume, thus working around the
bug.  But since we don't have suspend/resume handlers in ibm-acpi yet and
the "EC register 0x2f was modified" logic is likely to catch the change
anyway, we don't.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

 drivers/acpi/ibm_acpi.c |   53 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index af83977..f742c33 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -362,7 +362,7 @@ enum {					/* Fan control constants */
 						 * control */
 };
 
-static char* ibm_thinkpad_ec_found = NULL;
+static char *ibm_thinkpad_ec_found = NULL;
 
 struct ibm_struct {
 	char *name;
@@ -1794,13 +1794,15 @@ static enum fan_status_access_mode fan_s
 static enum fan_control_access_mode fan_control_access_mode;
 static enum fan_control_commands fan_control_commands;
 
+static int fan_control_status_known;
+static u8 fan_control_initial_status;
+
 static int fan_init(void)
 {
-	u8 status;
-
 	fan_status_access_mode = IBMACPI_FAN_NONE;
 	fan_control_access_mode = IBMACPI_FAN_WR_NONE;
 	fan_control_commands = 0;
+	fan_control_status_known = 1;
 
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
@@ -1808,8 +1810,33 @@ static int fan_init(void)
 	} else {
 		/* all other ThinkPads: note that even old-style
 		 * ThinkPad ECs supports the fan control register */
-		if (likely(acpi_ec_read(fan_status_offset, &status))) {
+		if (likely(acpi_ec_read(fan_status_offset,
+					&fan_control_initial_status))) {
 			fan_status_access_mode = IBMACPI_FAN_RD_TPEC;
+
+			/* In some ThinkPads, neither the EC nor the ACPI
+			 * DSDT initialize the fan status, and it ends up
+			 * being set to 0x07 when it *could* be either
+			 * 0x07 or 0x80.
+			 *
+			 * Enable for TP-1Y (T43), TP-78 (R51e),
+			 * TP-76 (R52), TP-70 (T43, R52), which are known
+			 * to be buggy. */
+			if (fan_control_initial_status == 0x07 &&
+			    ibm_thinkpad_ec_found &&
+			    ((ibm_thinkpad_ec_found[0] == '1' &&
+			      ibm_thinkpad_ec_found[1] == 'Y') ||
+			     (ibm_thinkpad_ec_found[0] == '7' &&
+			      (ibm_thinkpad_ec_found[1] == '6' ||
+			       ibm_thinkpad_ec_found[1] == '8' ||
+			       ibm_thinkpad_ec_found[1] == '0'))
+			    )) {
+				printk(IBM_NOTICE
+				       "fan_init: initial fan status is "
+				       "unknown, assuming it is in auto "
+				       "mode\n");
+				fan_control_status_known = 0;
+			}
 		} else {
 			printk(IBM_ERR
 			       "ThinkPad ACPI EC access misbehaving, "
@@ -1930,9 +1957,21 @@ static int fan_read(char *p)
 		if ((rc = fan_get_status(&status)) < 0)
 			return rc;
 
+		if (unlikely(!fan_control_status_known)) {
+			if (status != fan_control_initial_status)
+				fan_control_status_known = 1;
+			else
+				/* Return most likely status. In fact, it
+				 * might be the only possible status */
+				status = IBMACPI_FAN_EC_AUTO;
+		}
+
 		len += sprintf(p + len, "status:\t\t%s\n",
 			       (status != 0) ? "enabled" : "disabled");
 
+		/* No ThinkPad boots on disengaged mode, we can safely
+		 * assume the tachometer is online if fan control status
+		 * was unknown */
 		if ((rc = fan_get_speed(&speed)) < 0)
 			return rc;
 
@@ -1997,6 +2036,8 @@ static int fan_set_level(int level)
 
 		if (!acpi_ec_write(fan_status_offset, level))
 			return -EIO;
+		else
+			fan_control_status_known = 1;
 		break;
 
 	default:
@@ -2022,6 +2063,8 @@ static int fan_set_enable(void)
 
 		if (!acpi_ec_write(fan_status_offset, s))
 			return -EIO;
+		else
+			fan_control_status_known = 1;
 		break;
 
 	case IBMACPI_FAN_WR_ACPI_SFAN:
@@ -2051,6 +2094,8 @@ static int fan_set_disable(void)
 	case IBMACPI_FAN_WR_TPEC:
 		if (!acpi_ec_write(fan_status_offset, 0x00))
 			return -EIO;
+		else
+			fan_control_status_known = 1;
 		break;
 
 	case IBMACPI_FAN_WR_ACPI_SFAN:
