From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: cpuidle: port idle timer suspend/resume workaround to cpuidle
Date: Thu, 4 Oct 2007 01:22:43 -0400
Message-ID: <200710040122.43759.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46708 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391AbXJDFXI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Oct 2007 01:23:08 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI List <linux-acpi@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

From: Len Brown <len.brown@intel.com>

Some timers stop during C2 and C3, and so there are various
generations of timer broadcast workarounds to deal with that.
But that (already complex) code gets confused during suspend.

As it is unlikely that deep C-states would save much power
during the actual suspend/resume process anyway, deep C-states
were disabled via the addition of .suspend/.resume hooks
in to the ACPI processor driver.

Here that workaround is ported to the cpuidle version of
the ACPI idle loop.  Technically, ACPI could un-register
itself from cpuidle on .suspend, but that code path
is currently quite cumbersome.  So instead,
we simply invoke C1 from the C2 and C3 handlers
for the duration of .suspend/.resume.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 processor_idle.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d924aa3..3b62632 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1373,6 +1373,10 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return 0;
 
+ 	if (acpi_idle_suspend)
+ 		return(acpi_idle_enter_c1(dev, state));
+ 
+
 	local_irq_disable();
 	current_thread_info()->status &= ~TS_POLLING;
 	/*
@@ -1431,6 +1435,9 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return 0;
 
+	if (acpi_idle_suspend)
+		return(acpi_idle_enter_c1(dev, state));
+
 	local_irq_disable();
 	current_thread_info()->status &= ~TS_POLLING;
 	/*
