From: Al Cutter <alien-acpirep-xE0Zs7GtCLTd8Zgiw/MPxQ@public.gmane.org>
Subject: Quick, Quick, Slooow
Date: Tue, 5 Nov 2002 00:13:59 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021105001358.A54213@azure.melloworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

	I've just started playing around with this acpi business, but the
	processor performance (echo 1 > /proc/acpi/.../performance) didn't seem
	to work on my Sony SRX41P, it'd timeout in 
	acpi_processor_set_performance() ("Transition failed"). 

	The cpufreq interface seems to work fine however, so I made a little 
	patch against acpi-20021101 on 2.5.45 which makes :
		* acpi_processor_set_performance() call cpufreq to change the 
			clock speed, and
		* acpi_processor_write_performance() call ..._set_performance()

	Don't know if this makes sense, or it's just a kludge that gets around
	my particular problem, but it seems to work quite well with 
	autospeedstep (http://gpsdrive.kraftvoll.at/speedstep.shtml).

	Another thing I noticed is that osl.c seems to need linux/smp_lock.h
	to be included otherwise the kernel won't link if you're compiling
	for uni-proc due to missing kernel_locked().

 	Hope this is helpful.
	
	Al.

--------8<------- Patch -------8<----------

	
--- linux-2.5.45/drivers/acpi/processor.c.orig	Mon Nov  4 21:39:16 2002
+++ linux-2.5.45/drivers/acpi/processor.c	Mon Nov  4 21:25:18 2002
@@ -1047,6 +1047,7 @@
 	u8			value = 0;
 	int			i = 0;
 	struct cpufreq_freqs    cpufreq_freqs;
+	struct cpufreq_policy   policy;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_set_performance");
 
@@ -1078,59 +1079,13 @@
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Transitioning from P%d to P%d\n",
 		pr->performance.state, state));
 
-	/* cpufreq frequency struct */
-	cpufreq_freqs.cpu = pr->id;
-	cpufreq_freqs.old = pr->performance.states[pr->performance.state].core_frequency;
-	cpufreq_freqs.new = pr->performance.states[state].core_frequency;
-
-	/* notify cpufreq */
-	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
-
-	/*
-	 * First we write the target state's 'control' value to the
-	 * control_register.
-	 */
-
-	port = pr->performance.control_register;
-	value = (u16) pr->performance.states[state].control;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
-		"Writing 0x%02x to port 0x%04x\n", value, port));
-
-	outb(value, port); 
-
-	/*
-	 * Then we read the 'status_register' and compare the value with the
-	 * target state's 'status' to make sure the transition was successful.
-	 * Note that we'll poll for up to 1ms (100 cycles of 10us) before
-	 * giving up.
-	 */
+	cpufreq_get_policy(&policy, pr->id);
 
-	port = pr->performance.status_register;
+	policy.cpu = pr->id;
+	policy.max = pr->performance.states[state].core_frequency * 1000;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
-		"Looking for 0x%02x from port 0x%04x\n",
-		(u8) pr->performance.states[state].status, port));
+	cpufreq_set_policy(&policy);
 
-	for (i=0; i<100; i++) {
-		value = inb(port);
-		if (value == (u8) pr->performance.states[state].status)
-			break;
-		udelay(10);
-	}
-
-	/* notify cpufreq */
-	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
-
-	if (value != pr->performance.states[state].status) {
-		unsigned int tmp = cpufreq_freqs.new;
-		cpufreq_freqs.new = cpufreq_freqs.old;
-		cpufreq_freqs.old = tmp;
-		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
-		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Transition failed\n"));
-		return_VALUE(-ENODEV);
-	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 		"Transition successful after %d microseconds\n",
@@ -1772,7 +1727,7 @@
 
 	/* test if it works */
 	current_state = pr->performance.state;
-/*
+
 	if (current_state == pr->limit.state.px) {
 		result = acpi_processor_set_performance(pr, (pr->performance.state_count - 1));
 		if (result) {
@@ -1797,7 +1752,7 @@
 			return_VALUE(-ENODEV);
 		}
 	}
-*/
+
 	/* initialization of main "cpufreq" code*/
 	driver = kmalloc(sizeof(struct cpufreq_driver) + 
 			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
@@ -2020,6 +1975,7 @@
 
 	ACPI_FUNCTION_TRACE("acpi_processor_read_performance");
 
+
 	if (!pr || (off != 0))
 		goto end;
 
@@ -2077,13 +2033,15 @@
 	
 	state_string[count] = '\0';
 	new_state = simple_strtoul(state_string, NULL, 0);
-
+/*
 	cpufreq_get_policy(&policy, pr->id);
 
 	policy.cpu = pr->id;
 	policy.max = pr->performance.states[new_state].core_frequency * 1000;
 
 	result = cpufreq_set_policy(&policy);
+*/
+	result = acpi_processor_set_performance(pr,new_state);
 	if (result)
 		return_VALUE(result);
 
@@ -2289,6 +2247,7 @@
 
 	ACPI_FUNCTION_TRACE("acpi_processor_add_fs");
 
+
 	if (!acpi_processor_dir) {
 		acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, 
 			acpi_root_dir);


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
