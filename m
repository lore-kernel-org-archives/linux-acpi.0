From: Andy Grover <agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org>
Subject: [PATCH] Fix ACPI IRQ level weirdness
Date: Thu, 26 Sep 2002 14:17:08 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0209261409380.28213-100000@dexter.groveronline.com>
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
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Could you please give this patch a go, and if it works, please apply?

This patch aborts the setting of the ACPI interrupt's level and trigger to
what we think it should be if there is an interrupt source override for
it.

Regards -- Andy

===== arch/i386/kernel/mpparse.c 1.20 vs edited =====
--- 1.20/arch/i386/kernel/mpparse.c	Thu Sep 19 18:14:32 2002
+++ edited/arch/i386/kernel/mpparse.c	Thu Sep 26 14:04:03 2002
@@ -1019,10 +1019,39 @@
 
 /* Ensure the ACPI SCI interrupt level is active low, edge-triggered */
 
+extern FADT_DESCRIPTOR acpi_fadt;
+
 void __init mp_config_ioapic_for_sci(int irq)
 {
 	int ioapic;
 	int ioapic_pin;
+	struct acpi_table_madt *madt;
+	struct acpi_table_int_src_ovr *entry = NULL;
+	void *madt_end;
+	acpi_status status;
+
+	/*
+	 * Ensure that if there is an interrupt source override entry
+	 * for the ACPI SCI, we leave it as is. Unfortunately this involves
+	 * walking the MADT again.
+	 */
+	status = acpi_get_firmware_table("APIC", 1, ACPI_LOGICAL_ADDRESSING,
+		(acpi_table_header **) &madt);
+	if (ACPI_SUCCESS(status)) {
+		madt_end = madt + madt->header.length;
+
+		entry = (struct acpi_table_int_src_ovr *)
+                ((unsigned long) madt + sizeof(struct acpi_table_madt));
+
+		while ((void *) entry < madt_end) {
+                	if (entry->header.type == ACPI_MADT_INT_SRC_OVR &&
+			    acpi_fadt.sci_int == entry->global_irq)
+                		return;
+
+                	entry = (struct acpi_table_int_src_ovr *)
+                	        ((unsigned long) entry + entry->header.length);
+        	}
+	}
 
 	ioapic = mp_find_ioapic(irq);
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
