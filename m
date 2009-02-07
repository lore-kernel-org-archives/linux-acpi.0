From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/30] ACPI: cpufreq: Remove deprecated
 /proc/acpi/processor/../performance proc entries
Date: Sat, 07 Feb 2009 01:41:29 -0500
Message-ID: <62663ea8220366472fe20462831f2d69d7987439.1233988826.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:44024 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbZBGGmJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:09 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KEO00C99NXZPYE4@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:42:00 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

They were long enough set deprecated...

Update Documentation/cpu-freq/users-guide.txt:
The deprecated files listed there seen not to exist for some time anymore
already.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/cpu-freq/user-guide.txt |   16 -----
 arch/x86/kernel/cpu/cpufreq/Kconfig   |   11 ----
 drivers/acpi/processor_perflib.c      |  105 ---------------------------------
 3 files changed, 0 insertions(+), 132 deletions(-)

diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
index e3443dd..917918f 100644
--- a/Documentation/cpu-freq/user-guide.txt
+++ b/Documentation/cpu-freq/user-guide.txt
@@ -195,19 +195,3 @@ scaling_setspeed.		By "echoing" a new frequency into this
 				you can change the speed of the CPU,
 				but only within the limits of
 				scaling_min_freq and scaling_max_freq.
-				
-
-3.2 Deprecated Interfaces
--------------------------
-
-Depending on your kernel configuration, you might find the following 
-cpufreq-related files:
-/proc/cpufreq
-/proc/sys/cpu/*/speed
-/proc/sys/cpu/*/speed-min
-/proc/sys/cpu/*/speed-max
-
-These are files for deprecated interfaces to cpufreq, which offer far
-less functionality. Because of this, these interfaces aren't described
-here.
-
diff --git a/arch/x86/kernel/cpu/cpufreq/Kconfig b/arch/x86/kernel/cpu/cpufreq/Kconfig
index efae3b2..65792c2 100644
--- a/arch/x86/kernel/cpu/cpufreq/Kconfig
+++ b/arch/x86/kernel/cpu/cpufreq/Kconfig
@@ -245,17 +245,6 @@ config X86_E_POWERSAVER
 
 comment "shared options"
 
-config X86_ACPI_CPUFREQ_PROC_INTF
-	bool "/proc/acpi/processor/../performance interface (deprecated)"
-	depends on PROC_FS
-	depends on X86_ACPI_CPUFREQ || X86_POWERNOW_K7_ACPI || X86_POWERNOW_K8_ACPI
-	help
-	  This enables the deprecated /proc/acpi/processor/../performance
-	  interface. While it is helpful for debugging, the generic,
-	  cross-architecture cpufreq interfaces should be used.
-
-	  If in doubt, say N.
-
 config X86_SPEEDSTEP_LIB
 	tristate
 	default (X86_SPEEDSTEP_ICH || X86_SPEEDSTEP_SMI || X86_P4_CLOCKMOD)
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 846e227..9cc769b 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -31,14 +31,6 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 
-#ifdef CONFIG_X86_ACPI_CPUFREQ_PROC_INTF
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/mutex.h>
-
-#include <asm/uaccess.h>
-#endif
-
 #ifdef CONFIG_X86
 #include <asm/cpufeature.h>
 #endif
@@ -434,96 +426,6 @@ int acpi_processor_notify_smm(struct module *calling_module)
 
 EXPORT_SYMBOL(acpi_processor_notify_smm);
 
-#ifdef CONFIG_X86_ACPI_CPUFREQ_PROC_INTF
-/* /proc/acpi/processor/../performance interface (DEPRECATED) */
-
-static int acpi_processor_perf_open_fs(struct inode *inode, struct file *file);
-static struct file_operations acpi_processor_perf_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_processor_perf_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int acpi_processor_perf_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_processor *pr = seq->private;
-	int i;
-
-
-	if (!pr)
-		goto end;
-
-	if (!pr->performance) {
-		seq_puts(seq, "<not supported>\n");
-		goto end;
-	}
-
-	seq_printf(seq, "state count:             %d\n"
-		   "active state:            P%d\n",
-		   pr->performance->state_count, pr->performance->state);
-
-	seq_puts(seq, "states:\n");
-	for (i = 0; i < pr->performance->state_count; i++)
-		seq_printf(seq,
-			   "   %cP%d:                  %d MHz, %d mW, %d uS\n",
-			   (i == pr->performance->state ? '*' : ' '), i,
-			   (u32) pr->performance->states[i].core_frequency,
-			   (u32) pr->performance->states[i].power,
-			   (u32) pr->performance->states[i].transition_latency);
-
-      end:
-	return 0;
-}
-
-static int acpi_processor_perf_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_processor_perf_seq_show,
-			   PDE(inode)->data);
-}
-
-static void acpi_cpufreq_add_file(struct acpi_processor *pr)
-{
-	struct acpi_device *device = NULL;
-
-
-	if (acpi_bus_get_device(pr->handle, &device))
-		return;
-
-	/* add file 'performance' [R/W] */
-	proc_create_data(ACPI_PROCESSOR_FILE_PERFORMANCE, S_IFREG | S_IRUGO,
-			 acpi_device_dir(device),
-			 &acpi_processor_perf_fops, acpi_driver_data(device));
-	return;
-}
-
-static void acpi_cpufreq_remove_file(struct acpi_processor *pr)
-{
-	struct acpi_device *device = NULL;
-
-
-	if (acpi_bus_get_device(pr->handle, &device))
-		return;
-
-	/* remove file 'performance' */
-	remove_proc_entry(ACPI_PROCESSOR_FILE_PERFORMANCE,
-			  acpi_device_dir(device));
-
-	return;
-}
-
-#else
-static void acpi_cpufreq_add_file(struct acpi_processor *pr)
-{
-	return;
-}
-static void acpi_cpufreq_remove_file(struct acpi_processor *pr)
-{
-	return;
-}
-#endif				/* CONFIG_X86_ACPI_CPUFREQ_PROC_INTF */
-
 static int acpi_processor_get_psd(struct acpi_processor	*pr)
 {
 	int result = 0;
@@ -747,14 +649,12 @@ err_ret:
 }
 EXPORT_SYMBOL(acpi_processor_preregister_performance);
 
-
 int
 acpi_processor_register_performance(struct acpi_processor_performance
 				    *performance, unsigned int cpu)
 {
 	struct acpi_processor *pr;
 
-
 	if (!(acpi_processor_ppc_status & PPC_REGISTERED))
 		return -EINVAL;
 
@@ -781,8 +681,6 @@ acpi_processor_register_performance(struct acpi_processor_performance
 		return -EIO;
 	}
 
-	acpi_cpufreq_add_file(pr);
-
 	mutex_unlock(&performance_mutex);
 	return 0;
 }
@@ -795,7 +693,6 @@ acpi_processor_unregister_performance(struct acpi_processor_performance
 {
 	struct acpi_processor *pr;
 
-
 	mutex_lock(&performance_mutex);
 
 	pr = per_cpu(processors, cpu);
@@ -808,8 +705,6 @@ acpi_processor_unregister_performance(struct acpi_processor_performance
 		kfree(pr->performance->states);
 	pr->performance = NULL;
 
-	acpi_cpufreq_remove_file(pr);
-
 	mutex_unlock(&performance_mutex);
 
 	return;
-- 
1.5.6.6

