From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: [ACPI] [PATCHES] ACPI Processor update [idle, throttling,
	thermal, cpufreq]
Date: Fri, 5 Sep 2003 08:52:39 +0200
Sender: cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <20030905065239.GB4003@brodo.de>
References: <20030904222434.GC6350@brodo.de>
	<200309050023.06761.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200309050023.06761.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
Errors-To: cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dmitry,

Thanks for your input.

On Fri, Sep 05, 2003 at 12:23:06AM -0500, Dmitry Torokhov wrote:
> I have couple of concerns regarding P-states IO library, esp. 
> acpi_processor_get_frequency. It seems that ACPI does not allow
> to read current state without setting it first.

Indeed. The specification allows this behaviour. That's really annoying, but
well...

> Also, do you really need to do notify_transition twice 
> (acpi_processor_set_performance)?

No, it's a bug.

The attached patch should fix both issues.

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi-io-cpufreq.c linux/arch/i386/kernel/cpu/cpufreq/acpi-io-cpufreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/acpi-io-cpufreq.c	2003-09-04 21:36:58.000000000 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/acpi-io-cpufreq.c	2003-09-05 08:47:54.302664624 +0200
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <asm/uaccess.h>
+#include <asm/timex.h>
 
 #include <linux/acpi.h>
 #include <acpi/processor.h>
@@ -54,32 +55,16 @@
 	u16 				control_register;
 	u16 				status_register;
 
+	unsigned long			previous_freq;
 	struct cpufreq_frequency_table	*table;
 };
 
 static struct cpufreq_acpi_io_data acpi_io_data[NR_CPUS];
 
-static unsigned long acpi_processor_get_frequency (
-	struct cpufreq_acpi_io_data 	*data)
-{
-	unsigned int		i;
-	u16			port;
-	u8			value;
-
-	port = data->status_register;
-	value = inb(port);
-
-	for (i=0; i<data->data->state_count; i++) {
-		if (value == (u8) data->data->states[i].status)
-			return (1000 * data->data->states[i].core_frequency);
-	}
-
-	return 0;
-}
-
 static int acpi_processor_set_performance (
 	struct cpufreq_acpi_io_data 	*data,
-	int				state)
+	int				state,
+	unsigned int			notify)
 {
 	u16			port;
 	u8			value;
@@ -88,14 +73,12 @@
 
 	/* cpufreq frequency struct */
 	cpufreq_freqs.cpu = data->cpu;
-	cpufreq_freqs.old = acpi_processor_get_frequency(data);
+	cpufreq_freqs.old = data->previous_freq;
 	cpufreq_freqs.new = data->data->states[state].core_frequency;
 
 	/* notify cpufreq */
-	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
-
-	/* notify cpufreq */
-	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
+	if (notify)
+		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
 
 	/*
 	 * First we write the target state's 'control' value to the
@@ -129,18 +112,21 @@
 	}
 
 	/* notify cpufreq */
+	if (notify)
 	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
 
 	if (value != data->data->states[state].status) {
 		unsigned int tmp = cpufreq_freqs.new;
 		cpufreq_freqs.new = cpufreq_freqs.old;
 		cpufreq_freqs.old = tmp;
-		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
-		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
+		if (notify) {
+			cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
+			cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
+		}
 		printk(KERN_ERR "Transition failed\n");
 		return -EINVAL;
 	}
-
+	data->previous_freq = data->data->states[state].core_frequency * 1000;
 	dprintk(KERN_INFO "Transition successful after %d microseconds\n", i * 10);
 	return 0;
 }
@@ -162,7 +148,7 @@
 	if (result)
 		return (result);
 
-	return acpi_processor_set_performance (data, next_state);
+	return acpi_processor_set_performance (data, next_state, 1);
 }
 
 static int acpi_cpufreq_verify (struct cpufreq_policy   *policy)
@@ -183,6 +169,7 @@
 	struct acpi_perflib_data *data;
 	struct cpufreq_frequency_table *table;
 	unsigned int i;
+	unsigned long tmp_speed;
 
 	data = acpi_processor_perflib_register (&acpi_cpufreq_perflib_driver,
 						 policy->cpu);
@@ -221,7 +208,29 @@
 	acpi_io_data[policy->cpu].status_register = (u16) data->pct_status.address;
 	acpi_io_data[policy->cpu].control_register = (u16) data->pct_control.address;
 
-	return 0;
+	/* 
+	 * The ACPI specificiation is broken in the regard that
+	 * it is impossible to detect the _current_ P-State.
+	 * The control_register is only valid _after_ a frequency
+	 * transition.
+	 * So, we try to get the current setting from cpu_khz,
+	 * but to make sure, this state we think the CPU is in
+	 * is also set.
+	 */
+	if (cpu_khz) {
+		tmp_speed = cpu_khz / 100;
+		tmp_speed *= 105;
+	} else {
+		tmp_speed = policy->cpuinfo.max_freq;
+	}
+	result = cpufreq_frequency_table_target(policy, data->table,
+						tmp_speed,
+						CPUFREQ_RELATION_L,
+						&i);
+	if (result)
+		return (result);
+
+	return acpi_processor_set_performance (data, i, 0);
 }
