From: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC][PATCH 2/4] Software coordination of frequency across CPUs sharing common P-state
Date: Wed, 31 Aug 2005 14:13:18 -0700
Message-ID: <20050831141318.C12497@unix-os.sc.intel.com>
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
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


[RFC][PATCH 2/4] Software coordination of frequency across CPUs sharing common P-state

Changes to speedstep-centrino required for supporting cpu groups sharing
common P-state.

acpi_processor_preregister_performance is called initially to determine the
CPU group membership.
centrino_target is chaneg to handle acpu group shared_type of SHARED_TYPE_ANY
and SHARED_TYPE_ALL.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Index: linux-2.6.12/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
===================================================================
--- linux-2.6.12.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-08-17 10:51:18.748366200 -0700
+++ linux-2.6.12/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-08-18 14:08:04.499822688 -0700
@@ -351,23 +351,35 @@
 
 #ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
 
-static struct acpi_processor_performance p;
+static struct acpi_processor_performance *acpi_perf_data[NR_CPUS];
 
 /*
- * centrino_cpu_init_acpi - register with ACPI P-States library
+ * centrino_cpu_early_init_acpi - Do the preregistering with ACPI P-States 
+ * library
  *
- * Register with the ACPI P-States library (part of drivers/acpi/processor.c)
- * in order to determine correct frequency and voltage pairings by reading
- * the _PSS of the ACPI DSDT or SSDT tables.
+ * Before doing the actual init, we need to make _PDC and _PSD calls whenever
+ * supported by the BIOS. These are handled by this early_init routine.
  */
