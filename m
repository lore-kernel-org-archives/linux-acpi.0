From: Ocean HY1 He <hehy1@lenovo.com>
Subject: [PATCH v2] ACPI: Execute the _PTS method when system reboot
Date: Mon, 27 Jun 2016 14:50:16 +0000
Message-ID: <1467038724-13455-1-git-send-email-hehy1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.12]:31777 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869AbcF0Oub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jun 2016 10:50:31 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Tanaka <dtanaka@lenovo.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, Sumeet Kochar <skochar@lenovo.com>, Ocean HY1 He <hehy1@lenovo.com>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>

The _PTS control method is defined in the section 7.4.1 of acpi 6.0
spec. The _PTS control method is executed by the OS during the sleep
transition process for S1, S2, S3, S4, and for orderly S5 shutdown.

The _PTS control method provides the BIOS a mechanism for performing
some housekeeping, such as writing the sleep type value to the embedded
controller, before entering the system sleeping state. Note that some
Lenovo Server BIOS use this mechanism to detect reboot event and
prompt user by popped dialog box.

According to section 7.5 of acpi 6.0 spec, _PTS should run after _TTS.
Add a _PTS evaulation to the existing _TTS reboot notifier and change
the notifier name to reflect the fact that it's not for _TTS only any
more.

Signed-off-by: Ocean He <hehy1@lenovo.com>
Signed-off-by: Nagananda Chumbalkar <nchumbalkar@lenovo.com>
---
Patch changelogs
v2:
To simplify patch, move _PTS evaulation to the existing _TTS notifier
https://lkml.org/lkml/2016/5/9/31

 drivers/acpi/sleep.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 7a2e4d4..2b38c1b 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -47,15 +47,32 @@ static void acpi_sleep_tts_switch(u32 acpi_state)
 	}
 }
 
-static int tts_notify_reboot(struct notifier_block *this,
+static void acpi_sleep_pts_switch(u32 acpi_state)
+{
+	acpi_status status;
+
+	status = acpi_execute_simple_method(NULL, "\\_PTS", acpi_state);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		/*
+		 * OS can't evaluate the _PTS object correctly. Some warning
+		 * message will be printed. But it won't break anything.
+		 */
+		printk(KERN_NOTICE "Failure in evaluating _PTS object\n");
+	}
+}
+
+static int sleep_notify_reboot(struct notifier_block *this,
 			unsigned long code, void *x)
 {
 	acpi_sleep_tts_switch(ACPI_STATE_S5);
+
+	acpi_sleep_pts_switch(ACPI_STATE_S5);
+
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block tts_notifier = {
-	.notifier_call	= tts_notify_reboot,
+static struct notifier_block sleep_notifier = {
+	.notifier_call	= sleep_notify_reboot,
 	.next		= NULL,
 	.priority	= 0,
 };
@@ -899,9 +916,9 @@ int __init acpi_sleep_init(void)
 	pr_info(PREFIX "(supports%s)\n", supported);
 
 	/*
-	 * Register the tts_notifier to reboot notifier list so that the _TTS
-	 * object can also be evaluated when the system enters S5.
+	 * Register the sleep_notifier to reboot notifier list so that the _TTS
+	 * and _PTS object can also be evaluated when the system enters S5.
 	 */
-	register_reboot_notifier(&tts_notifier);
+	register_reboot_notifier(&sleep_notifier);
 	return 0;
 }
-- 
1.8.3.1
