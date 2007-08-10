From: akpm@linux-foundation.org
Subject: [patch 4/6] ACPI: move timer broadcast and pmtimer access before C3 arbiter shutdown
Date: Fri, 10 Aug 2007 13:45:17 -0700
Message-ID: <200708102045.l7AKjHgD007830@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55170 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936929AbXHJUqm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Aug 2007 16:46:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, us15@os.inf.tu-dresden.de, tglx@linutronix.de

From: Udo A. Steinberg <us15@os.inf.tu-dresden.de>

The chipset doc for IHC4 tells us:

1.In general, software should not attempt any non-posted accesses during
arbiter disable except to the ICH4's power management registers.  This implies
that interrupt handlers for any unmasked hardware interrupts and SMI/NMI
should check ARB_DIS status before reading from ICH devices.

So it's not a good idea to access ICH devices after arbiter shut down.

Signed-off-by: Udo A. Steinberg <us15@os.inf.tu-dresden.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_idle.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/processor_idle.c~acpi-move-timer-broadcast-and-pmtimer-access-before-c3-arbiter-shutdown drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~acpi-move-timer-broadcast-and-pmtimer-access-before-c3-arbiter-shutdown
+++ a/drivers/acpi/processor_idle.c
@@ -1009,6 +1009,12 @@ static int acpi_idle_enter_c3(struct cpu
 		return 0;
 	}
 
+	/*
+	 * Must be done before busmaster disable as we might need to
+	 * access HPET!
+	 */
+	acpi_state_timer_broadcast(pr, cx, 1);
+
 	/* disable bus master */
 	if (pr->flags.bm_check) {
 		spin_lock(&c3_lock);
@@ -1028,7 +1034,6 @@ static int acpi_idle_enter_c3(struct cpu
 
 	/* Get start time (ticks) */
 	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
-	acpi_state_timer_broadcast(pr, cx, 1);
 	acpi_idle_do_entry(cx);
 	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
_
