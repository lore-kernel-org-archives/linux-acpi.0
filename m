From: Venkatesh Pallipadi <venki@google.com>
Subject: [PATCH] acpi: Don't let acpi_pad needlessly mark TSC unstable
Date: Tue, 18 May 2010 14:39:16 -0700
Message-ID: <1274218756-31306-1-git-send-email-venki@google.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:4070 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab0ERVjb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 May 2010 17:39:31 -0400
Received: from kpbe19.cbf.corp.google.com (kpbe19.cbf.corp.google.com [172.25.105.83])
	by smtp-out.google.com with ESMTP id o4ILdSaE006318
	for <linux-acpi@vger.kernel.org>; Tue, 18 May 2010 14:39:29 -0700
Received: from pzk12 (pzk12.prod.google.com [10.243.19.140])
	by kpbe19.cbf.corp.google.com with ESMTP id o4ILdRAJ028538
	for <linux-acpi@vger.kernel.org>; Tue, 18 May 2010 14:39:27 -0700
Received: by pzk12 with SMTP id 12so4106253pzk.9
        for <linux-acpi@vger.kernel.org>; Tue, 18 May 2010 14:39:27 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI list <linux-acpi@vger.kernel.org>, Shaohua Li <shaohua.li@intel.com>, Venkatesh Pallipadi <venki@google.com>

acpi pad driver kind of aggressively marks TSC as unstable at init
time, on mwait capable and non X86_FEATURE_NONSTOP_TSC systems. This is
irrespective of whether pad driver is ever going to be used on the
system or deep C-states are supported/used. This will affect every user
who just happens to compile in (or get a kernel version which
compiles in) acpi pad driver.

Move mark_tsc_unstable() out of init to the actual idle invocation path
of the pad driver.

There is also another bug/missing_feature in the code that it does not
support 'always running apic timer' and switches to broadcast mode
unconditionally. Shaohua, can you take a look at that please.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
---
 drivers/acpi/acpi_pad.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 19dacfd..8ca490b 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -43,6 +43,10 @@ static DEFINE_MUTEX(isolated_cpus_lock);
 #define CPUID5_ECX_EXTENSIONS_SUPPORTED (0x1)
 #define CPUID5_ECX_INTERRUPT_BREAK	(0x2)
 static unsigned long power_saving_mwait_eax;
+
+static unsigned char tsc_detected_unstable;
+static unsigned char tsc_marked_unstable;
+
 static void power_saving_mwait_init(void)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -87,8 +91,8 @@ static void power_saving_mwait_init(void)
 
 		/*FALL THROUGH*/
 	default:
-		/* TSC could halt in idle, so notify users */
-		mark_tsc_unstable("TSC halts in idle");
+		/* TSC could halt in idle */
+		tsc_detected_unstable = 1;
 	}
 #endif
 }
@@ -178,6 +182,11 @@ static int power_saving_thread(void *data)
 		expire_time = jiffies + HZ * (100 - idle_pct) / 100;
 
 		while (!need_resched()) {
+			if (tsc_detected_unstable && !tsc_marked_unstable) {
+				/* TSC could halt in idle, so notify users */
+				mark_tsc_unstable("TSC halts in idle");
+				tsc_marked_unstable = 1;
+			}
 			local_irq_disable();
 			cpu = smp_processor_id();
 			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
-- 
1.7.0.1

