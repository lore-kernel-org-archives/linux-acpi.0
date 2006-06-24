From: akpm@osdl.org
Subject: [patch 13/18] ACPI C-States: accounting of sleep states
Date: Sat, 24 Jun 2006 16:37:06 -0700
Message-ID: <200606242337.k5ONb6ne008083@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:23708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751220AbWFXXou (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jun 2006 19:44:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, linux@dominikbrodowski.net


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
@@ -62,6 +62,7 @@ struct acpi_processor_cx {
 	u32 latency_ticks;
 	u32 power;
 	u32 usage;
+	u64 time;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
 };
_
