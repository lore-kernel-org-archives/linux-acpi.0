From: Ocean HY1 He <hehy1@lenovo.com>
Subject: [PATCH] ACPI: Execute the _PTS method when system reboot
Date: Mon, 9 May 2016 05:50:11 +0000
Message-ID: <1462772495-71113-1-git-send-email-hehy1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.193]:16240 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864AbcEIGC1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 May 2016 02:02:27 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Tanaka <dtanaka@lenovo.com>, Ocean HY1 He <hehy1@lenovo.com>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>

The _PTS control method is defined in the section 7.4.1 of acpi 6.0
spec. The _PTS control method is executed by the OS during the sleep
transition process for S1, S2, S3, S4, and for orderly S5 shutdown.
The sleeping state value (For example, 1, 2, 3, 4 or 5 for the S5
soft-off state) is passed to the _PTS control method. This method
is called after OSPM has notified native device drivers of the sleep
state transition and before the OSPM has had a chance to fully
prepare the system for a sleep state transition.

The _PTS control method provides the BIOS a mechanism for performing
some housekeeping, such as writing the sleep type value to the embedded
controller, before entering the system sleeping state.

According to section 7.5 of acpi 6.0 spec, _PTS should run after _TTS.

Thus, a _PTS block notifier is added to the reboot notifier list so that
the _PTS object will also be evaluated when the system reboot.

Signed-off-by: Ocean He <hehy1@lenovo.com>
Signed-off-by: Nagananda Chumbalkar <nchumbalkar@lenovo.com>
---
 drivers/acpi/sleep.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 2a8b596..8b290fb 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -55,6 +55,26 @@ static struct notifier_block tts_notifier = {
 	.priority	= 0,
 };
 
+static int pts_notify_reboot(struct notifier_block *this,
+			unsigned long code, void *x)
+{
+	acpi_status status;
+
+	status = acpi_execute_simple_method(NULL, "\\_PTS", ACPI_STATE_S5);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		/* It won't break anything. */
+		printk(KERN_NOTICE "Failure in evaluating _PTS object\n");
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pts_notifier = {
+	.notifier_call	= pts_notify_reboot,
+	.next		= NULL,
+	.priority	= 0,
+};
+
 static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
@@ -896,5 +916,12 @@ int __init acpi_sleep_init(void)
 	 * object can also be evaluated when the system enters S5.
 	 */
 	register_reboot_notifier(&tts_notifier);
+
+	/*
+	 * According to section 7.5 of acpi 6.0 spec, _PTS should run after
+	 * _TTS when the system enters S5.
+	 */
+	register_reboot_notifier(&pts_notifier);
+
 	return 0;
 }
-- 
1.8.3.1
