From: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: [RFC][PATCH] notify BIOS of cpufreq support (pstate_cnt)
Date: Mon, 14 Jun 2004 23:55:20 +0200
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040614215520.GA17906@dominikbrodowski.de>
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
To: cpufreq@www.linux.org.uk, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

[Follow-up to http://marc.theaimsgroup.com/?l=acpi4linux&m=107684287525298&w=2 
which was the last try of getting this right last February]

Notify SMM of cpufreq

Often, the BIOS changes the CPU frequency if a notebook is (dis)connected
from its AC adapter. This interferes with a) an user setting the CPU frequency
and b) kernel timing code which needs to know loops_per_jiffy, cpu_khz etc.

So, ACPI 2.0 offers a method to disable such BIOS changes -- writing
a value contained in the FADT (pstate_cnt) to the smi_cmd port. This patch
utilizes this method by doing this write in processor.c.

However, most current notebooks only offer 1.0 ACPI tables, where the
pstate_cnt entry is marked as "reserved". Unless ACPI is in strict mode,
the value in this "reserved" field is used as well, but a warning is
printed.

So, when is the BIOS notified? When should it be notified? The ACPI 
specification doesn't say much about it. This patch does it if either
of the following cpufreq drivers is pretty much done with a successful
registration:

- acpi
- powernow-k7 [if either it is blacklisted or acpi_force is used]
- powernow-k8 [if the preferred DSDT method is used -- normally, it is...]
- speedstep-centrino [if the preferred DSDT method is used -- normally, it is...]
- speedstep-ich [if the ACPI processor module is built into the kernel. Dave, Arjan: is it in FC?]
- speedstep-smi [if the processor module is built into the kernel. Dave, Arjan: is it in FC?]

There's a small problem with the whole pstate_cnt approach: if there is a 
pyhsical[*] platform limit, it might be necessary to adjust the CPU frequency
to avoid serious problems. Unless the BIOS is notified, the BIOS will likely
do such adjustments on its own. As it is notified now that the OS is handling
P-States, it might be that the BIOS won't handle such serious limits -- but
if the cpufreq driver is "rmmod'ed" in between, it won't be handled. This
is a serious error, but it will _also_ happen on _any_ OS if:
a) the pstate_cnt is written to the BIOS
b) the system locks up hard afterwards so that even IRQs are not handled any more
c) the physical platform limit event occurs

However, I'm unsure as to whether we should "lock" the cpufreq driver once it called
acpi_processor_notify_smm() to minimize the risk mentioned above. What's the opinion of the ACPI
team at Intel?

[*] not the "we-want-to-have-X-hours-of-battery-time-in-that-test" type of platform limits...

Signed-off-by: Dominik Brodowski <linux@brodo.de>

 arch/i386/kernel/cpu/cpufreq/acpi.c               |    4 +
 arch/i386/kernel/cpu/cpufreq/powernow-k7.c        |    3 +
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c        |    3 +
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    3 +
 arch/i386/kernel/cpu/cpufreq/speedstep-ich.c      |   10 ++++
 arch/i386/kernel/cpu/cpufreq/speedstep-smi.c      |   10 ++++
 drivers/acpi/processor.c                          |   51 ++++++++++++++++++++++
 drivers/acpi/tables/tbconvrt.c                    |   10 +++-
 include/acpi/actbl.h                              |    2
 include/acpi/processor.h                          |    2
 10 files changed, 96 insertions(+), 2 deletions(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-06-14 21:30:37.137669896 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-06-14 23:10:07.929971496 +0200
@@ -324,6 +324,9 @@
 	}
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
 
+	/* notify BIOS that we exist */
+	acpi_processor_notify_smm();
+
 	/* The current speed is unknown and not detectable by ACPI...  */
 	policy->cur = acpi_cpufreq_guess_freq(data, policy->cpu);
 
@@ -353,6 +356,7 @@
 			(u32) data->acpi_data.states[i].transition_latency);
 
 	cpufreq_frequency_table_get_attr(data->freq_table, policy->cpu);
