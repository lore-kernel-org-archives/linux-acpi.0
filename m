From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [2.4] random fix, new features request.
Date: Mon, 17 Feb 2003 14:45:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030217134527.GA25625@poup.poupinou.org>
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
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

Here come some random fix and one new feature for acpi, linux 2.4.
Some of them was already send to acpi-devel, some not..


I will be offline for one week, just to let you know..

ChanLog follow:


-- wakeup code: forgot to flush the prefetch queue before going to protected mode.

-- osl::acpi_os_derive_pci_id(): When traversing the tree, each bridge get the
                                 the wrong bus number.  Then, we cannot walk anymore.
				 Plus, the pcmcia bridge case was not correctly handled.

-- hardware::hwsleep.c: add comment for a TODO.
-- hardware::hwsleep.c: enable BM arbitration before _WAK and such, just in
                        case AML interpreter have to access
			pci config operational region(s) on the resume path.

-- s4bios: - fix a stupid bug were we power off the devices 2 times (instead of one..)
           - reinit the irq controller as per spec (only X86).

-- system: - do not allow 'echo 5 > /proc/acpi/sleep' anymore.
           - Correct behaviour of S5, just in case someone insist
	   to use acpi_enter_state() instead of acpi_power_off().

-- new feature: implement an override for \_OS at boot time.

 
 arch/i386/kernel/acpi_wakeup.S  |   17 ++++----
 drivers/acpi/hardware/hwsleep.c |   10 ++--
 drivers/acpi/osl.c              |   84 ++++++++++++++++++++++++++++++++++++----
 drivers/acpi/system.c           |   40 ++++++++++++++-----
 include/acpi/acpiosxf.h         |    5 ++
 5 files changed, 127 insertions(+), 29 deletions(-)



Index: linux-2.4/arch/i386/kernel/acpi_wakeup.S
===================================================================
RCS file: /home/ducrot/var/cvs/linux-2.4/arch/i386/kernel/acpi_wakeup.S,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 acpi_wakeup.S
--- linux-2.4/arch/i386/kernel/acpi_wakeup.S	13 Feb 2003 00:14:33 -0000	1.1.1.1
+++ linux-2.4/arch/i386/kernel/acpi_wakeup.S	15 Feb 2003 01:02:23 -0000
@@ -4,7 +4,7 @@
 #include <asm/segment.h>
 
 
-ALIGN
+.org 0
 wakeup_start:
 wakeup_code:
 	wakeup_code_start = .
@@ -15,11 +15,11 @@
 
 	# setup data segment
 	movw	%cs, %ax
-
-	addw	$(wakeup_data - wakeup_code) >> 4, %ax
 	movw	%ax, %ds
 	movw	%ax, %ss
-	mov	$(wakeup_stack - wakeup_data), %sp		# Private stack is needed for ASUS board
+
+	# Private stack is needed for ASUS board
+	mov	$(wakeup_stack - wakeup_data), %sp
 
 	# set up page table
 	movl	(real_save_cr3 - wakeup_data), %eax
@@ -32,15 +32,16 @@
 	# need a gdt
 	lgdt	real_save_gdt - wakeup_data
 
+	# Flush the prefetch queue
+	jmp 1f
+1:
+
 	movl	%cr0, %eax
 	orl     $0x80000001, %eax
 	movl	%eax, %cr0
 
 	ljmpl	$__KERNEL_CS,$SYMBOL_NAME(wakeup_pmode_return)
 
-	.code32
-	ALIGN
-
 .org	0x100
 wakeup_data:
 		.word 0
@@ -53,6 +54,8 @@
 wakeup_stack:
 wakeup_end:
 
+	ALIGN
+	.code32
 wakeup_pmode_return:
 	# restore data segment
 	movl	$__KERNEL_DS, %eax
Index: linux-2.4/drivers/acpi/osl.c
===================================================================
RCS file: /home/ducrot/var/cvs/linux-2.4/drivers/acpi/osl.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.2
diff -u -r1.1.1.1 -r1.1.1.1.2.2
--- linux-2.4/drivers/acpi/osl.c	13 Feb 2003 00:14:13 -0000	1.1.1.1
+++ linux-2.4/drivers/acpi/osl.c	13 Feb 2003 01:06:17 -0000	1.1.1.1.2.2
@@ -201,6 +201,22 @@
 	return AE_OK;
 }
 
+static char acpi_os_name[200] = ACPI_OS_NAME;
+
+acpi_status
+acpi_os_predefined_override (const struct acpi_predefined_names *init_val,
+		             acpi_string *new_val)
+{
+	if (!init_val || !new_val)
+		return AE_BAD_PARAMETER;
+
+	*new_val = NULL;
+	if (!memcmp (init_val->name, "_OS_", 4))
+		*new_val = acpi_os_name;
+
+	return AE_OK;
+}
+
 acpi_status
 acpi_os_table_override (struct acpi_table_header *existing_table,
 			struct acpi_table_header **new_table)
