From: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: [PATCH 2.6] (3/5) abstract the acpi-"perflib" registration method
Date: Thu, 29 Jan 2004 11:58:56 +0100
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <20040129105856.GC5372@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: len.brown@intel.com, acpi-devel@lists.sourceforge.net
Cc: cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Abstract the registration method between low-level drivers and the
ACPI Processor P-States driver.

 arch/i386/kernel/cpu/cpufreq/acpi.c |  131 ++++++++++++++++++------------------
 drivers/acpi/processor.c            |   31 --------
 include/acpi/processor.h            |   13 +--
 3 files changed, 73 insertions(+), 102 deletions(-)


diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-18 13:53:33.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-18 18:45:28.323885104 +0100
@@ -51,7 +51,12 @@
 MODULE_LICENSE("GPL");
 
 
-static struct acpi_processor_performance	*performance[NR_CPUS];
+struct cpufreq_acpi_io {
+	struct acpi_processor_performance	acpi_data;
+	struct cpufreq_frequency_table		freq_table[ACPI_PROCESSOR_MAX_PERFORMANCE];
+};
+
+static struct cpufreq_acpi_io	*acpi_io_data[NR_CPUS];
 
 
 static int
@@ -93,7 +98,7 @@
 
 static int
 acpi_processor_set_performance (
-	struct acpi_processor_performance	*perf,
+	struct cpufreq_acpi_io	*data,
 	unsigned int		cpu,
 	int			state)
 {
@@ -106,28 +111,19 @@
 
 	ACPI_FUNCTION_TRACE("acpi_processor_set_performance");
 
-	if (!perf)
-		return_VALUE(-EINVAL);
-
-	if (state >= perf->state_count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, 
-			"Invalid target state (P%d)\n", state));
-		return_VALUE(-ENODEV);
-	}
-
-	if (state == perf->state) {
+	if (state == data->acpi_data.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 			"Already at target state (P%d)\n", state));
 		return_VALUE(0);
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Transitioning from P%d to P%d\n",
-		perf->state, state));
+		data->acpi_data.state, state));
 
 	/* cpufreq frequency struct */
 	cpufreq_freqs.cpu = cpu;
-	cpufreq_freqs.old = perf->states[perf->state].core_frequency * 1000;
-	cpufreq_freqs.new = perf->states[state].core_frequency * 1000;
+	cpufreq_freqs.old = data->freq_table[data->acpi_data.state].frequency;
+	cpufreq_freqs.new = data->freq_table[state].frequency;
 
 	/* notify cpufreq */
 	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
@@ -137,9 +133,9 @@
 	 * control_register.
 	 */
 
-	port = perf->control_register;
-	bit_width = perf->control_register_bit_width;
-	value = (u32) perf->states[state].control;
+	port = data->acpi_data.control_register.address;
+	bit_width = data->acpi_data.control_register.bit_width;
+	value = (u32) data->acpi_data.states[state].control;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 		"Writing 0x%08x to port 0x%04x\n", value, port));
@@ -158,12 +154,12 @@
 	 * giving up.
 	 */
 
-	port = perf->status_register;
-	bit_width = perf->status_register_bit_width;
+	port = data->acpi_data.status_register.address;
+	bit_width = data->acpi_data.status_register.bit_width;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 		"Looking for 0x%08x from port 0x%04x\n",
-		(u32) perf->states[state].status, port));
+		(u32) data->acpi_data.states[state].status, port));
 
 	for (i=0; i<100; i++) {
 		ret = acpi_processor_read_port(port, bit_width, &value);
@@ -172,7 +168,7 @@
 				"Invalid port width 0x%04x\n", bit_width));
 			return_VALUE(ret);
 		}
-		if (value == (u32) perf->states[state].status)
+		if (value == (u32) data->acpi_data.states[state].status)
 			break;
 		udelay(10);
 	}
@@ -180,7 +176,7 @@
 	/* notify cpufreq */
 	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
 
-	if (value != (u32) perf->states[state].status) {
+	if (value != (u32) data->acpi_data.states[state].status) {
 		unsigned int tmp = cpufreq_freqs.new;
 		cpufreq_freqs.new = cpufreq_freqs.old;
 		cpufreq_freqs.old = tmp;
@@ -194,7 +190,7 @@
 		"Transition successful after %d microseconds\n",
 		i * 10));
 
-	perf->state = state;
+	data->acpi_data.state = state;
 
 	return_VALUE(0);
 }
