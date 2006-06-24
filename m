From: akpm@osdl.org
Subject: [patch 15/18] ACPI C-States: only demote on current bus mastering activity
Date: Sat, 24 Jun 2006 16:37:14 -0700
Message-ID: <200606242337.k5ONbFxZ008097@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:20380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751213AbWFXXop (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jun 2006 19:44:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, linux@dominikbrodowski.net


From: Dominik Brodowski <linux@dominikbrodowski.net>

Only if bus master activity is going on at the present, we should avoid
entering C3-type sleep, as it might be a faulty transition.  As long as the
bm_activity bitmask was based on the number of calls to the ACPI idle
function, looking at previous moments made sense.  Now, with it being based on
what happened this jiffy, looking at this jiffy should be sufficient.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: <linux-acpi@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_idle.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/processor_idle.c~acpi-c-states-only-demote-on-current-bus-mastering-activity drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~acpi-c-states-only-demote-on-current-bus-mastering-activity
+++ a/drivers/acpi/processor_idle.c
@@ -290,10 +290,10 @@ static void acpi_processor_idle(void)
 		pr->power.bm_check_timestamp = jiffies;
 
 		/*
-		 * Apply bus mastering demotion policy.  Automatically demote
+		 * If bus mastering is or was active this jiffy, demote
 		 * to avoid a faulty transition.  Note that the processor
 		 * won't enter a low-power state during this call (to this
-		 * funciton) but should upon the next.
+		 * function) but should upon the next.
 		 *
 		 * TBD: A better policy might be to fallback to the demotion
 		 *      state (use it for this quantum only) istead of
@@ -301,7 +301,8 @@ static void acpi_processor_idle(void)
 		 *      qualification.  This may, however, introduce DMA
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
-		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
+		if ((pr->power.bm_activity & 0x1) &&
+		    cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
 			goto end;
_
