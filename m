From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Account time spent in C-States [Was: [PATCH] i386 no idle HZ aka Dynticks 051203]
Date: Sun, 4 Dec 2005 13:32:08 +0100
Message-ID: <20051204123208.GA9817@dominikbrodowski.de>
References: <200512041737.07996.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932207AbVLDMnn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200512041737.07996.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>, Adam Belay <abelay@novell.com>, Daniel Petrini <d.pensator@gmail.com>, vatsa@in.ibm.com, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Keep track of the time actually spent sleeping in C2, C3-type sleep; not
only of the number of invocations of these sleep types. This is especially
useful when using "dynamic ticks" when the number of invocations do not
correlate to length of sleep.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -300,8 +300,6 @@ static void acpi_processor_idle(void)
 		}
 	}
 
-	cx->usage++;
-
 #ifdef CONFIG_HOTPLUG_CPU
 	/*
 	 * Check for P_LVL2_UP flag before entering C2 and above on
@@ -409,6 +407,15 @@ static void acpi_processor_idle(void)
 		local_irq_enable();
 		return;
 	}
+	cx->usage++;
+	if (cx->type != ACPI_STATE_C1) {
+		if (sleep_ticks > 0)
+			cx->time += sleep_ticks;
+	} else {
+		/* for C1, where we don't know the exact value, assume 0.5 of
+		 * a jiffy */
+		cx->time += (PM_TIMER_FREQUENCY / (2 * HZ));
+	}
 
 	next_state = pr->power.state;
 
@@ -1014,9 +1021,10 @@ static int acpi_processor_power_seq_show
 		else
 			seq_puts(seq, "demotion[--] ");
 
-		seq_printf(seq, "latency[%03d] usage[%08d]\n",
+		seq_printf(seq, "latency[%03d] usage[%08d] time[%020llu]\n",
 			   pr->power.states[i].latency,
-			   pr->power.states[i].usage);
+			   pr->power.states[i].usage,
+			   pr->power.states[i].time);
 	}
 
       end:
Index: working-tree/include/acpi/processor.h
===================================================================
--- working-tree.orig/include/acpi/processor.h
+++ working-tree/include/acpi/processor.h
@@ -51,6 +51,7 @@ struct acpi_processor_cx {
 	u32 latency_ticks;
 	u32 power;
 	u32 usage;
+	u64 time;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
 };