@@ -206,21 +202,21 @@
 	unsigned int target_freq,
 	unsigned int relation)
 {
-	struct acpi_processor_performance *perf = performance[policy->cpu];
+	struct cpufreq_acpi_io *data = acpi_io_data[policy->cpu];
 	unsigned int next_state = 0;
 	unsigned int result = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_setpolicy");
 
-	result = cpufreq_frequency_table_target(policy, 
-			perf->freq_table,
+	result = cpufreq_frequency_table_target(policy,
+			data->freq_table,
 			target_freq,
 			relation,
 			&next_state);
 	if (result)
 		return_VALUE(result);
 
-	result = acpi_processor_set_performance (perf, policy->cpu, next_state);
+	result = acpi_processor_set_performance (data, policy->cpu, next_state);
 
 	return_VALUE(result);
 }
@@ -231,17 +227,12 @@
 	struct cpufreq_policy   *policy)
 {
 	unsigned int result = 0;
-	struct acpi_processor_performance *perf = performance[policy->cpu];
+	struct cpufreq_acpi_io *data = acpi_io_data[policy->cpu];
 
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_verify");
 
 	result = cpufreq_frequency_table_verify(policy, 
-			perf->freq_table);
-
-	cpufreq_verify_within_limits(
-		policy, 
-		perf->states[perf->state_count - 1].core_frequency * 1000,
-		perf->states[0].core_frequency * 1000);
+			data->freq_table);
 
 	return_VALUE(result);
 }
@@ -253,31 +244,40 @@
 {
 	unsigned int		i;
 	unsigned int		cpu = policy->cpu;
-	struct acpi_processor_performance *perf;
+	struct cpufreq_acpi_io	*data;
 	unsigned int		result = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_cpu_init");
 
-	perf = kmalloc(sizeof(struct acpi_processor_performance), GFP_KERNEL);
-	if (!perf)
+	data = kmalloc(sizeof(struct cpufreq_acpi_io), GFP_KERNEL);
+	if (!data)
 		return_VALUE(-ENOMEM);
-	memset(perf, 0, sizeof(struct acpi_processor_performance));
+	memset(data, 0, sizeof(struct cpufreq_acpi_io));
 
-	performance[cpu] = perf;
+	acpi_io_data[cpu] = data;
 
-	result = acpi_processor_register_performance(perf, cpu);
+	result = acpi_processor_register_performance(&data->acpi_data, cpu);
 	if (result)
 		goto err_free;
 
 	/* capability check */
-	if (perf->state_count <= 1)
+	if (data->acpi_data.state_count <= 1) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No P-States\n"));
+		goto err_unreg;
+	}
+	if ((data->acpi_data.control_register.space_id != ACPI_ADR_SPACE_SYSTEM_IO) ||
+	    (data->acpi_data.status_register.space_id != ACPI_ADR_SPACE_SYSTEM_IO)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unsupported address space [%d, %d]\n",
+				  (u32) (data->acpi_data.control_register.space_id),
+				  (u32) (data->acpi_data.status_register.space_id)));
 		goto err_unreg;
+	}
 
 	/* detect transition latency */
 	policy->cpuinfo.transition_latency = 0;
-	for (i=0; i<perf->state_count; i++) {
-		if ((perf->states[i].transition_latency * 1000) > policy->cpuinfo.transition_latency)
-			policy->cpuinfo.transition_latency = perf->states[i].transition_latency * 1000;
+	for (i=0; i<data->acpi_data.state_count; i++) {
+		if ((data->acpi_data.states[i].transition_latency * 1000) > policy->cpuinfo.transition_latency)
+			policy->cpuinfo.transition_latency = data->acpi_data.states[i].transition_latency * 1000;
 	}
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
 
@@ -285,36 +285,36 @@
 	 * The current speed is unknown and not detectable by ACPI... argh! Assume 
 	 * it's P0, it will be set to this value later during initialization.
 	 */
-	policy->cur = perf->states[0].core_frequency * 1000;
+	policy->cur = data->acpi_data.states[0].core_frequency * 1000;
 
 	/* table init */
-	for (i=0; i<=perf->state_count; i++)
+	for (i=0; i<=data->acpi_data.state_count; i++)
 	{
-		perf->freq_table[i].index = i;
-		if (i<perf->state_count)
-			perf->freq_table[i].frequency = perf->states[i].core_frequency * 1000;
+		data->freq_table[i].index = i;
+		if (i<data->acpi_data.state_count)
+			data->freq_table[i].frequency = data->acpi_data.states[i].core_frequency * 1000;
 		else
-			perf->freq_table[i].frequency = CPUFREQ_TABLE_END;
+			data->freq_table[i].frequency = CPUFREQ_TABLE_END;
 	}
 
-	result = cpufreq_frequency_table_cpuinfo(policy, &perf->freq_table[0]);
+	result = cpufreq_frequency_table_cpuinfo(policy, &data->freq_table[0]);
 
 	printk(KERN_INFO "cpufreq: CPU%u - ACPI performance management activated.\n",
 	       cpu);
-	for (i = 0; i < perf->state_count; i++)
+	for (i = 0; i < data->acpi_data.state_count; i++)
 		printk(KERN_INFO "cpufreq: %cP%d: %d MHz, %d mW, %d uS\n",
-			(i == perf->state?'*':' '), i,
-			(u32) perf->states[i].core_frequency,
-			(u32) perf->states[i].power,
-			(u32) perf->states[i].transition_latency);
+			(i == data->acpi_data.state?'*':' '), i,
+			(u32) data->acpi_data.states[i].core_frequency,
+			(u32) data->acpi_data.states[i].power,
+			(u32) data->acpi_data.states[i].transition_latency);
 
 	return_VALUE(result);
 
  err_unreg:
