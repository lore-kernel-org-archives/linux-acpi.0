From: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [ACPI][PATCH 3/4] (take 2) Software coordination of freq across CPUs sharing common P-state
Date: Tue, 13 Sep 2005 17:03:07 -0700
Message-ID: <20050913170307.D5968@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: cpufreq <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shah, Rajesh" <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


[PATCH 3/4] Software coordination of freq across CPUs sharing common P-state

Changes to acpi-cpufreq required for supporting cpu groups sharing
common P-state

acpi_processor_preregister_performance is called initially to determine the
CPU group membership.
centrino_target is chaneg to handle acpu group shared_type of SHARED_TYPE_ANY
and SHARED_TYPE_ALL.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Index: linux-2.6.12/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.12.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2005-09-06 09:44:19.924390528 -0700
+++ linux-2.6.12/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2005-09-06 13:39:11.391161960 -0700
@@ -49,12 +49,13 @@
 
 
 struct cpufreq_acpi_io {
-	struct acpi_processor_performance	acpi_data;
+	struct acpi_processor_performance	*acpi_data;
 	struct cpufreq_frequency_table		*freq_table;
 	unsigned int				resume;
 };
 
 static struct cpufreq_acpi_io	*acpi_io_data[NR_CPUS];
+static struct acpi_processor_performance	*acpi_perf_data[NR_CPUS];
 
 static struct cpufreq_driver acpi_cpufreq_driver;
 
@@ -105,64 +106,43 @@
 {
 	u16			port = 0;
 	u8			bit_width = 0;
+	int			i = 0;
 	int			ret = 0;
 	u32			value = 0;
-	int			i = 0;
-	struct cpufreq_freqs    cpufreq_freqs;
-	cpumask_t		saved_mask;
 	int			retval;
+	struct acpi_processor_performance	*perf;
 
 	dprintk("acpi_processor_set_performance\n");
 
-	/*
-	 * TBD: Use something other than set_cpus_allowed.
-	 * As set_cpus_allowed is a bit racy, 
-	 * with any other set_cpus_allowed for this process.
-	 */
-	saved_mask = current->cpus_allowed;
-	set_cpus_allowed(current, cpumask_of_cpu(cpu));
-	if (smp_processor_id() != cpu) {
-		return (-EAGAIN);
-	}
-	
-	if (state == data->acpi_data.state) {
+	retval = 0;
+	perf = data->acpi_data;	
+	if (state == perf->state) {
 		if (unlikely(data->resume)) {
 			dprintk("Called after resume, resetting to P%d\n", state);
 			data->resume = 0;
 		} else {
 			dprintk("Already at target state (P%d)\n", state);
-			retval = 0;
-			goto migrate_end;
+			return (retval);
 		}
 	}
 
-	dprintk("Transitioning from P%d to P%d\n",
-		data->acpi_data.state, state);
-
-	/* cpufreq frequency struct */
-	cpufreq_freqs.cpu = cpu;
-	cpufreq_freqs.old = data->freq_table[data->acpi_data.state].frequency;
-	cpufreq_freqs.new = data->freq_table[state].frequency;
-
-	/* notify cpufreq */
-	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
+	dprintk("Transitioning from P%d to P%d\n", perf->state, state);
 
 	/*
 	 * First we write the target state's 'control' value to the
 	 * control_register.
 	 */
 
-	port = data->acpi_data.control_register.address;
-	bit_width = data->acpi_data.control_register.bit_width;
-	value = (u32) data->acpi_data.states[state].control;
+	port = perf->control_register.address;
+	bit_width = perf->control_register.bit_width;
+	value = (u32) perf->states[state].control;
 
 	dprintk("Writing 0x%08x to port 0x%04x\n", value, port);
 
 	ret = acpi_processor_write_port(port, bit_width, value);
 	if (ret) {
 		dprintk("Invalid port width 0x%04x\n", bit_width);
-		retval = ret;
-		goto migrate_end;
+		return (ret);
 	}
 
 	/*
@@ -178,49 +158,36 @@
 		 * before giving up.
 		 */
 
-		port = data->acpi_data.status_register.address;
-		bit_width = data->acpi_data.status_register.bit_width;
+		port = perf->status_register.address;
+		bit_width = perf->status_register.bit_width;
 
 		dprintk("Looking for 0x%08x from port 0x%04x\n",
-			(u32) data->acpi_data.states[state].status, port);
+			(u32) perf->states[state].status, port);
 
-		for (i=0; i<100; i++) {
+		for (i = 0; i < 100; i++) {
 			ret = acpi_processor_read_port(port, bit_width, &value);
 			if (ret) {	
 				dprintk("Invalid port width 0x%04x\n", bit_width);
-				retval = ret;
-				goto migrate_end;
+				return (ret);
 			}
-			if (value == (u32) data->acpi_data.states[state].status)
+			if (value == (u32) perf->states[state].status)
 				break;
 			udelay(10);
 		}
 	} else {
 		i = 0;
-		value = (u32) data->acpi_data.states[state].status;
+		value = (u32) perf->states[state].status;
 	}
 
-	/* notify cpufreq */
-	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
-
-	if (unlikely(value != (u32) data->acpi_data.states[state].status)) {
-		unsigned int tmp = cpufreq_freqs.new;
-		cpufreq_freqs.new = cpufreq_freqs.old;
-		cpufreq_freqs.old = tmp;
-		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
-		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
+	if (unlikely(value != (u32) perf->states[state].status)) {
 		printk(KERN_WARNING "acpi-cpufreq: Transition failed\n");
 		retval = -ENODEV;
-		goto migrate_end;
+		return (retval);
 	}
 
 	dprintk("Transition successful after %d microseconds\n", i * 10);
 
-	data->acpi_data.state = state;
-
-	retval = 0;
-migrate_end:
-	set_cpus_allowed(current, saved_mask);
+	perf->state = state;
 	return (retval);
 }
 
@@ -232,8 +199,17 @@
 	unsigned int relation)
 {
 	struct cpufreq_acpi_io *data = acpi_io_data[policy->cpu];
+	struct acpi_processor_performance *perf;
+	struct cpufreq_freqs freqs;
+	cpumask_t online_policy_cpus;
+	cpumask_t saved_mask;
+	cpumask_t set_mask;
+	cpumask_t covered_cpus;
+	unsigned int cur_state = 0;
 	unsigned int next_state = 0;
 	unsigned int result = 0;
+	unsigned int j;
+	unsigned int tmp;
 
 	dprintk("acpi_cpufreq_setpolicy\n");
 
@@ -242,11 +218,91 @@
 			target_freq,
 			relation,
 			&next_state);
