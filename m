From: akpm@osdl.org
Subject: + acpi-c-states-only-demote-on-current-bus-mastering-activity.patch added to -mm tree
Date: Tue, 20 Jun 2006 00:49:10 -0700
Message-ID: <200606200749.k5K7nAes000433@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:51081 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932537AbWFTHtN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 03:49:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mm-commits@vger.kernel.org
Cc: linux@dominikbrodowski.net, linux-acpi@vger.kernel.org


The patch titled

     ACPI C-States: only demote on current bus mastering activity

has been added to the -mm tree.  Its filename is

     acpi-c-states-only-demote-on-current-bus-mastering-activity.patch

See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
out what to do about this

------------------------------------------------------
Subject: ACPI C-States: only demote on current bus mastering activity
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

Patches currently in -mm which might be from linux@dominikbrodowski.net are

acpi-c-states-accounting-of-sleep-states.patch
acpi-c-states-bm_activity-improvements.patch
acpi-c-states-only-demote-on-current-bus-mastering-activity.patch
git-cpufreq.patch
git-pcmcia.patch
com20020_cs-more-device-support.patch
kill-open-coded-offsetof-in-cm4000_csc-zero_dev.patch
insert-identical-resources-above-existing-resources.patch
make-sure-nobodys-leaking-resources.patch
random-remove-bogus-sa_sample_random-from-at91-compact-flash-driver.patch

