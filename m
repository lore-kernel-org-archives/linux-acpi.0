From: akpm@osdl.org
Subject: + acpi-c-states-accounting-of-sleep-states.patch added to -mm tree
Date: Tue, 20 Jun 2006 00:49:06 -0700
Message-ID: <200606200749.k5K7n6MB000427@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:48521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932087AbWFTHtK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 03:49:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mm-commits@vger.kernel.org
Cc: linux@dominikbrodowski.net, linux-acpi@vger.kernel.org


The patch titled

     ACPI C-States: accounting of sleep states

has been added to the -mm tree.  Its filename is

     acpi-c-states-accounting-of-sleep-states.patch

See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
out what to do about this

------------------------------------------------------
Subject: ACPI C-States: accounting of sleep states
From: Dominik Brodowski <linux@dominikbrodowski.net>


Track the actual time spent in C-States (C2 upwards, we can't determine this
for C1), not only the number of invocations.  This is especially useful for
dynamic ticks / "tickless systems", but is also of interest on normal systems,
as any interrupt activity leads to C-States being exited, not only the timer
interrupt.

The time is being measured in PM timer ticks, so an increase by one equals 279
nanoseconds.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: <linux-acpi@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_idle.c |   10 ++++++----
 include/acpi/processor.h      |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff -puN drivers/acpi/processor_idle.c~acpi-c-states-accounting-of-sleep-states drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~acpi-c-states-accounting-of-sleep-states
+++ a/drivers/acpi/processor_idle.c
@@ -325,8 +325,6 @@ static void acpi_processor_idle(void)
 		cx = &pr->power.states[ACPI_STATE_C1];
 #endif
 
-	cx->usage++;
-
 	/*
 	 * Sleep:
 	 * ------
@@ -424,6 +422,9 @@ static void acpi_processor_idle(void)
 		local_irq_enable();
 		return;
 	}
+	cx->usage++;
+	if ((cx->type != ACPI_STATE_C1) && (sleep_ticks > 0))
+		cx->time += sleep_ticks;
 
 	next_state = pr->power.state;
 
@@ -1058,9 +1059,10 @@ static int acpi_processor_power_seq_show
 		else
 			seq_puts(seq, "demotion[--] ");
 
-		seq_printf(seq, "latency[%03d] usage[%08d]\n",
+		seq_printf(seq, "latency[%03d] usage[%08d] duration[%020llu]\n",
 			   pr->power.states[i].latency,
-			   pr->power.states[i].usage);
+			   pr->power.states[i].usage,
+			   pr->power.states[i].time);
 	}
 
       end:
diff -puN include/acpi/processor.h~acpi-c-states-accounting-of-sleep-states include/acpi/processor.h
--- a/include/acpi/processor.h~acpi-c-states-accounting-of-sleep-states
+++ a/include/acpi/processor.h
@@ -63,6 +63,7 @@ struct acpi_processor_cx {
 	u32 latency_ticks;
 	u32 power;
 	u32 usage;
+	u64 time;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
 };
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