-	if (result)
+	if (unlikely(result))
 		return (result);
 
-	result = acpi_processor_set_performance (data, policy->cpu, next_state);
+	perf = data->acpi_data;
+	cur_state = perf->state;
+	freqs.old = data->freq_table[cur_state].frequency;
+	freqs.new = data->freq_table[next_state].frequency;
+
+	/* cpufreq holds the hotplug lock, so we are safe from here on */
+	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+
+	for_each_cpu_mask(j, online_policy_cpus) {
+		freqs.cpu = j;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	}
+
+	/*
+	 * We need to call driver->target() on all or any CPU in
+	 * policy->cpus, depending on policy->shared_type.
+	 */
+	saved_mask = current->cpus_allowed;
+	cpus_clear(covered_cpus);
+	for_each_cpu_mask(j, online_policy_cpus) {
+		/*
+		 * Support for SMP systems.
+		 * Make sure we are running on CPU that wants to change freq
+		 */
+		cpus_clear(set_mask);
+		if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
+			cpus_or(set_mask, set_mask, online_policy_cpus);
+		else
+			cpu_set(j, set_mask);
+
+		set_cpus_allowed(current, set_mask);
+		if (unlikely(!cpu_isset(smp_processor_id(), set_mask))) {
+			dprintk("couldn't limit to CPUs in this domain\n");
+			result = -EAGAIN;
+			break;
+		}
+
+		result = acpi_processor_set_performance (data, j, next_state);
+		if (result) {
+			result = -EAGAIN;
+			break;
+		}
+
+		if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
+			break;
+ 
+		cpu_set(j, covered_cpus);
+	}
 