+
 	return_VALUE(result);
 
  err_freqfree:
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k7.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2004-06-14 18:20:27.000000000 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2004-06-14 23:13:31.260060624 +0200
@@ -393,6 +393,9 @@
 	powernow_table[i].frequency = CPUFREQ_TABLE_END;
 	powernow_table[i].index = 0;
 
+	/* As all looks fine by now, notify BIOS that we exist */
+	acpi_processor_notify_smm();
+
 	return 0;
 
 err2:
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k8.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-06-14 21:29:18.996549152 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-06-14 23:13:14.003683992 +0200
@@ -764,6 +764,9 @@
 	powernow_table[data->acpi_data.state_count].index = 0;
 	data->powernow_table = powernow_table;
 
+	/* As all looks fine by now, notify BIOS that we exist */
+	acpi_processor_notify_smm();
+
 	/* fill in data */
 	data->numps = data->acpi_data.state_count;
 	print_basics(data);
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c linux/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-06-14 23:26:56.074710200 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-06-14 23:11:52.340098744 +0200
@@ -371,6 +371,9 @@
                 goto err_kfree;
         }
 
+	/* notify BIOS that we exist */
+	acpi_processor_notify_smm();
+
 	cur_freq = get_cur_freq(0);
 
         for (i=0; i<p.state_count; i++) {
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c linux/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2004-06-14 21:29:19.047541400 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2004-06-14 23:10:53.856989528 +0200
@@ -25,6 +25,11 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+#ifdef CONFIG_ACPI_PROCESSOR
+#include <linux/acpi.h>
+#include <acpi/processor.h>
+#endif
+
 #include "speedstep-lib.h"
 
 
@@ -329,6 +334,11 @@
 		return result;
 	}
 
+#ifdef CONFIG_ACPI_PROCESSOR
+	/* notify BIOS that we exist */
+	acpi_processor_notify_smm();
+#endif
+
 	/* get current speed setting */
 	speed = speedstep_get_processor_frequency(speedstep_processor);
 	set_cpus_allowed(current, cpus_allowed);
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep-smi.c linux/arch/i386/kernel/cpu/cpufreq/speedstep-smi.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep-smi.c	2004-06-14 21:29:19.102533040 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep-smi.c	2004-06-14 23:10:14.806926040 +0200
@@ -22,6 +22,11 @@
 #include <linux/delay.h>
 #include <asm/ist.h>
 
+#ifdef CONFIG_ACPI_PROCESSOR
+#include <linux/acpi.h>
+#include <acpi/processor.h>
+#endif
+
 #include "speedstep-lib.h"
 
 #define PFX "speedstep-smi: "
@@ -273,6 +278,11 @@
 			dprintk(KERN_INFO PFX "workaround worked.\n");
 	}
 
+#ifdef CONFIG_ACPI_PROCESSOR
+	/* notify BIOS that we exist */
+	acpi_processor_notify_smm();
+#endif
+
 	/* get current speed setting */
 	state = speedstep_get_state();
 	speed = speedstep_freqs[state].frequency;
diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2004-06-14 18:20:28.000000000 +0200
+++ linux/drivers/acpi/processor.c	2004-06-14 23:29:40.773672152 +0200
@@ -1072,6 +1072,57 @@
 }
 
 
