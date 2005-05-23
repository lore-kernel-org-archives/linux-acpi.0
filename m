From: Mike Waychison <mikew-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] IO APIC existence check (2.6.11.10)
Date: Mon, 23 May 2005 15:23:12 -0700
Message-ID: <429257D0.3020703@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060809070805090809060600"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This is a multi-part message in MIME format.
--------------060809070805090809060600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

We've come across some boards where the MADT will list IO APICs that 
don't really exist in hardware.

The current 2.6, the kernel will panic in io_apic_get_unique_id because 
it will fail to force set the APIC id.

This following patch adds a quick check when registering IO APICs to 
make sure they exist. We do this by actually checking to see if the data
register loads the version properly and by examining the index register
to see that it was actually modified from 0xff after the io_apic_read.

Signed-off-by: Mike Waychison <mikew-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>


--------------060809070805090809060600
Content-Type: text/plain;
 name="check_io_apic_existance.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="check_io_apic_existance.patch"

--- 2.6/include/asm-i386/io_apic.h	2005-05-23 12:45:51.000000000 -0700
+++ 2.6/include/asm-i386/io_apic.h	2005-05-23 12:45:51.000000000 -0700
@@ -196,6 +196,7 @@ extern int skip_ioapic_setup;
 #define io_apic_assign_pci_irqs (mp_irq_entries && !skip_ioapic_setup && io_apic_irqs)
 
 #ifdef CONFIG_ACPI_BOOT
+extern unsigned char io_apic_read_index (int ioapic);
 extern int io_apic_get_unique_id (int ioapic, int apic_id);
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
--- 2.6/arch/i386/kernel/mpparse.c	2005-05-23 13:12:35.000000000 -0700
+++ 2.6/arch/i386/kernel/mpparse.c	2005-05-23 13:12:35.000000000 -0700
@@ -907,16 +907,34 @@ void __init mp_register_ioapic (
 		return;
 	}
 
-	idx = nr_ioapics++;
+	/*
+	 * Probe the IO APIC. Set up the ioapic structures so we can do reads,
+	 * but delay incrementing nr_ioapics in case the probe fails
+	 */
+	idx = nr_ioapics;
 
 	mp_ioapics[idx].mpc_type = MP_IOAPIC;
 	mp_ioapics[idx].mpc_flags = MPC_APIC_USABLE;
 	mp_ioapics[idx].mpc_apicaddr = address;
 
 	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
-	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
+
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
-	
+	/*
+	 * Probe to see if the io_apic looks good.
+	 * index register should be set as well.
+	 */
+	if (mp_ioapics[idx].mpc_apicver == 0xff) {
+		if (io_apic_read_index(idx) == 0xff) {
+			printk(KERN_ERR "WARNING: Bogus (0x%08x) I/O APIC address"
+				" found in MADT table, skipping!\n", address);
+			return;
+		}
+	}
+	nr_ioapics++;
+
+	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
+
 	/* 
 	 * Build basic GSI lookup table to facilitate gsi->io_apic lookups
 	 * and to prevent reprogramming of IOAPIC pins (PCI GSIs).
--- 2.6/arch/i386/kernel/io_apic.c	2005-05-23 12:48:32.000000000 -0700
+++ 2.6/arch/i386/kernel/io_apic.c	2005-05-23 12:48:32.000000000 -0700
@@ -2459,6 +2459,15 @@ int __init io_apic_get_unique_id (int io
 	return apic_id;
 }
 
+unsigned char __init io_apic_read_index (int ioapic)
+{
+	unsigned long flags;
+	unsigned char index_reg;
+	spin_lock_irqsave(&ioapic_lock, flags);
+	index_reg = *IO_APIC_BASE(ioapic);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+	return index_reg;
+}
 
 int __init io_apic_get_version (int ioapic)
 {

--------------060809070805090809060600--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