+	for_each_cpu_mask(j, online_policy_cpus) {
+		freqs.cpu = j;
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
+
+	if (unlikely(result)) {
+		/*
+		 * We have failed halfway through the frequency change.
+		 * We have sent callbacks to online_policy_cpus and
+		 * acpi_processor_set_performance() has been called on 
+		 * coverd_cpus. Best effort undo..
+		 */
+
+		if (!cpus_empty(covered_cpus)) {
+			for_each_cpu_mask(j, covered_cpus) {
+				policy->cpu = j;
+				acpi_processor_set_performance (data, 
+						j, 
+						cur_state);
+			}
+		}
+
+		tmp = freqs.new;
+		freqs.new = freqs.old;
+		freqs.old = tmp;
+		for_each_cpu_mask(j, online_policy_cpus) {
+			freqs.cpu = j;
+			cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+		}
+	}
+
+	set_cpus_allowed(current, saved_mask);
 	return (result);
 }
 
@@ -272,27 +328,29 @@
 	struct cpufreq_acpi_io	*data,
 	unsigned int		cpu)
 {
+	struct acpi_processor_performance	*perf = data->acpi_data;
+
 	if (cpu_khz) {
 		/* search the closest match to cpu_khz */
 		unsigned int i;
 		unsigned long freq;
-		unsigned long freqn = data->acpi_data.states[0].core_frequency * 1000;
+		unsigned long freqn = perf->states[0].core_frequency * 1000;
 
-		for (i=0; i < (data->acpi_data.state_count - 1); i++) {
+		for (i = 0; i < (perf->state_count - 1); i++) {
 			freq = freqn;
-			freqn = data->acpi_data.states[i+1].core_frequency * 1000;
+			freqn = perf->states[i+1].core_frequency * 1000;
 			if ((2 * cpu_khz) > (freqn + freq)) {
-				data->acpi_data.state = i;
+				perf->state = i;
 				return (freq);
 			}
 		}
-		data->acpi_data.state = data->acpi_data.state_count - 1;
+		perf->state = perf->state_count - 1;
 		return (freqn);
-	} else
+	} else {
 		/* assume CPU is at P0... */
-		data->acpi_data.state = 0;
-		return data->acpi_data.states[0].core_frequency * 1000;
-	
+		perf->state = 0;
+		return perf->states[0].core_frequency * 1000;
+	}
 }
 
 
@@ -309,7 +367,6 @@
  */
 static void 
 acpi_processor_cpu_init_pdc_est(
-		struct acpi_processor_performance *perf, 
 		unsigned int cpu,
 		struct acpi_object_list *obj_list
 		)
@@ -335,7 +392,6 @@
        		buf[0] = ACPI_PDC_REVISION_ID;
        		buf[1] = 1;
        		buf[2] = ACPI_PDC_EST_CAPABILITY_SMP;
-		perf->pdc = obj_list;
 	}
 	return;
 }
@@ -344,20 +400,60 @@
 /* CPU specific PDC initialization */
 static void 
 acpi_processor_cpu_init_pdc(
-		struct acpi_processor_performance *perf, 
 		unsigned int cpu,
 		struct acpi_object_list *obj_list
 		)
 {
 	struct cpuinfo_x86 *c = cpu_data + cpu;
 	dprintk("acpi_processor_cpu_init_pdc\n");
-	perf->pdc = NULL;
 	if (cpu_has(c, X86_FEATURE_EST))
-		acpi_processor_cpu_init_pdc_est(perf, cpu, obj_list);
+		acpi_processor_cpu_init_pdc_est(cpu, obj_list);
 	return;
 }
 
 
