From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Disallow writing to /proc/acpi/processor/xy/performance
Date: Thu, 17 Aug 2006 16:51:27 +0200
Message-ID: <1155826287.4302.1284.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-NRK1SSNoNeVZ0k5p1TvP"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:12244 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965103AbWHQOqg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Aug 2006 10:46:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: cpufreq <cpufreq@lists.linux.org.uk>


--=-NRK1SSNoNeVZ0k5p1TvP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Makes the cpufreq stuff at least a bit easier...

Compile tested, patched against 2.6.18-rc2

Disallow writing to /proc/acpi/processor/xy/performance

The preferred interface to switch CPU frequency steps is /sys/.../cpufreq.
This is known since the beginning of 2.6 kernels.
Writing to this file may interfere with thermal or _PPC limits.
If writing to the file is done while frequency is limited, frequency will get
stuck to this limit.

Signed-off-by: Thomas Renninger <mail@renninger.de>


 drivers/acpi/processor_perflib.c |   44 ---------------------------------------
 drivers/cpufreq/cpufreq.c        |    5 +---
 include/linux/cpufreq.h          |    1 
 3 files changed, 2 insertions(+), 48 deletions(-)

Index: linux-2.6.18-rc4/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/acpi/processor_perflib.c
+++ linux-2.6.18-rc4/drivers/acpi/processor_perflib.c
@@ -447,49 +447,6 @@ static int acpi_processor_perf_open_fs(s
 			   PDE(inode)->data);
 }
 
