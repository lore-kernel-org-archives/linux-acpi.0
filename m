From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI:Disable all GPEs before re-enable interrupts
Date: Mon, 27 Aug 2007 16:49:29 +0800
Message-ID: <1188204569.5205.14.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53770 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbXH0Ipc (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2007 04:45:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Linux-acpi@vger.kernel.org

Subject: ACPI: Disable all GPEs before re-enable interrupts.
From: Li Shaohua  <shaohua.li@intel.com>

Some wakeup gpes have no handler. If system is waked up by such GPE like
a USB hotplug, sometimes it will cause a lot of errors reporting that 
the GPE has no handler .
Of course acpi_leave_sleep_state will disable and clear the GPE but it's
too late. It should be done before interrupt is re-enabled.

Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>

---
 drivers/acpi/sleep/main.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6.23-rc3/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.23-rc3.orig/drivers/acpi/sleep/main.c
+++ linux-2.6.23-rc3/drivers/acpi/sleep/main.c
@@ -122,6 +122,12 @@ static int acpi_pm_enter(suspend_state_t
 	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
 		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
 
+	/*
+	 * Disable and clear GPE status before interrupt is enabled.Some GPEs
+	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
+	 * acpi_leave_sleep_state will reenable specific GPEs later.
+	 */
+	acpi_hw_disable_all_gpes();
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