+/*
+ * acpi_cpufreq_early_init - initialize ACPI P-States library
+ *
+ * Initialize the ACPI P-States library (drivers/acpi/processor_perflib.c)
+ * in order to determine correct frequency and voltage pairings. We can
+ * do _PDC and _PSD and find out the processor dependency for the
+ * actual init that will happen later...
+ */
+static int acpi_cpufreq_early_init_acpi(void)
+{
+	union acpi_object		arg0 = {ACPI_TYPE_BUFFER};
+	u32				arg0_buf[3];
+	struct acpi_object_list 	arg_list = {1, &arg0};
+	struct acpi_processor_performance		*data;
+	unsigned int			i, j;
+
+	dprintk("acpi_cpufreq_early_init\n");
+
+	for_each_cpu(i) {
+		data = kmalloc(sizeof(struct acpi_processor_performance), 
+			GFP_KERNEL);
+		if (!data) {
+			for_each_cpu(j)
+				kfree(acpi_perf_data[j]);
+			return (-ENOMEM);
+		}
+		memset(data, 0, sizeof(struct acpi_processor_performance));
+
+		acpi_perf_data[i] = data;
+	}
+
+	/* setup arg_list for _PDC settings */
+        arg0.buffer.length = 12;
+        arg0.buffer.pointer = (u8 *) arg0_buf;
+	acpi_processor_cpu_init_pdc(0, &arg_list);
+
+	/* Do initialization in ACPI core */
+	acpi_processor_preregister_performance(&arg_list, acpi_perf_data);
+	return 0;
+}
+
+
 static int
 acpi_cpufreq_cpu_init (
 	struct cpufreq_policy   *policy)
@@ -367,50 +463,51 @@
 	struct cpufreq_acpi_io	*data;
 	unsigned int		result = 0;
 
-	union acpi_object		arg0 = {ACPI_TYPE_BUFFER};
-	u32				arg0_buf[3];
-	struct acpi_object_list 	arg_list = {1, &arg0};
+	struct acpi_processor_performance	*perf;
 
 	dprintk("acpi_cpufreq_cpu_init\n");
-	/* setup arg_list for _PDC settings */
-        arg0.buffer.length = 12;
-        arg0.buffer.pointer = (u8 *) arg0_buf;
+
+	if (!acpi_perf_data[cpu])
+		return (-ENODEV);
 
 	data = kmalloc(sizeof(struct cpufreq_acpi_io), GFP_KERNEL);
 	if (!data)
 		return (-ENOMEM);
 	memset(data, 0, sizeof(struct cpufreq_acpi_io));
+	data->acpi_data = acpi_perf_data[cpu];
 
 	acpi_io_data[cpu] = data;
 
-	acpi_processor_cpu_init_pdc(&data->acpi_data, cpu, &arg_list);
-	result = acpi_processor_register_performance(&data->acpi_data, cpu);
-	data->acpi_data.pdc = NULL;
+	result = acpi_processor_register_performance(data->acpi_data, cpu);
 
 	if (result)
 		goto err_free;
 
+	perf = data->acpi_data;
+	policy->cpus = perf->shared_cpu_map;
+	policy->shared_type = perf->shared_type;
+
 	if (is_const_loops_cpu(cpu)) {
 		acpi_cpufreq_driver.flags |= CPUFREQ_CONST_LOOPS;
 	}
 
 	/* capability check */
