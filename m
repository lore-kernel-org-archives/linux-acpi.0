From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC] clear GPE earily in resume
Date: Thu, 14 Jun 2007 09:36:50 +0800
Message-ID: <1181785011.19274.6.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13445 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757842AbXFNBlP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2007 21:41:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "robert.moore" <robert.moore@intel.com>

Wakeup GPE hasn't a handler. If system is waked up by such GPE like a
USB hotplug, I saw a lot of error reporting the GPE hasn't handler.
acpi_leave_sleep_state will clear the GPE but it's too late, we should
doe it before interrupt is re-enabled. 

Maybe we should just clear wakeup GPE here, but clear all GPEs sounds
not harmful in my test. Not sure other systems.

Index: 2.6.22-rc/drivers/acpi/sleep/main.c
===================================================================
--- 2.6.22-rc.orig/drivers/acpi/sleep/main.c	2007-06-11 15:31:03.000000000 +0800
+++ 2.6.22-rc/drivers/acpi/sleep/main.c	2007-06-14 09:31:54.000000000 +0800
@@ -104,6 +104,8 @@
 	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
 		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
 
+	acpi_hw_disable_all_gpes();
+
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
