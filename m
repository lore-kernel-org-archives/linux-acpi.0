From: Chris McDermott <lcm-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] System reset using ACPI FADT reset mechanism
Date: Thu, 14 Oct 2004 13:26:24 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041014202624.GA6302@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The ACPI specification defines a system reset mechanism via registers in
the FADT.  This would be required for legacy-free systems (e.g., systems
with no 8042 keyboard controller) that do not support EFI. I happen to be 
working on such a system. This patch implements the ACPI reset mechanism 
for i386 and x86_64 architectures. With this patch the ACPI reset mechanism
will be used if it is supported in the FADT and if there is no 8042 keyboard
controller present (according to the FADT). Otherwise, the _default_ system
reset mechanism is still used. 

There is currently one caveat with the patch. The x86_64 reboot code provides
a 'reboot=' boot option. I added an ACPI option to the existing framework.
The caveat is that if a 'reboot=' option is specified AND the platform 
supports the ACPI reset mechanism (as described above), ACPI reset will
override the boot option. This is minor, but should probably be fixed since
someone went to the trouble to add the 'reboot=' boot option in the first
place. I'm working on correcting this.

This patch is against 2.6.9-rc4-mm1.

thanks,

Chris McDermott
lcm-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org


Signed-off-by: Chris McDermott <lcm-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

diff -urN a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
--- a/arch/i386/kernel/reboot.c	2004-09-22 19:21:17.000000000 -0700
+++ b/arch/i386/kernel/reboot.c	2004-09-23 09:32:31.409163168 -0700
@@ -22,6 +22,9 @@
 static int reboot_mode;
 int reboot_thru_bios;
 
+void (*machine_reset)(void);
+EXPORT_SYMBOL(machine_reset);
+
 #ifdef CONFIG_SMP
 static int reboot_cpu = -1;
 /* shamelessly grabbed from lib/vsprintf.c for readability */
@@ -320,6 +323,10 @@
 		}
 		/* rebooting needs to touch the page at absolute addr 0 */
 		*((unsigned short *)__va(0x472)) = reboot_mode;