-	if (data->acpi_data.state_count <= 1) {
+	if (perf->state_count <= 1) {
 		dprintk("No P-States\n");
 		result = -ENODEV;
 		goto err_unreg;
 	}
-	if ((data->acpi_data.control_register.space_id != ACPI_ADR_SPACE_SYSTEM_IO) ||
-	    (data->acpi_data.status_register.space_id != ACPI_ADR_SPACE_SYSTEM_IO)) {
+	if ((perf->control_register.space_id != ACPI_ADR_SPACE_SYSTEM_IO) ||
+	    (perf->status_register.space_id != ACPI_ADR_SPACE_SYSTEM_IO)) {
 		dprintk("Unsupported address space [%d, %d]\n",
-			(u32) (data->acpi_data.control_register.space_id),
-			(u32) (data->acpi_data.status_register.space_id));
+			(u32) (perf->control_register.space_id),
+			(u32) (perf->status_register.space_id));
 		result = -ENODEV;
 		goto err_unreg;
 	}
 
 	/* alloc freq_table */
-	data->freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) * (data->acpi_data.state_count + 1), GFP_KERNEL);
+	data->freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) * (perf->state_count + 1), GFP_KERNEL);
 	if (!data->freq_table) {
 		result = -ENOMEM;
 		goto err_unreg;
@@ -418,9 +515,9 @@
 
 	/* detect transition latency */
 	policy->cpuinfo.transition_latency = 0;
-	for (i=0; i<data->acpi_data.state_count; i++) {
-		if ((data->acpi_data.states[i].transition_latency * 1000) > policy->cpuinfo.transition_latency)
-			policy->cpuinfo.transition_latency = data->acpi_data.states[i].transition_latency * 1000;
+	for (i = 0; i < perf->state_count; i++) {
+		if ((perf->states[i].transition_latency * 1000) > policy->cpuinfo.transition_latency)
+			policy->cpuinfo.transition_latency = perf->states[i].transition_latency * 1000;
 	}
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
 
@@ -428,11 +525,11 @@
 	policy->cur = acpi_cpufreq_guess_freq(data, policy->cpu);
 
 	/* table init */
-	for (i=0; i<=data->acpi_data.state_count; i++)
+	for (i = 0; i <= perf->state_count; i++)
 	{
 		data->freq_table[i].index = i;
-		if (i<data->acpi_data.state_count)
-			data->freq_table[i].frequency = data->acpi_data.states[i].core_frequency * 1000;
+		if (i < perf->state_count)
+			data->freq_table[i].frequency = perf->states[i].core_frequency * 1000;
 		else
 			data->freq_table[i].frequency = CPUFREQ_TABLE_END;
 	}
@@ -447,12 +544,12 @@
 
 	printk(KERN_INFO "acpi-cpufreq: CPU%u - ACPI performance management activated.\n",
 	       cpu);
-	for (i = 0; i < data->acpi_data.state_count; i++)
+	for (i = 0; i < perf->state_count; i++)
 		dprintk("     %cP%d: %d MHz, %d mW, %d uS\n",
-			(i == data->acpi_data.state?'*':' '), i,
-			(u32) data->acpi_data.states[i].core_frequency,
-			(u32) data->acpi_data.states[i].power,
-			(u32) data->acpi_data.states[i].transition_latency);
+			(i == perf->state?'*':' '), i,
+			(u32) perf->states[i].core_frequency,
+			(u32) perf->states[i].power,
+			(u32) perf->states[i].transition_latency);
 
 	cpufreq_frequency_table_get_attr(data->freq_table, policy->cpu);
 	
@@ -467,7 +564,7 @@
  err_freqfree:
 	kfree(data->freq_table);
  err_unreg:
-	acpi_processor_unregister_performance(&data->acpi_data, cpu);
+	acpi_processor_unregister_performance(perf, cpu);
  err_free:
 	kfree(data);
 	acpi_io_data[cpu] = NULL;
@@ -488,7 +585,7 @@
 	if (data) {
 		cpufreq_frequency_table_put_attr(policy->cpu);
 		acpi_io_data[policy->cpu] = NULL;
-		acpi_processor_unregister_performance(&data->acpi_data, policy->cpu);
+		acpi_processor_unregister_performance(data->acpi_data, policy->cpu);
 		kfree(data);
 	}
 
@@ -534,7 +631,10 @@
 
 	dprintk("acpi_cpufreq_init\n");
 
- 	result = cpufreq_register_driver(&acpi_cpufreq_driver);
+	result = acpi_cpufreq_early_init_acpi();
+
+	if (!result)
+ 		result = cpufreq_register_driver(&acpi_cpufreq_driver);
 	
 	return (result);
 }
@@ -543,10 +643,15 @@
 static void __exit
 acpi_cpufreq_exit (void)
 {
+	unsigned int		i;
 	dprintk("acpi_cpufreq_exit\n");
 
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
 
+	for_each_cpu(i) {
+		kfree(acpi_perf_data[i]);
+		acpi_perf_data[i] = NULL;
+	}
 	return;
 }
 


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
