From: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: [PATCH 2.6] (5/5) make # of performance states dynamic
Date: Thu, 29 Jan 2004 11:59:05 +0100
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <20040129105905.GE5372@dominikbrodowski.de>
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

Make # of performance states dynamic. Fixes (partly) TBD #1.

 arch/i386/kernel/cpu/cpufreq/acpi.c |   17 ++++++++++++++++-
 drivers/acpi/processor.c            |   17 +++++++++--------
 include/acpi/processor.h            |    4 +---
 3 files changed, 26 insertions(+), 12 deletions(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-18 19:13:09.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-29 11:41:10.161508080 +0100
@@ -53,7 +53,7 @@
 
 struct cpufreq_acpi_io {
 	struct acpi_processor_performance	acpi_data;
-	struct cpufreq_frequency_table		freq_table[ACPI_PROCESSOR_MAX_PERFORMANCE];
+	struct cpufreq_frequency_table		*freq_table;
 };
 
 static struct cpufreq_acpi_io	*acpi_io_data[NR_CPUS];
@@ -263,6 +263,7 @@
 	/* capability check */
 	if (data->acpi_data.state_count <= 1) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No P-States\n"));
+		result = -ENODEV;
 		goto err_unreg;
 	}
 	if ((data->acpi_data.control_register.space_id != ACPI_ADR_SPACE_SYSTEM_IO) ||
@@ -270,6 +271,14 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unsupported address space [%d, %d]\n",
 				  (u32) (data->acpi_data.control_register.space_id),
 				  (u32) (data->acpi_data.status_register.space_id)));
+		result = -ENODEV;
+		goto err_unreg;
+	}
+
+	/* alloc freq_table */
+	data->freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) * (data->acpi_data.state_count + 1), GFP_KERNEL);
+	if (!data->freq_table) {
+		result = -ENOMEM;
 		goto err_unreg;
 	}
 
@@ -298,6 +307,10 @@
 	}
 
 	result = cpufreq_frequency_table_cpuinfo(policy, &data->freq_table[0]);
+	if (result) {
+		goto err_freqfree;
+	}
+		
 
 	printk(KERN_INFO "cpufreq: CPU%u - ACPI performance management activated.\n",
 	       cpu);
@@ -310,6 +323,8 @@
 
 	return_VALUE(result);
 
+ err_freqfree:
+	kfree(data->freq_table);
  err_unreg:
 	acpi_processor_unregister_performance(&data->acpi_data, cpu);
  err_free:
diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2004-01-29 11:02:55.000000000 +0100
+++ linux/drivers/acpi/processor.c	2004-01-29 11:41:19.938021824 +0100
@@ -23,7 +23,7 @@
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *  TBD:
- *	1. Make # power/performance states dynamic.
+ *	1. Make # power states dynamic.
  *	2. Support duty_cycle values that span bit 4.
  *	3. Optimize by having scheduler determine business instead of
  *	   having us try to calculate it here.
@@ -986,14 +986,12 @@
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d performance states\n", 
 		pss->package.count));
 
-	if (pss->package.count > ACPI_PROCESSOR_MAX_PERFORMANCE) {
-		pr->performance->state_count = ACPI_PROCESSOR_MAX_PERFORMANCE;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
-			"Limiting number of states to max (%d)\n", 
-			ACPI_PROCESSOR_MAX_PERFORMANCE));
+	pr->performance->state_count = pss->package.count;
+	pr->performance->states = kmalloc(sizeof(struct acpi_processor_px) * pss->package.count, GFP_KERNEL);
+	if (!pr->performance->states) {
+		result = -ENOMEM;
+		goto end;
 	}
-	else
-		pr->performance->state_count = pss->package.count;
 
 	for (i = 0; i < pr->performance->state_count; i++) {
 
@@ -1009,6 +1007,7 @@
 		if (ACPI_FAILURE(status)) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSS data\n"));
 			result = -EFAULT;
+			kfree(pr->performance->states);
 			goto end;
 		}
 
@@ -1025,6 +1024,7 @@
 		if (!px->core_frequency) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "core_frequency is 0\n"));
 			result = -EFAULT;
+			kfree(pr->performance->states);
 			goto end;
 		}
 	}
@@ -1281,6 +1281,7 @@
 		return_VOID;
 	}
 
+	kfree(pr->performance->states);
 	pr->performance = NULL;
 
 	acpi_cpufreq_remove_file(pr);
diff -ruN linux-original/include/acpi/processor.h linux/include/acpi/processor.h
--- linux-original/include/acpi/processor.h	2004-01-29 11:02:55.000000000 +0100
+++ linux/include/acpi/processor.h	2004-01-29 10:57:52.000000000 +0100
@@ -9,8 +9,6 @@
 #define ACPI_PROCESSOR_MAX_C2_LATENCY	100
 #define ACPI_PROCESSOR_MAX_C3_LATENCY	1000
 
-#define ACPI_PROCESSOR_MAX_PERFORMANCE	8
-
 #define ACPI_PROCESSOR_MAX_THROTTLING	16
 #define ACPI_PROCESSOR_MAX_THROTTLE	250	/* 25% */
 #define ACPI_PROCESSOR_MAX_DUTY_WIDTH	4
@@ -75,7 +73,7 @@
 	struct acpi_pct_register control_register;
 	struct acpi_pct_register status_register;
 	unsigned int		 state_count;
-	struct acpi_processor_px states[ACPI_PROCESSOR_MAX_PERFORMANCE];
+	struct acpi_processor_px *states;
 
 	/* the _PDC objects passed by the driver, if any */
 	struct acpi_object_list *pdc;