+
+		if (machine_reset)
+			(*machine_reset)();
+
 		for (;;) {
 			mach_reboot();
 			/* That didn't work - force a triple fault.. */
diff -urN a/arch/x86_64/kernel/reboot.c b/arch/x86_64/kernel/reboot.c
--- a/arch/x86_64/kernel/reboot.c	2004-09-22 18:45:31.000000000 -0700
+++ b/arch/x86_64/kernel/reboot.c	2004-09-23 09:30:55.385760944 -0700
@@ -21,19 +21,20 @@
 void (*pm_power_off)(void);
 
 static long no_idt[3];
-static enum { 
-	BOOT_BIOS = 'b',
-	BOOT_TRIPLE = 't',
-	BOOT_KBD = 'k'
-} reboot_type = BOOT_KBD;
 static int reboot_mode = 0;
+enum reboot_types reboot_type = BOOT_KBD;
+EXPORT_SYMBOL(reboot_type);
 
-/* reboot=b[ios] | t[riple] | k[bd] [, [w]arm | [c]old]
+void (*machine_reset)(void);
+EXPORT_SYMBOL(machine_reset);
+
+/* reboot=b[ios] | t[riple] | k[bd] [, [w]arm | [c]old] | [a]cpi
    bios	  Use the CPU reboot vector for warm reset
    warm   Don't set the cold reboot flag
    cold   Set the cold reboot flag
    triple Force a triple fault (init)
    kbd    Use the keyboard controller. cold reset (default)
+   acpi   Use the ACPI reset mechanism defined in the FADT
  */ 
 static int __init reboot_setup(char *str)
 {
@@ -50,6 +51,7 @@
 		case 't':
 		case 'b':
 		case 'k':
+		case 'a':
 			reboot_type = *str;
 			break;
 		}
@@ -146,6 +148,13 @@
 	for (;;) {
 		/* Could also try the reset bit in the Hammer NB */
 		switch (reboot_type) { 
+		case BOOT_ACPI:
+			if (machine_reset)
+				(*machine_reset)();
+			else
+				reboot_type = BOOT_KBD;
+			break;
+		
 		case BOOT_BIOS:
 			reboot_warm();
 
diff -urN a/drivers/acpi/bus.c b/drivers/acpi/bus.c
--- a/drivers/acpi/bus.c	2004-09-22 18:45:44.000000000 -0700
+++ b/drivers/acpi/bus.c	2004-09-23 10:10:28.254030136 -0700
@@ -29,6 +29,7 @@
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/proc_fs.h>
+#include <linux/reboot.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
 #endif
@@ -589,6 +590,34 @@
 	return_VALUE(0);
 }
 
+void
+acpi_machine_reset(void)
+{
+	acpi_status status;
+	FADT_DESCRIPTOR *f = &acpi_fadt;
+
+	if (f->reset_register.register_bit_width != 8) {
+		printk(KERN_WARNING PREFIX "invalid reset register bit width: 0x%x\n", f->reset_register.register_bit_width);
+		return_VOID;
+	}
+
+	if (f->reset_register.register_bit_offset != 0) {
+		printk(KERN_WARNING PREFIX "invalid reset register bit offset: 0x%x\n", f->reset_register.register_bit_offset);
+		return_VOID;
+	}
+
+	if ((f->reset_register.address_space_id != ACPI_ADR_SPACE_SYSTEM_IO) &&
+		(f->reset_register.address_space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY) &&
+		(f->reset_register.address_space_id != ACPI_ADR_SPACE_PCI_CONFIG)) {
+		printk(KERN_WARNING PREFIX "invalid reset register address space id: 0x%x\n", f->reset_register.address_space_id);
+		return_VOID;
+	}
+
+	status = acpi_hw_low_level_write(f->reset_register.register_bit_width, f->reset_value, &f->reset_register);
+
+	if (status != AE_OK)
+		printk(KERN_WARNING "ACPI system reset failed 0x%x\n", status);
+}
 
 void __init
 acpi_early_init (void)
@@ -626,6 +655,24 @@
 		goto error0;
 	}
 
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+	/*
+	 * Set up system reset via ACPI if defined in FADT.
+	 */
+	if (acpi_fadt.revision >= 2) {
+		if (acpi_fadt.reset_reg_sup) {
+			printk(KERN_INFO PREFIX "System reset via FADT Reset Register is supported\n");
+			/* if no 8042 KBD controller exists, use ACPI reset */
+			if (!(acpi_fadt.iapc_boot_arch & BAF_8042_KEYBOARD_CONTROLLER)) {
+				machine_reset = acpi_machine_reset;
+#ifdef CONFIG_X86_64
+				reboot_type = BOOT_ACPI;
+#endif
+			}
+		}
+	}
+#endif
+
 #ifdef CONFIG_X86
 	if (!acpi_ioapic) {
 		extern acpi_interrupt_flags acpi_sci_flags;
diff -urN a/drivers/acpi/tables/tbconvrt.c b/drivers/acpi/tables/tbconvrt.c
--- a/drivers/acpi/tables/tbconvrt.c	2004-09-22 18:45:56.000000000 -0700
+++ b/drivers/acpi/tables/tbconvrt.c	2004-09-22 18:47:17.000000000 -0700
@@ -257,10 +257,22 @@
 	local_fadt->cst_cnt = 0;
 
 	/*
-	 * Since there isn't any equivalence in 1.0 and since it highly likely
-	 * that a 1.0 system has legacy support.
+	 * Support for ACPI system reset mechanism was introduced between
+	 * Spec revisions 1.0b and 2.0, for legacy free systems..
 	 */
-	local_fadt->iapc_boot_arch = BAF_LEGACY_DEVICES;
+	if (original_fadt->revision == 2 && original_fadt->length == 0x84) {
+		FADT_DESCRIPTOR *f = (FADT_DESCRIPTOR *)original_fadt;
+
+		acpi_tb_init_generic_address(&local_fadt->reset_register,
+			f->reset_register.register_bit_width, f->reset_register.address);
+		local_fadt->reset_value = f->reset_value;
+	} else {
+		/*
+		 * Otherwise, there isn't any equivalence in 1.0 and it's
+		 * highly likely that a 1.0 system has legacy support.
+	 	 */
+		local_fadt->iapc_boot_arch = BAF_LEGACY_DEVICES;
+	}
 
 	/*
 	 * Convert the V1.0 block addresses to V2.0 GAS structures
diff -urN a/include/linux/reboot.h b/include/linux/reboot.h
--- a/include/linux/reboot.h	2004-09-22 18:46:17.000000000 -0700
+++ b/include/linux/reboot.h	2004-09-22 18:47:26.000000000 -0700
@@ -39,6 +39,13 @@
 
 #include <linux/notifier.h>
 
+extern enum reboot_types {
+	BOOT_BIOS = 'b',
+	BOOT_TRIPLE = 't',
+	BOOT_KBD = 'k',
+	BOOT_ACPI = 'a'
+} reboot_type;
+
 extern int register_reboot_notifier(struct notifier_block *);
 extern int unregister_reboot_notifier(struct notifier_block *);
 
@@ -50,6 +57,7 @@
 extern void machine_restart(char *cmd);
 extern void machine_halt(void);
 extern void machine_power_off(void);
+extern void (*machine_reset)(void);
 
 extern void machine_shutdown(void);
 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
