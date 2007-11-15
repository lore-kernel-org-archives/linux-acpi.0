From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI: Disable all GPEs before re-enable interrupts
Date: Thu, 15 Nov 2007 17:18:09 +0800
Message-ID: <1195118289.6817.47.camel@yakui_zhao.sh.intel.com>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
	 <200710092343.40843.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54975 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbXKOJJI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2007 04:09:08 -0500
In-Reply-To: <200710092343.40843.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: Disable all GPEs before re-enable interrupts.
From: Zhao Yakui  <yakui.zhao@intel.com>

Some wakeup gpes have no handler. If system is waked up by such GPE like
a USB hotplug, sometimes it will cause a lot of errors reporting that
the GPE has no handler .
Of course acpi_leave_sleep_state will disable and clear the GPE but it's
too late. It should be done before interrupt is re-enabled.

Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>

---
 drivers/acpi/sleep/main.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6.24-rc2/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.24-rc2.orig/drivers/acpi/sleep/main.c
+++ linux-2.6.24-rc2/drivers/acpi/sleep/main.c
@@ -146,6 +146,13 @@ static int acpi_pm_enter(suspend_state_t
 	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
 		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
 
+	/*
+	 * Disable and clear GPE status before interrupt is enabled.Some GPEs
+	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
+	 * acpi_leave_sleep_state will reenable specific GPEs later.
+	 */
+	acpi_hw_disable_all_gpes();
+
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
