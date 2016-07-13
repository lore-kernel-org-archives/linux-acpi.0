From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [patch V2 37/67] ACPI/processor: Avoid STARTING/DYING actions in a
 more logical way
Date: Wed, 13 Jul 2016 17:16:38 -0000
Message-ID: <20160713153335.964962885@linutronix.de>
References: <20160713153219.128052238@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40197 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbcGMRS7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2016 13:18:59 -0400
Content-Disposition: inline;
 filename=0036-ACPI-processor-Avoid-STARTING-DYING-actions-in-a-mor.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, rt@linutronix.de, Richard Cochran <rcochran@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>

From: Richard Cochran <rcochran@linutronix.de>

As part of the hotplug cleanup, the CPU_STARTING/DYING actions are going
away soon.  This driver needlessly uses those two macro, and so this patch
replaces that code with something more sensible.

Commit:

  8da8373447d6a57a5a9f55233d35beb15d92d0d2 ("ACPI / processor: Fix STARTING/DYING action in acpi_cpu_soft_notify()")

added checks for those two actions, because the notification callback can
sleep, causing a hung CPU. This patch instead checks for the ONLINE/DEAD
actions, which are the ones that are handled by the driver in the first
place.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 drivers/acpi/processor_driver.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index d2fa8cb..eecdb19 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -118,12 +118,13 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 	struct acpi_device *device;
 	action &= ~CPU_TASKS_FROZEN;
 
-	/*
-	 * CPU_STARTING and CPU_DYING must not sleep. Return here since
-	 * acpi_bus_get_device() may sleep.
-	 */
-	if (action == CPU_STARTING || action == CPU_DYING)
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_DEAD:
+		break;
+	default:
 		return NOTIFY_DONE;
+	}
 
 	if (!pr || acpi_bus_get_device(pr->handle, &device))
 		return NOTIFY_DONE;
-- 
2.8.1



