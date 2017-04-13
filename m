From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 08/13] ACPI/processor: Replace racy task affinity
 logic.
Date: Thu, 13 Apr 2017 14:01:42 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1704131345160.2408@nanos>
References: <20170412200726.941336635@linutronix.de> <20170412201042.785920903@linutronix.de> <20170413113945.mkdsk24rovzcrod6@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:37582 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbdDMMCL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Apr 2017 08:02:11 -0400
In-Reply-To: <20170413113945.mkdsk24rovzcrod6@hirez.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Tony Luck <tony.luck@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-acpi@vger.kernel.org

On Thu, 13 Apr 2017, Peter Zijlstra wrote:
> 
> That makes my machine sad...
> [    9.786610]  work_on_cpu+0x82/0x90
> [    9.790404]  ? __usermodehelper_disable+0x110/0x110
> [    9.795846]  ? __acpi_processor_get_throttling+0x20/0x20
> [    9.801773]  acpi_processor_set_throttling+0x199/0x220
> [    9.807506]  ? trace_hardirqs_on_caller+0xfb/0x1d0
> [    9.812851]  acpi_processor_get_throttling_ptc+0xec/0x180
> [    9.818876]  __acpi_processor_get_throttling+0xf/0x20
> [    9.824511]  work_for_cpu_fn+0x14/0x20
> [    9.828692]  process_one_work+0x261/0x670
> [    9.833165]  worker_thread+0x21b/0x3f0
> [    9.837348]  kthread+0x108/0x140
> [    9.840947]  ? process_one_work+0x670/0x670
> [    9.845611]  ? kthread_create_on_node+0x40/0x40
> [    9.850667]  ret_from_fork+0x31/0x40

Yuck. So the call chain is:

acpi_processor_get_throttling()
  work_on_cpu(acpi_processor_get_throttling)

That work does:

__acpi_processor_get_throttling()
    acpi_processor_get_throttling_ptc()
      acpi_processor_set_throttling()
        work_on_cpu(__acpi_processor_set_throttling)

Why the heck calls a get_throttling() function set_throttling()? I'm mildly
surprised.

Does the delta patch below cure the problem?

Thanks,

	tglx

8<--------------

--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -62,8 +62,8 @@ struct acpi_processor_throttling_arg {
 #define THROTTLING_POSTCHANGE      (2)
 
 static int acpi_processor_get_throttling(struct acpi_processor *pr);
-int acpi_processor_set_throttling(struct acpi_processor *pr,
-						int state, bool force);
+static int __acpi_processor_set_throttling(struct acpi_processor *pr,
+					   int state, bool force, bool direct);
 
 static int acpi_processor_update_tsd_coord(void)
 {
@@ -891,7 +891,8 @@ static int acpi_processor_get_throttling
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				"Invalid throttling state, reset\n"));
 			state = 0;
-			ret = acpi_processor_set_throttling(pr, state, true);
+			ret = __acpi_processor_set_throttling(pr, state, true,
+							      true);
 			if (ret)
 				return ret;
 		}
@@ -1075,8 +1076,15 @@ static long acpi_processor_throttling_fn
 			arg->target_state, arg->force);
 }
 
-int acpi_processor_set_throttling(struct acpi_processor *pr,
-						int state, bool force)
+static int call_on_cpu(int cpu, long (*fn)(void *), void *arg, bool direct)
+{
+	if (direct)
+		return fn(arg);
+	return work_on_cpu(cpu, fn, arg);
+}
+
+static int __acpi_processor_set_throttling(struct acpi_processor *pr,
+					   int state, bool force, bool direct)
 {
 	int ret = 0;
 	unsigned int i;
@@ -1125,7 +1133,8 @@ int acpi_processor_set_throttling(struct
 		arg.pr = pr;
 		arg.target_state = state;
 		arg.force = force;
-		ret = work_on_cpu(pr->id, acpi_processor_throttling_fn, &arg);
+		ret = call_on_cpu(pr->id, acpi_processor_throttling_fn, &arg,
+				  direct);
 	} else {
 		/*
 		 * When the T-state coordination is SW_ALL or HW_ALL,
@@ -1158,8 +1167,8 @@ int acpi_processor_set_throttling(struct
 			arg.pr = match_pr;
 			arg.target_state = state;
 			arg.force = force;
-			ret = work_on_cpu(pr->id, acpi_processor_throttling_fn,
-				&arg);
+			ret = call_on_cpu(pr->id, acpi_processor_throttling_fn,
+					  &arg, direct);
 		}
 	}
 	/*
@@ -1177,6 +1186,12 @@ int acpi_processor_set_throttling(struct
 	return ret;
 }
 
+int acpi_processor_set_throttling(struct acpi_processor *pr, int state,
+				  bool force)
+{
+	return __acpi_processor_set_throttling(pr, state, force, false);
+}
+
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
 	int result = 0;
