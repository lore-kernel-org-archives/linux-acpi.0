From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [patch 36/66] ACPI/processor: avoid STARTING/DYING actions in a more
 logical way
Date: Mon, 11 Jul 2016 12:28:47 -0000
Message-ID: <20160711122533.663727276@linutronix.de>
References: <20160711122450.923603742@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=0030-ACPI-processor-avoid-STARTING-DYING-actions-in-a-mor.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Richard Cochran <rcochran@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>
List-Id: linux-acpi@vger.kernel.org

From: Richard Cochran <rcochran@linutronix.de>

As part of the hotplug cleanup, the CPU_STARTING/DYING actions are going
away soon.  This driver needlessly uses those two macro, and so this patch
replaces that code with something more sensible.

Commit 8da8373447d6a57a5a9f55233d35beb15d92d0d2  ("ACPI / processor: Fix
STARTING/DYING action in acpi_cpu_soft_notify()") added checks for those
two actions, because the notification callback can sleep, causing a hung
CPU. This patch instead checks for the ONLINE/DEAD actions, which are the
ones that are handled by the driver in the first place.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

---
 drivers/acpi/processor_driver.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -118,12 +118,13 @@ static int acpi_cpu_soft_notify(struct n
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