-static int centrino_cpu_init_acpi(struct cpufreq_policy *policy)
+static int centrino_cpu_early_init_acpi(void)
 {
 	union acpi_object		arg0 = {ACPI_TYPE_BUFFER};
 	u32				arg0_buf[3];
 	struct acpi_object_list		arg_list = {1, &arg0};
-	unsigned long			cur_freq;
-	int				result = 0, i;
-	unsigned int			cpu = policy->cpu;
+	unsigned int			i, j;
+	struct acpi_processor_performance	*data;
+
+	for_each_online_cpu(i) {
+		data = kmalloc(sizeof(struct acpi_processor_performance), GFP_KERNEL);
+		if (!data) {
+			for_each_online_cpu(j) {
+				kfree(acpi_perf_data[j]);
+				acpi_perf_data[j] = NULL;
+			}
+			return (-ENOMEM);
+		}
+		memset(data, 0, sizeof(struct acpi_processor_performance));
+		acpi_perf_data[i] = data;
+	}
 
 	/* _PDC settings */
 	arg0.buffer.length = 12;
@@ -376,47 +388,75 @@
 	arg0_buf[1] = 1;
 	arg0_buf[2] = ACPI_PDC_EST_CAPABILITY_SMP_MSR;
 
-	p.pdc = &arg_list;
+	/* preregister with ACPI core */
+	if (acpi_processor_preregister_performance(&arg_list, acpi_perf_data)) {
+		dprintk(KERN_INFO PFX "preregister of ACPI P-states failed\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+
+/*
+ * centrino_cpu_init_acpi - register with ACPI P-States library
+ *
+ * Register with the ACPI P-States library (part of drivers/acpi/processor.c)
+ * in order to determine correct frequency and voltage pairings by reading
+ * the _PSS of the ACPI DSDT or SSDT tables.
+ */
+static int centrino_cpu_init_acpi(struct cpufreq_policy *policy)
+{
+	unsigned long			cur_freq;
+	int				result = 0, i;
+	unsigned int			cpu = policy->cpu;
+	static struct acpi_processor_performance *p;
+
+	if (!acpi_perf_data[cpu])
+		return (-ENODEV);
+
+	p = acpi_perf_data[cpu];
 
 	/* register with ACPI core */
-	if (acpi_processor_register_performance(&p, cpu)) {
+	if (acpi_processor_register_performance(p, cpu)) {
 		dprintk(KERN_INFO PFX "obtaining ACPI data failed\n");
 		return -EIO;
 	}
+	policy->cpus = p->shared_cpu_map;
+	policy->shared_type = p->shared_type;
 
 	/* verify the acpi_data */
-	if (p.state_count <= 1) {
+	if (p->state_count <= 1) {
 		dprintk("No P-States\n");
 		result = -ENODEV;
 		goto err_unreg;
 	}
 
-	if ((p.control_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) ||
-	    (p.status_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE)) {
+	if ((p->control_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) ||
+	    (p->status_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE)) {
 		dprintk("Invalid control/status registers (%x - %x)\n",
-			p.control_register.space_id, p.status_register.space_id);
+			p->control_register.space_id, p->status_register.space_id);
 		result = -EIO;
 		goto err_unreg;
 	}
 
-	for (i=0; i<p.state_count; i++) {
-		if (p.states[i].control != p.states[i].status) {
+	for (i=0; i<p->state_count; i++) {
+		if (p->states[i].control != p->states[i].status) {
 			dprintk("Different control (%x) and status values (%x)\n",
-				p.states[i].control, p.states[i].status);
+				p->states[i].control, p->states[i].status);
 			result = -EINVAL;
 			goto err_unreg;
 		}
 
-		if (!p.states[i].core_frequency) {
+		if (!p->states[i].core_frequency) {
 			dprintk("Zero core frequency for state %u\n", i);
 			result = -EINVAL;
 			goto err_unreg;
 		}
 
-		if (p.states[i].core_frequency > p.states[0].core_frequency) {
+		if (p->states[i].core_frequency > p->states[0].core_frequency) {
 			dprintk("P%u has larger frequency (%u) than P0 (%u), skipping\n", i,
-				p.states[i].core_frequency, p.states[0].core_frequency);
-			p.states[i].core_frequency = 0;
+				p->states[i].core_frequency, p->states[0].core_frequency);
+			p->states[i].core_frequency = 0;
 			continue;
 		}
 	}
@@ -429,26 +469,26 @@
 	memset(centrino_model[cpu], 0, sizeof(struct cpu_model));
 
 	centrino_model[cpu]->model_name=NULL;
-	centrino_model[cpu]->max_freq = p.states[0].core_frequency * 1000;
+	centrino_model[cpu]->max_freq = p->states[0].core_frequency * 1000;
 	centrino_model[cpu]->op_points =  kmalloc(sizeof(struct cpufreq_frequency_table) *
-					     (p.state_count + 1), GFP_KERNEL);
+					     (p->state_count + 1), GFP_KERNEL);
         if (!centrino_model[cpu]->op_points) {
                 result = -ENOMEM;
                 goto err_kfree;
         }
 
-        for (i=0; i<p.state_count; i++) {
-		centrino_model[cpu]->op_points[i].index = p.states[i].control;
-		centrino_model[cpu]->op_points[i].frequency = p.states[i].core_frequency * 1000;
+        for (i=0; i<p->state_count; i++) {
+		centrino_model[cpu]->op_points[i].index = p->states[i].control;
+		centrino_model[cpu]->op_points[i].frequency = p->states[i].core_frequency * 1000;
 		dprintk("adding state %i with frequency %u and control value %04x\n", 
 			i, centrino_model[cpu]->op_points[i].frequency, centrino_model[cpu]->op_points[i].index);
 	}
-	centrino_model[cpu]->op_points[p.state_count].frequency = CPUFREQ_TABLE_END;
+	centrino_model[cpu]->op_points[p->state_count].frequency = CPUFREQ_TABLE_END;
 
 	cur_freq = get_cur_freq(cpu);
 
-	for (i=0; i<p.state_count; i++) {
-		if (!p.states[i].core_frequency) {
+	for (i=0; i<p->state_count; i++) {
+		if (!p->states[i].core_frequency) {
 			dprintk("skipping state %u\n", i);
 			centrino_model[cpu]->op_points[i].frequency = CPUFREQ_ENTRY_INVALID;
 			continue;
@@ -464,7 +504,7 @@
 		}
 
 		if (cur_freq == centrino_model[cpu]->op_points[i].frequency)
-			p.state = i;
+			p->state = i;
 	}
 
 	/* notify BIOS that we exist */
@@ -477,12 +517,13 @@
  err_kfree:
 	kfree(centrino_model[cpu]);
  err_unreg:
-	acpi_processor_unregister_performance(&p, cpu);
+	acpi_processor_unregister_performance(p, cpu);
 	dprintk(KERN_INFO PFX "invalid ACPI data\n");
 	return (result);
 }
 #else
 static inline int centrino_cpu_init_acpi(struct cpufreq_policy *policy) { return -ENODEV; }
+static inline int centrino_cpu_early_init_acpi(void) {return 0};
 #endif
 
 static int centrino_cpu_init(struct cpufreq_policy *policy)
@@ -569,10 +610,15 @@
 
 #ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
 	if (!centrino_model[cpu]->model_name) {
-		dprintk("unregistering and freeing ACPI data\n");
-		acpi_processor_unregister_performance(&p, cpu);
-		kfree(centrino_model[cpu]->op_points);
-		kfree(centrino_model[cpu]);
+		static struct acpi_processor_performance *p;
+
+		if (acpi_perf_data[cpu]) {
+			p = acpi_perf_data[cpu];
+			dprintk("unregistering and freeing ACPI data\n");
+			acpi_processor_unregister_performance(p, cpu);
+			kfree(centrino_model[cpu]->op_points);
+			kfree(centrino_model[cpu]);
+		}
 	}
 #endif
 
@@ -606,61 +652,121 @@
 			    unsigned int relation)
 {
 	unsigned int    newstate = 0;
-	unsigned int	msr, oldmsr, h, cpu = policy->cpu;
+	unsigned int	msr, oldmsr = 0, h = 0, cpu = policy->cpu;
 	struct cpufreq_freqs	freqs;
 	cpumask_t		saved_mask;
+	cpumask_t		set_mask;
+	cpumask_t		covered_cpus;
 	int			retval;
+	unsigned int		j, k, first_cpu, tmp;
 
-	if (centrino_model[cpu] == NULL)
+	if (unlikely(centrino_model[cpu] == NULL))
 		return -ENODEV;
 
-	/*
-	 * Support for SMP systems.
-	 * Make sure we are running on the CPU that wants to change frequency
-	 */
-	saved_mask = current->cpus_allowed;
-	set_cpus_allowed(current, policy->cpus);
-	if (!cpu_isset(smp_processor_id(), policy->cpus)) {
-		dprintk("couldn't limit to CPUs in this domain\n");
-		return(-EAGAIN);
+	if (unlikely(cpufreq_frequency_table_target(policy,
+			centrino_model[cpu]->op_points,
+			target_freq,
+			relation,
+			&newstate))) {
+		return -EINVAL;
 	}
 
-	if (cpufreq_frequency_table_target(policy, centrino_model[cpu]->op_points, target_freq,
-					   relation, &newstate)) {
-		retval = -EINVAL;
-		goto migrate_end;
-	}
+	saved_mask = current->cpus_allowed;
+	first_cpu = 1;
+	cpus_clear(covered_cpus);
+	for_each_cpu_mask(j, policy->cpus) {
+		/*
+		 * Support for SMP systems.
+		 * Make sure we are running on CPU that wants to change freq
+		 */
+		cpus_clear(set_mask);
+		if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
+			cpus_or(set_mask, set_mask, policy->cpus);
+		else
+			cpu_set(j, set_mask);
+
+		set_cpus_allowed(current, set_mask);
+		if (unlikely(!cpu_isset(smp_processor_id(), set_mask))) {
+			dprintk("couldn't limit to CPUs in this domain\n");
+			retval = -EAGAIN;
+			goto error_end;
+		}
+
+		msr = centrino_model[cpu]->op_points[newstate].index;
 
-	msr = centrino_model[cpu]->op_points[newstate].index;
-	rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+		if (first_cpu) {
+			rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+			if (msr == (oldmsr & 0xffff)) {
+				dprintk("no change needed - msr was and needs "
+					"to be %x\n", oldmsr);
+				retval = 0;
+				goto migrate_end;
+			}
+
+			freqs.old = extract_clock(oldmsr, cpu, 0);
+			freqs.new = extract_clock(msr, cpu, 0);
+
+			dprintk("target=%dkHz old=%d new=%d msr=%04x\n",
+				target_freq, freqs.old, freqs.new, msr);
+
+			for_each_cpu_mask(k, policy->cpus) {
+				freqs.cpu = k;
+				cpufreq_notify_transition(&freqs,
+					CPUFREQ_PRECHANGE);
+			}
+
+			first_cpu = 0;
+			/* all but 16 LSB are reserved, treat them with care */
+			oldmsr &= ~0xffff;
+			msr &= 0xffff;
+			oldmsr |= msr;
+		}
 
-	if (msr == (oldmsr & 0xffff)) {
-		retval = 0;
-		dprintk("no change needed - msr was and needs to be %x\n", oldmsr);
-		goto migrate_end;
+		wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+		if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
+			break;
+
+		cpu_set(j, covered_cpus);
 	}
 
-	freqs.cpu = cpu;
-	freqs.old = extract_clock(oldmsr, cpu, 0);
-	freqs.new = extract_clock(msr, cpu, 0);
+	for_each_cpu_mask(k, policy->cpus) {
+		freqs.cpu = k;
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
 
-	dprintk("target=%dkHz old=%d new=%d msr=%04x\n",
-		target_freq, freqs.old, freqs.new, msr);
+migrate_end:
+	set_cpus_allowed(current, saved_mask);
+	return 0;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+error_end:
+	/*
+	 * We have failed halfway through the frequency change.
+	 * We have sent callbacks to policy->cpus and
+	 * MSRs have already been written on coverd_cpus.
+	 * Best effort undo..
+	 */
 
-	/* all but 16 LSB are "reserved", so treat them with
-	   care */
-	oldmsr &= ~0xffff;
-	msr &= 0xffff;
-	oldmsr |= msr;
+	for_each_cpu_mask(k, policy->cpus) {
+		freqs.cpu = k;
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
 
-	wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+	if (!cpus_empty(covered_cpus)) {
+		for_each_cpu_mask(j, covered_cpus) {
+			set_cpus_allowed(current, cpumask_of_cpu(j));
+			wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+		}
+	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	tmp = freqs.new;
+	freqs.new = freqs.old;
+	freqs.old = tmp;
+	for_each_cpu_mask(j, policy->cpus) {
+		freqs.cpu = j;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
 
-	retval = 0;
-migrate_end:
 	set_cpus_allowed(current, saved_mask);
 	return (retval);
 }
@@ -704,6 +810,8 @@
 	if (!cpu_has(cpu, X86_FEATURE_EST))
 		return -ENODEV;
 
+	centrino_cpu_early_init_acpi();
+
 	return cpufreq_register_driver(&centrino_driver);
 }
 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