@@ -477,11 +493,13 @@
 	return (result ? AE_ERROR : AE_OK);
 }
 
-void
-acpi_os_derive_pci_id (
+static void
+acpi_os_derive_pci_id_2 (
 	acpi_handle		rhandle,        /* upper bound  */
 	acpi_handle		chandle,        /* current node */
-	struct acpi_pci_id	**id)
+	struct acpi_pci_id	**id,
+	int			*is_bridge,
+	u8			*bus_number)
 {
 	acpi_handle		handle;
 	struct acpi_pci_id	*pci_id = *id;
@@ -492,7 +510,7 @@
 
 	acpi_get_parent(chandle, &handle);
 	if (handle != rhandle) {
-		acpi_os_derive_pci_id(rhandle, handle, &pci_id);
+		acpi_os_derive_pci_id_2(rhandle, handle, &pci_id, is_bridge, bus_number);
 
 		status = acpi_get_type(handle, &type);
 		if ( (ACPI_FAILURE(status)) || (type != ACPI_TYPE_DEVICE) )
@@ -503,17 +521,42 @@
 			pci_id->device  = ACPI_HIWORD (ACPI_LODWORD (temp));
 			pci_id->function = ACPI_LOWORD (ACPI_LODWORD (temp));
 
+			if (*is_bridge)
+				pci_id->bus = *bus_number;
+
 			/* any nicer way to get bus number of bridge ? */
 			status = acpi_os_read_pci_configuration(pci_id, 0x0e, &tu8, 8);
-			if (ACPI_SUCCESS(status) && (tu8 & 0x7f) == 1) {
+			if (ACPI_SUCCESS(status) &&
+			    ((tu8 & 0x7f) == 1 || (tu8 & 0x7f) == 2)) {
+				status = acpi_os_read_pci_configuration(pci_id, 0x18, &tu8, 8);
+				if (!ACPI_SUCCESS(status)) {
+					/* Certainly broken...  FIX ME */
+					return;
+				}
+				*is_bridge = 1;
+				pci_id->bus = tu8;
 				status = acpi_os_read_pci_configuration(pci_id, 0x19, &tu8, 8);
-				if (ACPI_SUCCESS(status))
-					pci_id->bus = tu8;
-			}
+				if (ACPI_SUCCESS(status)) {
+					*bus_number = tu8;
+				}
+			} else
+				*is_bridge = 0;
 		}
 	}
 }
 
+void
+acpi_os_derive_pci_id (
+	acpi_handle		rhandle,        /* upper bound  */
+	acpi_handle		chandle,        /* current node */
+	struct acpi_pci_id	**id)
+{
+	int is_bridge = 1;
+	u8 bus_number = (*id)->bus;
+
+	acpi_os_derive_pci_id_2(rhandle, chandle, id, &is_bridge, &bus_number);
+}
+
 #else /*!CONFIG_ACPI_PCI*/
 
 acpi_status
@@ -837,3 +880,28 @@
 
 	return AE_OK;
 }
+
+int __init
+acpi_os_name_setup(char *str)
+{
+	char *p = acpi_os_name;
+	int count = 199;
+
+	if (!str || !*str)
+		return 0;
+
+	for (; count-- && str && *str; str++) {
+		if (isalnum(*str) || *str == ' ')
+			*p++ = *str;
+		else if (*str == '\'' || *str == '"')
+			continue;
+		else
+			break;
+	}
+	*p = 0;
+
+	return 1;
+		
+}
+
+__setup("acpi_os_name=", acpi_os_name_setup);
Index: linux-2.4/drivers/acpi/system.c
===================================================================
RCS file: /home/ducrot/var/cvs/linux-2.4/drivers/acpi/system.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 system.c
--- linux-2.4/drivers/acpi/system.c	13 Feb 2003 00:14:13 -0000	1.1.1.1
+++ linux-2.4/drivers/acpi/system.c	17 Feb 2003 12:51:43 -0000
@@ -32,6 +32,7 @@
 #include <linux/poll.h>
 #include <linux/delay.h>
 #include <linux/sysrq.h>
+#include <linux/irq.h>
 #include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/pm.h>
@@ -118,22 +119,32 @@
 	if (state > ACPI_STATE_S1) {
 		acpi_restore_state_mem();
 
+		/* Do _early_ resume for irqs.  Required by
+		 * ACPI specs.
+		 */
+		/* TBD: call arch dependant reinitialization of the 
+		 * interrupts.
+		 */
+#ifdef CONFIG_X86
+		init_8259A(0);
+#endif
 		/* wait for power to come back */
 		mdelay(1000);
 
-		/* turn all the devices back on */
-		pm_send_all(PM_RESUME, (void *)0);
+	}
 