-static ssize_t
-acpi_processor_write_performance(struct file *file,
-				 const char __user * buffer,
-				 size_t count, loff_t * data)
-{
-	int result = 0;
-	struct seq_file *m = (struct seq_file *)file->private_data;
-	struct acpi_processor *pr = (struct acpi_processor *)m->private;
-	struct acpi_processor_performance *perf;
-	char state_string[12] = { '\0' };
-	unsigned int new_state = 0;
-	struct cpufreq_policy policy;
-
-
-	if (!pr || (count > sizeof(state_string) - 1))
-		return -EINVAL;
-
-	perf = pr->performance;
-	if (!perf)
-		return -EINVAL;
-
-	if (copy_from_user(state_string, buffer, count))
-		return -EFAULT;
-
-	state_string[count] = '\0';
-	new_state = simple_strtoul(state_string, NULL, 0);
-
-	if (new_state >= perf->state_count)
-		return -EINVAL;
-
-	cpufreq_get_policy(&policy, pr->id);
-
-	policy.cpu = pr->id;
-	policy.min = perf->states[new_state].core_frequency * 1000;
-	policy.max = perf->states[new_state].core_frequency * 1000;
-
-	result = cpufreq_set_policy(&policy);
-	if (result)
-		return result;
-
-	return count;
-}
-
 static void acpi_cpufreq_add_file(struct acpi_processor *pr)
 {
 	struct proc_dir_entry *entry = NULL;
@@ -504,7 +461,6 @@ static void acpi_cpufreq_add_file(struct
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (entry){
-		acpi_processor_perf_fops.write = acpi_processor_write_performance;
 		entry->proc_fops = &acpi_processor_perf_fops;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
Index: linux-2.6.18-rc4/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.18-rc4/drivers/cpufreq/cpufreq.c
@@ -375,6 +375,7 @@ show_one(scaling_max_freq, max);
 show_one(scaling_cur_freq, cur);
 
 static int __cpufreq_set_policy(struct cpufreq_policy *data, struct cpufreq_policy *policy);
+static int cpufreq_set_policy(struct cpufreq_policy *policy);
 
 /**
  * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
@@ -1448,7 +1449,7 @@ error_out:
  *
  *	Sets a new CPU frequency and voltage scaling policy.
  */
-int cpufreq_set_policy(struct cpufreq_policy *policy)
+static int cpufreq_set_policy(struct cpufreq_policy *policy)
 {
 	int ret = 0;
 	struct cpufreq_policy *data;
@@ -1478,8 +1479,6 @@ int cpufreq_set_policy(struct cpufreq_po
 
 	return ret;
 }
-EXPORT_SYMBOL(cpufreq_set_policy);
-
 
 /**
  *	cpufreq_update_policy - re-evaluate an existing cpufreq policy
Index: linux-2.6.18-rc4/include/linux/cpufreq.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/cpufreq.h
+++ linux-2.6.18-rc4/include/linux/cpufreq.h
@@ -252,7 +252,6 @@ struct freq_attr {
 /*********************************************************************
  *                        CPUFREQ 2.6. INTERFACE                     *
  *********************************************************************/
-int cpufreq_set_policy(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 int cpufreq_update_policy(unsigned int cpu);
 


--=-NRK1SSNoNeVZ0k5p1TvP
Content-Disposition: attachment; filename=cpufreq_performance_non_writing.patch
Content-Type: text/x-patch; name=cpufreq_performance_non_writing.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Disallow writing to /proc/acpi/processor/xy/performance

The preferred interface to switch CPU frequency steps is /sys/.../cpufreq.
This is known since the beginning of 2.6 kernels.
Writing to this file may interfere with thermal or _PPC limits.
If writing to the file is done while frequency is limited, frequency will get
stuck to this limit.

Signed-off-by: Thomas Renninger <mail@renninger.de>


 drivers/acpi/processor_perflib.c |   44 ---------------------------------------
 drivers/cpufreq/cpufreq.c        |    5 +---
 include/linux/cpufreq.h          |    1 
 3 files changed, 2 insertions(+), 48 deletions(-)

Index: linux-2.6.18-rc4/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/acpi/processor_perflib.c
+++ linux-2.6.18-rc4/drivers/acpi/processor_perflib.c
@@ -447,49 +447,6 @@ static int acpi_processor_perf_open_fs(s
 			   PDE(inode)->data);
 }
 
-static ssize_t
-acpi_processor_write_performance(struct file *file,
-				 const char __user * buffer,
-				 size_t count, loff_t * data)
-{
-	int result = 0;
-	struct seq_file *m = (struct seq_file *)file->private_data;
-	struct acpi_processor *pr = (struct acpi_processor *)m->private;
-	struct acpi_processor_performance *perf;
-	char state_string[12] = { '\0' };
-	unsigned int new_state = 0;
-	struct cpufreq_policy policy;
-
-
-	if (!pr || (count > sizeof(state_string) - 1))
-		return -EINVAL;
-
-	perf = pr->performance;
-	if (!perf)
-		return -EINVAL;
-
-	if (copy_from_user(state_string, buffer, count))
-		return -EFAULT;
-
-	state_string[count] = '\0';
-	new_state = simple_strtoul(state_string, NULL, 0);
-
-	if (new_state >= perf->state_count)
-		return -EINVAL;
-
-	cpufreq_get_policy(&policy, pr->id);
-
-	policy.cpu = pr->id;
-	policy.min = perf->states[new_state].core_frequency * 1000;
-	policy.max = perf->states[new_state].core_frequency * 1000;
-
-	result = cpufreq_set_policy(&policy);
-	if (result)
-		return result;
-
-	return count;
-}
-
 static void acpi_cpufreq_add_file(struct acpi_processor *pr)
 {
 	struct proc_dir_entry *entry = NULL;
@@ -504,7 +461,6 @@ static void acpi_cpufreq_add_file(struct
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (entry){
-		acpi_processor_perf_fops.write = acpi_processor_write_performance;
 		entry->proc_fops = &acpi_processor_perf_fops;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
Index: linux-2.6.18-rc4/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.18-rc4/drivers/cpufreq/cpufreq.c
@@ -375,6 +375,7 @@ show_one(scaling_max_freq, max);
 show_one(scaling_cur_freq, cur);
 
 static int __cpufreq_set_policy(struct cpufreq_policy *data, struct cpufreq_policy *policy);
+static int cpufreq_set_policy(struct cpufreq_policy *policy);
 
 /**
  * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
@@ -1448,7 +1449,7 @@ error_out:
  *
  *	Sets a new CPU frequency and voltage scaling policy.
  */
-int cpufreq_set_policy(struct cpufreq_policy *policy)
+static int cpufreq_set_policy(struct cpufreq_policy *policy)
 {
 	int ret = 0;
 	struct cpufreq_policy *data;
@@ -1478,8 +1479,6 @@ int cpufreq_set_policy(struct cpufreq_po
 
 	return ret;
 }
-EXPORT_SYMBOL(cpufreq_set_policy);
-
 
 /**
  *	cpufreq_update_policy - re-evaluate an existing cpufreq policy
Index: linux-2.6.18-rc4/include/linux/cpufreq.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/cpufreq.h
+++ linux-2.6.18-rc4/include/linux/cpufreq.h
@@ -252,7 +252,6 @@ struct freq_attr {
 /*********************************************************************
  *                        CPUFREQ 2.6. INTERFACE                     *
  *********************************************************************/
-int cpufreq_set_policy(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 int cpufreq_update_policy(unsigned int cpu);
 

--=-NRK1SSNoNeVZ0k5p1TvP--

