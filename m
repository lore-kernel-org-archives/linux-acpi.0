From: "Bjoern A. Zeeb" <bzeeb-lists-mt/InyFV0sMN6vK3N8ee0qxOck334EZe@public.gmane.org>
Subject: [bug] endless loop in arch/i386/kernel/mpparse.c
Date: Sun, 29 Sep 2002 21:27:41 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.BSF.4.44.0209292102340.427-100000@e0-0.zab2.int.zabbadoz.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

with

D 1.21 02/09/26 16:01:50-07:00 torvalds-NOXD9LnmIcc+KpMpn4J55tBPR1lH4CV8@public.gmane.org 43 42 00029/00000/01101
P arch/i386/kernel/mpparse.c
C Make the ACPI SCI interrupt get the right polarity
C when it is explicitly overridden in the MADT

you merged in following code where I added a printk:

===== mpparse.c 1.20 vs 1.21 =====
--- 1.20/arch/i386/kernel/mpparse.c     Fri Sep 20 01:14:32 2002
+++ 1.21/arch/i386/kernel/mpparse.c     Thu Sep 26 23:01:50 2002
@@ -1019,10 +1019,39 @@

 /* Ensure the ACPI SCI interrupt level is active low, edge-triggered */

+extern FADT_DESCRIPTOR acpi_fadt;
+
 void __init mp_config_ioapic_for_sci(int irq)
 {
        int ioapic;
        int ioapic_pin;
+       struct acpi_table_madt *madt;
+       struct acpi_table_int_src_ovr *entry = NULL;
+       void *madt_end;
+       acpi_status status;
+
+       /*
+        * Ensure that if there is an interrupt source override entry
+        * for the ACPI SCI, we leave it as is. Unfortunately this involves
+        * walking the MADT again.
+        */
+       status = acpi_get_firmware_table("APIC", 1, ACPI_LOGICAL_ADDRESSING,
+               (acpi_table_header **) &madt);
+       if (ACPI_SUCCESS(status)) {
+               madt_end = madt + madt->header.length;
+
+               entry = (struct acpi_table_int_src_ovr *)
+                ((unsigned long) madt + sizeof(struct acpi_table_madt));
+
+               while ((void *) entry < madt_end) {
			printk("[%s:%s:%d] madt_end=%p, entry=%p\n",
				__FILE__, __func__, __LINE__, madt_end, entry);
+                       if (entry->header.type == ACPI_MADT_INT_SRC_OVR &&
+                           acpi_fadt.sci_int == entry->global_irq)
+                               return;
+
+                       entry = (struct acpi_table_int_src_ovr *)
+                               ((unsigned long) entry + entry->header.length);
+               }
+       }

        ioapic = mp_find_ioapic(irq);
=== end ===

On boot time the kernel "hangs" (log down under).
This problem was reported on lkml without more details (i.e. any
specific code where the kernel "hangs") too.


The point is that the loop for some reason is endless.
Can anybody fix that please ? As this core code and I am not going
to touch it ;-)

simply #if 0ing out the above diff the kernel comes up fine.


--- boot log excerpt ---
...
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20020918
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:......................................................................................................
Table [DSDT] - 309 Objects with 22 Devices 102 Methods 19 Regions
ACPI Namespace successfully loaded at root c03a741c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070dc
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070e4
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070ec
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070f8
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d8807102
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
[mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
...
...
...
--- end ---


If you need further information or testing please let me know.

Thanks i advance.

-- 
Greetings

Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