-	acpi_processor_unregister_performance(perf, cpu);
+	acpi_processor_unregister_performance(&data->acpi_data, cpu);
  err_free:
-	kfree(perf);
-	performance[cpu] = NULL;
+	kfree(data);
+	acpi_io_data[cpu] = NULL;
 
 	return_VALUE(result);
 }
@@ -324,14 +324,15 @@
 acpi_cpufreq_cpu_exit (
 	struct cpufreq_policy   *policy)
 {
-	struct acpi_processor_performance  *perf = performance[policy->cpu];
+	struct cpufreq_acpi_io *data = acpi_io_data[policy->cpu];
+
 
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_cpu_exit");
 
-	if (perf) {
-		performance[policy->cpu] = NULL;
-		acpi_processor_unregister_performance(perf, policy->cpu);
-		kfree(perf);
+	if (data) {
+		acpi_io_data[policy->cpu] = NULL;
+		acpi_processor_unregister_performance(&data->acpi_data, policy->cpu);
+		kfree(data);
 	}
 
 	return_VALUE(0);
diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2004-01-18 13:53:33.000000000 +0100
+++ linux/drivers/acpi/processor.c	2004-01-18 18:45:59.091207760 +0100
@@ -871,7 +871,6 @@
 	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object	*pct = NULL;
 	union acpi_object	obj = {0};
-	struct acpi_pct_register *reg = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_control");
 
@@ -903,19 +902,9 @@
 		result = -EFAULT;
 		goto end;
 	}
+	memcpy(&pr->performance->control_register, obj.buffer.pointer, sizeof(struct acpi_pct_register));
 
-	reg = (struct acpi_pct_register *) (obj.buffer.pointer);
 
-	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-			"Unsupported address space [%d] (control_register)\n",
-			(u32) reg->space_id));
-		result = -EFAULT;
-		goto end;
-	}
-
-	pr->performance->control_register = (u16) reg->address;
-	pr->performance->control_register_bit_width = reg->bit_width;
 	/*
 	 * status_register
 	 */
@@ -931,23 +920,7 @@
 		goto end;
 	}
 
-	reg = (struct acpi_pct_register *) (obj.buffer.pointer);
-
-	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-			"Unsupported address space [%d] (status_register)\n",
-			(u32) reg->space_id));
-		result = -EFAULT;
-		goto end;
-	}
-
-	pr->performance->status_register = (u16) reg->address;
-	pr->performance->status_register_bit_width = reg->bit_width;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
-		"control_register[0x%04x] status_register[0x%04x]\n",
-		pr->performance->control_register,
-		pr->performance->status_register));
+	memcpy(&pr->performance->status_register, obj.buffer.pointer, sizeof(struct acpi_pct_register));
 
 end:
 	acpi_os_free(buffer.pointer);
diff -ruN linux-original/include/acpi/processor.h linux/include/acpi/processor.h
--- linux-original/include/acpi/processor.h	2004-01-18 13:53:33.000000000 +0100
+++ linux/include/acpi/processor.h	2004-01-18 18:44:20.178244816 +0100
@@ -68,15 +68,12 @@
 };
 
 struct acpi_processor_performance {
-	int			state;
-	int			platform_limit;
-	u16			control_register;
-	u16			status_register;
-	u8			control_register_bit_width;
-	u8			status_register_bit_width;
-	int			state_count;
+	unsigned int		 state;
+	unsigned int		 platform_limit;
+	struct acpi_pct_register control_register;
+	struct acpi_pct_register status_register;
+	unsigned int		 state_count;
 	struct acpi_processor_px states[ACPI_PROCESSOR_MAX_PERFORMANCE];
-	struct cpufreq_frequency_table freq_table[ACPI_PROCESSOR_MAX_PERFORMANCE];
 };
