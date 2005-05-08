From: Dean Townsley <dean-5NrKhQnM7FRWk0Htik3J/w@public.gmane.org>
Subject: Re: Something seems to be wrong with my RSDP
Date: Sun, 08 May 2005 17:59:14 -0500
Message-ID: <E1DUujy-0003sP-Om@variable.uchicago.edu>
References: <427CB470.4060700@heiko-gerstung.de>
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
To: Heiko Gerstung <hg-Zwoj8m1Se4ooLuGpnUaJU7NAH6kLmebB@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Heiko,

I'm glad you've worked on this.  I've never had a chance to fix up the
dsdt table.  I was able to get the kernel to ignore the RSDP checksum
error with patch below.

I did this because the 2.4.20 + some old acpi patch that has been
working for years on the c100 always had this "Invalid checksum"
error, but worked anyway.  Comparing the code, the old patch didn't
disable acpi if the RSDP table failed to parse properly, it just
skipped some stuff and went on.  I don't know if this is right (or a
really bad idea for that matter) but at least it gets it to load and
use the DSDT.

Could you send me the DSDT you've fixed so I could try it out too :)

Thanks,
-Dean


diff -ur linux-2.6.11-orig/arch/i386/kernel/acpi/boot.c linux-2.6.11/arch/i386/kernel/acpi/boot.c
--- linux-2.6.11-orig/arch/i386/kernel/acpi/boot.c	Wed Mar  2 01:38:25 2005
+++ linux-2.6.11/arch/i386/kernel/acpi/boot.c	Sun May  8 17:01:44 2005
@@ -849,7 +849,7 @@
 	 */
 	error = acpi_table_init();
 	if (error) {
-		disable_acpi();
+		/* disable_acpi(); */ 
 		return error;
 	}
 
diff -ur linux-2.6.11-orig/arch/i386/kernel/setup.c linux-2.6.11/arch/i386/kernel/setup.c
--- linux-2.6.11-orig/arch/i386/kernel/setup.c	Wed Mar  2 01:38:08 2005
+++ linux-2.6.11/arch/i386/kernel/setup.c	Sun May  8 17:04:32 2005
@@ -1461,8 +1461,8 @@
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
 	 */
-	acpi_boot_table_init();
-	acpi_boot_init();
+	if (acpi_boot_table_init()==0)
+		acpi_boot_init();
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (smp_found_config)


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
