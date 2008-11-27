From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/11] ACPI: thinkpad-acpi: fix fan sleep/resume path
Date: Thu, 27 Nov 2008 02:25:13 -0500
Message-ID: <0081b162023690877e0096ef17a82ba1969befa8.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:42202 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbYK0HZ0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:26 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAZ0029ODYDUJFC@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:25:25 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
In-reply-to: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This fixes a regression from v2.6.27, caused by commit
5814f737e1cd2cfa2893badd62189acae3e1e1fd, "ACPI: thinkpad-acpi:
attempt to preserve fan state on resume".

It is possible for fan_suspend() to fail to properly initialize
fan_control_desired_level as required by fan_resume(), resulting on
the fan always being set to level 7 on resume if the user didn't
touch the fan controller.

In order to get fan sleep/resume handling to work right:

1. Fix the fan_suspend handling of the T43 firmware quirk. If it is
still undefined, we didn't touch the fan yet and that means we have no
business doing it on resume.

2. Store the fan level on its own variable to avoid any possible
issues with hijacking fan_control_desired_level (which isn't supposed
to have anything other than 0-7 in it, anyway).

3. Change the fan_resume code to me more straightforward to understand
(although we DO optimize the boolean logic there, otherwise it looks
disgusting).

4. Add comments to help understand what the code is supposed to be
doing.

5. Change fan_set_level to be less strict about how auto and
full-speed modes are requested.

http://bugzilla.kernel.org/show_bug.cgi?id=11982

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Reported-by: Tino Keitel <tino.keitel@tikei.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   57 +++++++++++++++++++++++++++++++++---------
 1 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7a4a26b..899766e 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -5318,6 +5318,7 @@ static enum fan_control_commands fan_control_commands;
 
 static u8 fan_control_initial_status;
 static u8 fan_control_desired_level;
+static u8 fan_control_resume_level;
 static int fan_watchdog_maxinterval;
 
 static struct mutex fan_mutex;
@@ -5440,8 +5441,8 @@ static int fan_set_level(int level)
 
 	case TPACPI_FAN_WR_ACPI_FANS:
 	case TPACPI_FAN_WR_TPEC:
-		if ((level != TP_EC_FAN_AUTO) &&
-		    (level != TP_EC_FAN_FULLSPEED) &&
+		if (!(level & TP_EC_FAN_AUTO) &&
+		    !(level & TP_EC_FAN_FULLSPEED) &&
 		    ((level < 0) || (level > 7)))
 			return -EINVAL;
 
@@ -6005,38 +6006,67 @@ static void fan_exit(void)
 
 static void fan_suspend(pm_message_t state)
 {
+	int rc;
+
 	if (!fan_control_allowed)
 		return;
 
 	/* Store fan status in cache */
-	fan_get_status_safe(NULL);
+	fan_control_resume_level = 0;
+	rc = fan_get_status_safe(&fan_control_resume_level);
+	if (rc < 0)
+		printk(TPACPI_NOTICE
+			"failed to read fan level for later "
+			"restore during resume: %d\n", rc);
+
+	/* if it is undefined, don't attempt to restore it.
+	 * KEEP THIS LAST */
 	if (tp_features.fan_ctrl_status_undef)
-		fan_control_desired_level = TP_EC_FAN_AUTO;
+		fan_control_resume_level = 0;
 }
 
 static void fan_resume(void)
 {
-	u8 saved_fan_level;
 	u8 current_level = 7;
 	bool do_set = false;
+	int rc;
 
 	/* DSDT *always* updates status on resume */
 	tp_features.fan_ctrl_status_undef = 0;
 
-	saved_fan_level = fan_control_desired_level;
 	if (!fan_control_allowed ||
+	    !fan_control_resume_level ||
 	    (fan_get_status_safe(&current_level) < 0))
 		return;
 
 	switch (fan_control_access_mode) {
 	case TPACPI_FAN_WR_ACPI_SFAN:
-		do_set = (saved_fan_level > current_level);
+		/* never decrease fan level */
+		do_set = (fan_control_resume_level > current_level);
 		break;
 	case TPACPI_FAN_WR_ACPI_FANS:
 	case TPACPI_FAN_WR_TPEC:
-		do_set = ((saved_fan_level & TP_EC_FAN_FULLSPEED) ||
-			  (saved_fan_level == 7 &&
-			   !(current_level & TP_EC_FAN_FULLSPEED)));
+		/* never decrease fan level, scale is:
+		 * TP_EC_FAN_FULLSPEED > 7 >= TP_EC_FAN_AUTO
+		 *
+		 * We expect the firmware to set either 7 or AUTO, but we
+		 * handle FULLSPEED out of paranoia.
+		 *
+		 * So, we can safely only restore FULLSPEED or 7, anything
+		 * else could slow the fan.  Restoring AUTO is useless, at
+		 * best that's exactly what the DSDT already set (it is the
+		 * slower it uses).
+		 *
+		 * Always keep in mind that the DSDT *will* have set the
+		 * fans to what the vendor supposes is the best level.  We
+		 * muck with it only to speed the fan up.
+		 */
+		if (fan_control_resume_level != 7 &&
+		    !(fan_control_resume_level & TP_EC_FAN_FULLSPEED))
+			return;
+		else
+			do_set = !(current_level & TP_EC_FAN_FULLSPEED) &&
+				 (current_level != fan_control_resume_level);
 		break;
 	default:
 		return;
@@ -6044,8 +6074,11 @@ static void fan_resume(void)
 	if (do_set) {
 		printk(TPACPI_NOTICE
 			"restoring fan level to 0x%02x\n",
-			saved_fan_level);
-		fan_set_level_safe(saved_fan_level);
+			fan_control_resume_level);
+		rc = fan_set_level_safe(fan_control_resume_level);
+		if (rc < 0)
+			printk(TPACPI_NOTICE
+				"failed to restore fan level: %d\n", rc);
 	}
 }
 
-- 
1.5.6.5

