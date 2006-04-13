From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] ACPI C-States: accounting of sleep times
Date: Thu, 13 Apr 2006 22:21:23 +0200
Message-ID: <20060413202123.GA7522@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:49109 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932458AbWDMUWT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Apr 2006 16:22:19 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com

Track the actual time spent in C-States (C2 upwards, we can't
determine this for C1), not only the number of invocations. This is
especially useful for dynamic ticks / "tickless systems", but is also
of interest on normal systems, as any interrupt activity leads to
C-States being exited, not only the timer interrupt.

The time is being measured in PM timer ticks, so an increase by one equals
279 nanoseconds.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 drivers/acpi/processor_idle.c |   10 ++++++----
 include/acpi/processor.h      |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

3997a08ff5aa0553dfff81801c3690a5c91ac7bc
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 80fa434..4f166fa 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -322,8 +322,6 @@ static void acpi_processor_idle(void)
 		cx = &pr->power.states[ACPI_STATE_C1];
 #endif
 
-	cx->usage++;
-
 	/*
 	 * Sleep:
 	 * ------
@@ -421,6 +419,9 @@ static void acpi_processor_idle(void)
 		local_irq_enable();
 		return;
 	}
+	cx->usage++;
+	if ((cx->type != ACPI_STATE_C1) && (sleep_ticks > 0))
+		cx->time += sleep_ticks;
 
 	next_state = pr->power.state;
 
@@ -1055,9 +1056,10 @@ static int acpi_processor_power_seq_show
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
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index badf027..ca0e031 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -51,6 +51,7 @@ struct acpi_processor_cx {
 	u32 latency_ticks;
 	u32 power;
 	u32 usage;
+	u64 time;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
 };
-- 
1.2.4

