From: Jon TURNEY <jon-GrJqePx9RPPAJUdA+FbntA@public.gmane.org>
Subject: acpi_scan_rsdp() in arch/i386/kernel/acpi/boot.c
Date: Thu, 19 Feb 2004 22:11:03 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40353477.6040405@dronecode.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020901020005020507090609"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: jon-GrJqePx9RPPAJUdA+FbntA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020901020005020507090609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The implementation of acpi_scan_rsdp() in linux 2.6.3 does not correctly
locate the RSDP on an Acer TravelMate C100 with BIOS versions R01-A4F or
R01-A4K

BIOS version R01-A4K has an RSDP signature at 0xEC2D0, with zero
checksum and RSDT pointer, and another RSDP signature at 0xFE030,
with a valid checksum and RSDT pointer.


Currently acpi_scan_rsdp() in arch/i386/kernel/acpi/boot.c searches
for a RSDP signature, and returns the first one it finds.  If this
does not have a valid checksum, acpi_table_init() will return an error
(and since 2.6.2, this causes ACPI not to be initialised)


ACPI spec 2.0c, section 5.4.2.1 says:

"OSPM finds the Root System Description Pointer (RSDP) structure by
searching physical memory ranges on 16-byte boundaries for a valid Root
System Description Pointer structure signature and checksum match"

It's at least arguably correct to contine the search until a RSDP
signature and valid checksum is found.


The attached patch against 2.6.3 demonstrates a (not-very-good) way of
doing this.
(It also adds a printk which reports when ACPI is disabled because the
RSDP is invalid)


extract from dmesg without patch:

ACPI: RSDP (v000 Acer                                      ) @ 0x000ec2d0
     >>> ERROR: Invalid checksum

extract from dmesg with patch:

ACPI: RSDP (v000 Acer                                      ) @ 0x000fe030
ACPI: RSDT (v001 Acer   TM100    0x00000001 MSFT 0x00000001) @ 0x0ffe0000
ACPI: FADT (v001 Acer   TM100    0x00000001 MSFT 0x00000001) @ 0x0ffe0054
ACPI: BOOT (v001 Acer   TM100    0x00000001 MSFT 0x00000001) @ 0x0ffe002c
ACPI: DSDT (v001   Acer   AN100  0x00001000 MSFT 0x0100000e) @ 0x000000002




--------------020901020005020507090609
Content-Type: text/plain;
 name="acpi_rsdp_check.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_rsdp_check.diff"

diff -Naur -X exclude linux-2.6.3/arch/i386/kernel/acpi/boot.c linux-2.6.3-acpi-table-fix/arch/i386/kernel/acpi/boot.c
--- linux-2.6.3/arch/i386/kernel/acpi/boot.c	2004-02-19 14:01:00.000000000 +0000
+++ linux-2.6.3-acpi-table-fix/arch/i386/kernel/acpi/boot.c	2004-02-19 20:41:03.000000000 +0000
@@ -341,7 +341,10 @@
 	for (offset = 0; offset < length; offset += 16) {
 		if (strncmp((char *) (start + offset), "RSD PTR ", sig_len))
 			continue;
- 		return (start + offset);
+
+		/* Check for valid checksum */
+		if (acpi_checksum_rsdp((struct acpi_table_rsdp *)(start+offset)) == 0)
+			return (start + offset);
 	}
 
 	return 0;
@@ -388,8 +391,9 @@
 			return __pa(efi.acpi);
 	}
 	/*
-	 * Scan memory looking for the RSDP signature. First search EBDA (low
-	 * memory) paragraphs and then search upper memory (E0000-FFFFF).
+	 * Scan memory looking for the RSDP signature and valid checksum.
+	 * First search EBDA (low memory) paragraphs and then search
+	 * upper memory (E0000-FFFFF).
 	 */
 	rsdp_phys = acpi_scan_rsdp (0, 0x400);
 	if (!rsdp_phys)
@@ -437,6 +441,7 @@
 	 */
 	result = acpi_table_init();
 	if (result) {
+		printk(KERN_WARNING PREFIX "Malformed ACPI tables, disabling ACPI support\n");
 		acpi_disabled = 1;
 		return result;
 	}
diff -Naur -X exclude linux-2.6.3/drivers/acpi/tables.c linux-2.6.3-acpi-table-fix/drivers/acpi/tables.c
--- linux-2.6.3/drivers/acpi/tables.c	2004-02-19 14:01:09.000000000 +0000
+++ linux-2.6.3-acpi-table-fix/drivers/acpi/tables.c	2004-02-19 16:29:47.000000000 +0000
@@ -550,13 +550,24 @@
 	return 0;
 }
 
+int __init
+acpi_checksum_rsdp(struct acpi_table_rsdp *rsdp)
+{
+	int			result = 0;
+
+	if (rsdp->revision < 2)
+		result = acpi_table_compute_checksum(rsdp, sizeof(struct acpi_table_rsdp));
+	else
+		result = acpi_table_compute_checksum(rsdp, ((struct acpi20_table_rsdp *)rsdp)->length);
+
+        return result;
+}
 
 int __init
 acpi_table_init (void)
 {
 	struct acpi_table_rsdp	*rsdp = NULL;
 	unsigned long		rsdp_phys = 0;
-	int			result = 0;
 
 	/* Locate and map the Root System Description Table (RSDP) */
 
@@ -575,12 +586,7 @@
 	printk(KERN_INFO PREFIX "RSDP (v%3.3d %6.6s                                    ) @ 0x%p\n",
 		rsdp->revision, rsdp->oem_id, (void *) rsdp_phys);
 
-	if (rsdp->revision < 2)
-		result = acpi_table_compute_checksum(rsdp, sizeof(struct acpi_table_rsdp));
-	else
-		result = acpi_table_compute_checksum(rsdp, ((struct acpi20_table_rsdp *)rsdp)->length);
-
-	if (result) {
+	if (acpi_checksum_rsdp(rsdp)) {
 		printk(KERN_WARNING "  >>> ERROR: Invalid checksum\n");
 		return -ENODEV;
 	}
diff -Naur -X exclude linux-2.6.3/include/linux/acpi.h linux-2.6.3-acpi-table-fix/include/linux/acpi.h
--- linux-2.6.3/include/linux/acpi.h	2004-02-19 14:01:40.000000000 +0000
+++ linux-2.6.3-acpi-table-fix/include/linux/acpi.h	2004-02-19 18:13:11.000000000 +0000
@@ -349,6 +349,7 @@
 
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 unsigned long acpi_find_rsdp (void);
+int acpi_checksum_rsdp(struct acpi_table_rsdp *rsdp);
 int acpi_boot_init (void);
 int acpi_numa_init (void);
 




--------------020901020005020507090609--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
