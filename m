From: Dean Townsley <dean-5NrKhQnM7FRWk0Htik3J/w@public.gmane.org>
Subject: Patch to update acpi_find_rsdp -- was: Something seems to be wrong with my RSDP
Date: Mon, 09 May 2005 23:48:02 -0500
Message-ID: <E1DVMf4-0004kx-W9@variable.uchicago.edu>
References: <971FCB6690CD0E4898387DBF7552B90E0170B05A@orsmsx403.amr.corp.intel.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   of "Mon, 09 May 2005 13:18:40 PDT." <971FCB6690CD0E4898387DBF7552B90E0170B05A-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

Hi all,

On Mon, 9 May 2005 13:18:40 -0700 "Moore, Robert" wrote:
> acpi_tb_find_rsdp is the up-to-date version. acpi_find_rsdp should be
> removed.
> 
> Acpi_tb_find_rsdp correctly searches the EBDA (Extended BIOS Data Area),
> and I think that acpi_find_rsdp does not.
> 
> Bob

Great!  Below is a patch that I think does a clean update.

It appears that acpi_find_rsdp is different on ia64 (no memory scan),
though both i386 and ia64 call its parent acpi_table_init, so
explicitly removing it doesn't look like it will work.

My patch changes arch/i386/kernel/acpi/boot.c so that acpi_find_rsdp
calls acpi_find_root_pointer, which calls acpi_tb_find_rsdp.  This
seems like the right thing so that i386 will always use the better
scanning code.

I've also preserved the old i386 acpi_find_rsdp in
arch/i386/mach-es7000/es7000plat.c  -- this may be unnecessary, but
not knowing anything about the es7000 I figured I'd play it safe.  (I
think I added the right includes so it will compile.)  I put in a
FIXME note mentioning there is a more general version.

It seems to work on my Travelmate C100, finding the right rsdp and
all.

Please, comments welcome, I just figured I'd make a first stab.

Thanks to all for your hard work!

Cheers,
-Dean

diff -ur linux-2.6.11-orig/arch/i386/kernel/acpi/boot.c linux-2.6.11/arch/i386/kernel/acpi/boot.c
--- linux-2.6.11-orig/arch/i386/kernel/acpi/boot.c	Wed Mar  2 01:38:25 2005
+++ linux-2.6.11/arch/i386/kernel/acpi/boot.c	Mon May  9 21:59:24 2005
@@ -506,27 +506,6 @@
 EXPORT_SYMBOL(acpi_unmap_lsapic);
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
-static unsigned long __init
-acpi_scan_rsdp (
-	unsigned long		start,
-	unsigned long		length)
-{
-	unsigned long		offset = 0;
-	unsigned long		sig_len = sizeof("RSD PTR ") - 1;
-
-	/*
-	 * Scan all 16-byte boundaries of the physical memory region for the
-	 * RSDP signature.
-	 */
-	for (offset = 0; offset < length; offset += 16) {
-		if (strncmp((char *) (start + offset), "RSD PTR ", sig_len))
-			continue;
-		return (start + offset);
-	}
-
-	return 0;
-}
-
 static int __init acpi_parse_sbf(unsigned long phys_addr, unsigned long size)
 {
 	struct acpi_table_sbf *sb;
@@ -630,21 +609,11 @@
 unsigned long __init
 acpi_find_rsdp (void)
 {
+	struct acpi_pointer	addr;
 	unsigned long		rsdp_phys = 0;
 
-	if (efi_enabled) {
-		if (efi.acpi20)
-			return __pa(efi.acpi20);
-		else if (efi.acpi)
-			return __pa(efi.acpi);
-	}
-	/*
-	 * Scan memory looking for the RSDP signature. First search EBDA (low
-	 * memory) paragraphs and then search upper memory (E0000-FFFFF).
-	 */
-	rsdp_phys = acpi_scan_rsdp (0, 0x400);
-	if (!rsdp_phys)
-		rsdp_phys = acpi_scan_rsdp (0xE0000, 0xFFFFF);
+	if (!ACPI_FAILURE(acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING,&addr)))
+		rsdp_phys=addr.pointer.physical;
 
 	return rsdp_phys;
 }
diff -ur linux-2.6.11-orig/arch/i386/mach-es7000/es7000plat.c linux-2.6.11/arch/i386/mach-es7000/es7000plat.c
--- linux-2.6.11-orig/arch/i386/mach-es7000/es7000plat.c	Wed Mar  2 01:38:26 2005
+++ linux-2.6.11/arch/i386/mach-es7000/es7000plat.c	Mon May  9 21:23:15 2005
@@ -35,6 +35,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/efi.h>
 #include <asm/io.h>
 #include <asm/nmi.h>
 #include <asm/smp.h>
@@ -75,6 +76,52 @@
 
 #endif // (CONFIG_X86_IO_APIC) && (CONFIG_ACPI_INTERPRETER || CONFIG_ACPI_BOOT)
 
+
+static unsigned long __init
+es7000_acpi_scan_rsdp (
+	unsigned long		start,
+	unsigned long		length)
+{
+	unsigned long		offset = 0;
+	unsigned long		sig_len = sizeof("RSD PTR ") - 1;
+
+	/*
+	 * Scan all 16-byte boundaries of the physical memory region for the
+	 * RSDP signature.
+	 */
+	for (offset = 0; offset < length; offset += 16) {
+		if (strncmp((char *) (start + offset), "RSD PTR ", sig_len))
+			continue;
+		return (start + offset);
+	}
+
+	return 0;
+}
+
+
+unsigned long __init
+es7000_acpi_find_rsdp (void)
+{
+	unsigned long		rsdp_phys = 0;
+
+	if (efi_enabled) {
+		if (efi.acpi20)
+			return __pa(efi.acpi20);
+		else if (efi.acpi)
+			return __pa(efi.acpi);
+	}
+	/*
+	 * Scan memory looking for the RSDP signature. First search EBDA (low
+	 * memory) paragraphs and then search upper memory (E0000-FFFFF).
+	 */
+	rsdp_phys = es7000_acpi_scan_rsdp (0, 0x400);
+	if (!rsdp_phys)
+		rsdp_phys = es7000_acpi_scan_rsdp (0xE0000, 0xFFFFF);
+
+	return rsdp_phys;
+}
+
+
 /*
  * Parse the OEM Table
  */
@@ -153,7 +200,8 @@
 	int				i;
 	struct acpi_table_sdt		sdt;
 
-	rsdp_phys = acpi_find_rsdp();
+	 /* FIXME -- can we use the general acpi_find_rsdp() ? */
+	rsdp_phys = es7000_acpi_find_rsdp();
 	rsdp = __va(rsdp_phys);
 	if (rsdp->rsdt_address) {
 		struct acpi_table_rsdt	*mapped_rsdt = NULL;


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
