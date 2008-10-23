From: Len Brown <lenb@kernel.org>
Subject: [PATCH 077/122] ACPI: thinkpad-acpi: attempt to preserve fan state on
 resume
Date: Thu, 23 Oct 2008 02:38:51 -0400
Message-ID: <75700e53cd14ccc7a5a42547497dff11fe209186.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218AbYJWGkS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:18 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K960023UIIYSRCA@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:11 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hartmann <richih.mailinglist@gmail.com>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Attempt to preserve fan state across sleep and hibernation if the fan
control mode is enabled.

For safety reasons, only the PWM OFF (fan at 100%) or maximum
closed-loop level (level 7) are preserved.  If the fan state was set
to anything else, it will not be restored.

Also, should the fan be at PWM OFF mode at resume, it will be left at
that state (but this is extremely unlikely, no ThinkPad firmware was
ever reported to do this).

For reference, the known states used for fan control upon resume by
the firmware  are either "auto" or "level 7" depending on whether the
laptop wakes due to normal conditions or a thermal emergency.

Fixes: http://bugzilla.kernel.org/show_bug.cgi?id=11331

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   48 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 6b93007..1dcf066 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -5983,6 +5983,52 @@ static void fan_exit(void)
 	flush_workqueue(tpacpi_wq);
 }
 
+static void fan_suspend(pm_message_t state)
+{
+	if (!fan_control_allowed)
+		return;
+
+	/* Store fan status in cache */
+	fan_get_status_safe(NULL);
+	if (tp_features.fan_ctrl_status_undef)
+		fan_control_desired_level = TP_EC_FAN_AUTO;
+}
+
+static void fan_resume(void)
+{
+	u8 saved_fan_level;
+	u8 current_level = 7;
+	bool do_set = false;
+
+	/* DSDT *always* updates status on resume */
+	tp_features.fan_ctrl_status_undef = 0;
+
+	saved_fan_level = fan_control_desired_level;
+	if (!fan_control_allowed ||
+	    (fan_get_status_safe(&current_level) < 0))
+		return;
+
+	switch (fan_control_access_mode) {
+	case TPACPI_FAN_WR_ACPI_SFAN:
+		do_set = (saved_fan_level > current_level);
+		break;
+	case TPACPI_FAN_WR_ACPI_FANS:
+	case TPACPI_FAN_WR_TPEC:
+		do_set = ((saved_fan_level & TP_EC_FAN_FULLSPEED) ||
+			  (saved_fan_level == 7 &&
+			   !(current_level & TP_EC_FAN_FULLSPEED)));
+		break;
+	default:
+		return;
+	}
+	if (do_set) {
+		printk(TPACPI_NOTICE
+			"restoring fan level to 0x%02x\n",
+			saved_fan_level);
+		fan_set_level_safe(saved_fan_level);
+	}
+}
+
 static int fan_read(char *p)
 {
 	int len = 0;
@@ -6174,6 +6220,8 @@ static struct ibm_struct fan_driver_data = {
 	.read = fan_read,
 	.write = fan_write,
 	.exit = fan_exit,
+	.suspend = fan_suspend,
+	.resume = fan_resume,
 };
 
 /****************************************************************************
-- 
1.5.5.1