+int acpi_processor_notify_smm(void) {
+	acpi_status		status;
+	static int		is_done = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_processor_notify_smm");
+
+	if (!acpi_processor_ppc_is_init)
+		return_VALUE(-EBUSY);
+
+	/* is_done is set to negative if an error occured,
+	 * and to postitive if _no_ error occured, but SMM
+	 * was already notified. This avoids double notification
+	 * which might lead to unexpected results...
+	 */
+	if (is_done > 0)
+		return_VALUE(0);
+	else if (is_done < 0)
+		return_VALUE(is_done);
+
+	is_done = -EIO;
+
+	/* Can't write pstate_cnt to smi_cmd if either value is zero */
+	if ((!acpi_fadt.smi_cmd) ||
+	    (!acpi_fadt.pstate_cnt)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"No SMI port or pstate_cnt\n"));
+		return_VALUE(0);
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Writing pstate_cnt [0x%x] to smi_cmd [0x%x]\n", acpi_fadt.pstate_cnt, acpi_fadt.smi_cmd));
+
+	/* FADT v1 doesn't support pstate_cnt, many BIOS vendors use
+	 * it anyway, so we need to support it... */
+	if (acpi_fadt_is_v1) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Using v1.0 FADT reserved value for pstate_cnt\n"));
+	}
+
+	status = acpi_os_write_port (acpi_fadt.smi_cmd,
+				     (u32) acpi_fadt.pstate_cnt, 8);
+	if (ACPI_FAILURE (status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Failed to write pstate_cnt [0x%x] to "
+				  "smi_cmd [0x%x]\n", acpi_fadt.pstate_cnt, acpi_fadt.smi_cmd));
+	} else
+		is_done = 1;
+
+	return_VALUE(0);
+}
+EXPORT_SYMBOL(acpi_processor_notify_smm);
+
+
 #ifdef CONFIG_X86_ACPI_CPUFREQ_PROC_INTF
 /* /proc/acpi/processor/../performance interface (DEPRECATED) */
 
diff -ruN linux-original/drivers/acpi/tables/tbconvrt.c linux/drivers/acpi/tables/tbconvrt.c
--- linux-original/drivers/acpi/tables/tbconvrt.c	2004-06-14 18:20:28.000000000 +0200
+++ linux/drivers/acpi/tables/tbconvrt.c	2004-06-14 22:37:57.198487296 +0200
@@ -50,6 +50,8 @@
 	 ACPI_MODULE_NAME    ("tbconvrt")
 
 
+u8 acpi_fadt_is_v1;
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_get_table_count
@@ -212,6 +214,7 @@
 
 	/* ACPI 1.0 FACS */
 	/* The BIOS stored FADT should agree with Revision 1.0 */
+	acpi_fadt_is_v1 = 1;
 
 	/*
 	 * Copy the table header and the common part of the tables.
@@ -240,9 +243,12 @@
 	/*
 	 * Processor Performance State Control. This is the value OSPM writes to
 	 * the SMI_CMD register to assume processor performance state control
-	 * responsibility. There isn't any equivalence in 1.0, leave it zeroed.
+	 * responsibility. There isn't any equivalence in 1.0, but as many 1.x
+	 * ACPI tables contain _PCT and _PSS we also keep this value, unless
+	 * acpi_strict is set.
 	 */
-	local_fadt->pstate_cnt = 0;
+	if (acpi_strict)
+		local_fadt->pstate_cnt = 0;
 
 	/*
 	 * Support for the _CST object and C States change notification.
diff -ruN linux-original/include/acpi/actbl.h linux/include/acpi/actbl.h
--- linux-original/include/acpi/actbl.h	2004-06-14 18:20:30.000000000 +0200
+++ linux/include/acpi/actbl.h	2004-06-14 22:37:27.009076784 +0200
@@ -343,5 +343,7 @@
 #include "actbl1.h"   /* Acpi 1.0 table definitions */
 #include "actbl2.h"   /* Acpi 2.0 table definitions */
 
+extern u8 acpi_fadt_is_v1; /* is set to 1 if FADT is revision 1,
+			    * needed for certain workarounds */
 
 #endif /* __ACTBL_H__ */
diff -ruN linux-original/include/acpi/processor.h linux/include/acpi/processor.h
--- linux-original/include/acpi/processor.h	2004-06-14 18:20:30.000000000 +0200
+++ linux/include/acpi/processor.h	2004-06-14 23:04:16.551389160 +0200
@@ -140,4 +140,6 @@
 	struct acpi_processor_performance * performance,
 	unsigned int cpu);
 
+extern int acpi_processor_notify_smm (void);
+
 #endif