-		/* Be really sure that irqs are disabled. */
-		ACPI_DISABLE_IRQS();
+	/* Be really sure that irqs are disabled. */
+	ACPI_DISABLE_IRQS();
 
-		/* Wait a little again, just in case... */
-		mdelay(1000);
+	/* Wait a little again, just in case... */
+	mdelay(1000);
 
-		/* enable interrupts once again */
-		ACPI_ENABLE_IRQS();
+	/* enable interrupts once again */
+	ACPI_ENABLE_IRQS();
 
-	}
+	/* turn all the devices back on */
+	if (state > ACPI_STATE_S1)
+		pm_send_all(PM_RESUME, (void *)0);
 
 	return AE_OK;
 }
@@ -218,7 +229,9 @@
 	 */
 
 	if (state > ACPI_STATE_S1) {
+#if 0
 		error = pm_send_all(PM_SUSPEND, (void *)3);
+#endif
 
 		/* We're pretty screwed if we got an error from this.
 		 * We try to recover by simply calling our own restore_state
@@ -265,12 +278,15 @@
 
 	switch (state) {
 	case ACPI_STATE_S1:
+	case ACPI_STATE_S5:
 		barrier();
 		status = acpi_enter_sleep_state(state);
 		break;
 	case ACPI_STATE_S4:
 		do_suspend_lowlevel_s4bios(0);
 		break;
+	default:
+		break;
 	}
 
 	/* kernel_fpu_end(); */
@@ -313,7 +329,7 @@
 	acpi_enter_sleep_state_prep(state);
 
 	status = acpi_system_save_state(state);
-	if (!ACPI_SUCCESS(status))
+	if (!ACPI_SUCCESS(status) && state != ACPI_STATE_S5)
 		return status;
 
 	/* disable interrupts and flush caches */
@@ -723,6 +739,10 @@
 	
 	if (!system->states[state])
 		return_VALUE(-ENODEV);
+
+	/* give up early if S5 */
+	if (ACPI_STATE_S5 == state)
+		return_VALUE(-EPERM);
 
 	/*
 	 * If S4 is supported by the OS, then we should assume that
Index: linux-2.4/drivers/acpi/hardware/hwsleep.c
===================================================================
RCS file: /home/ducrot/var/cvs/linux-2.4/drivers/acpi/hardware/hwsleep.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 hwsleep.c
--- linux-2.4/drivers/acpi/hardware/hwsleep.c	13 Feb 2003 00:14:14 -0000	1.1.1.2
+++ linux-2.4/drivers/acpi/hardware/hwsleep.c	13 Feb 2003 02:04:37 -0000
@@ -190,10 +190,13 @@
 	u32                             in_value;
 	acpi_status                     status;
 
+	/* TBD: fix dead lock. */
+	/* The acpi_hw_register_xxx() functions called with
+	 * ACPI_MTX_LOCK are naturally racy, especially if S2/S3.
+	 */
 
 	ACPI_FUNCTION_TRACE ("acpi_enter_sleep_state");
 
-
 	if ((acpi_gbl_sleep_type_a > ACPI_SLEEP_TYPE_MAX) ||
 		(acpi_gbl_sleep_type_b > ACPI_SLEEP_TYPE_MAX)) {
 		ACPI_REPORT_ERROR (("Sleep values out of range: A=%X B=%X\n",
@@ -385,6 +388,8 @@
 
 	ACPI_FUNCTION_TRACE ("acpi_leave_sleep_state");
 
+	/* Enable BM arbitration */
+	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	/* Ensure enter_sleep_state_prep -> enter_sleep_state ordering */
 
@@ -416,9 +421,6 @@
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
-
-	/* Disable BM arbitration */
-	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	return_ACPI_STATUS (status);
 }
Index: linux-2.4/include/acpi/acpiosxf.h
===================================================================
RCS file: /home/ducrot/var/cvs/linux-2.4/include/acpi/acpiosxf.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.4/include/acpi/acpiosxf.h	13 Feb 2003 00:11:56 -0000	1.1.1.1
+++ linux-2.4/include/acpi/acpiosxf.h	13 Feb 2003 01:06:18 -0000	1.1.1.1.2.1
@@ -93,6 +93,11 @@
 	struct acpi_pointer             *address);
 
 acpi_status
+acpi_os_predefined_override (
+	const struct acpi_predefined_names *init_val,
+	acpi_string                     *new_val);
+
+acpi_status
 acpi_os_table_override (
 	struct acpi_table_header        *existing_table,
 	struct acpi_table_header        **new_table);



Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
