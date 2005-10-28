From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 4/9] acpi: handle FADT 2.0 xpmtmr address 0 case
Date: Fri, 28 Oct 2005 14:59:50 -0700
Message-ID: <200510282159.j9SLxWrb021613@shell0.pdx.osdl.net>
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Handle FADT 2.0 xpmtmr address 0 case.  The patch makes the pmtmr ioport
detecting align with ACPICA (the comments are copied from ACPICA code).

Signed-off-by: Shaohua Li<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 arch/i386/kernel/acpi/boot.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN arch/i386/kernel/acpi/boot.c~acpi-handle-fadt-20-xpmtmr-address-0-case arch/i386/kernel/acpi/boot.c
--- 25/arch/i386/kernel/acpi/boot.c~acpi-handle-fadt-20-xpmtmr-address-0-case	Fri Oct 28 14:59:07 2005
+++ 25-akpm/arch/i386/kernel/acpi/boot.c	Fri Oct 28 14:59:07 2005
@@ -641,6 +641,13 @@ static int __init acpi_parse_fadt(unsign
 			return 0;
 
 		pmtmr_ioport = fadt->xpm_tmr_blk.address;
+		/*
+		 * "X" fields are optional extensions to the original V1.0
+		 * fields, so we must selectively expand V1.0 fields if the
+		 * corresponding X field is zero.
+	 	 */
+		if (!pmtmr_ioport)
+			pmtmr_ioport = fadt->V1_pm_tmr_blk;
 	} else {
 		/* FADT rev. 1 */
 		pmtmr_ioport = fadt->V1_pm_tmr_blk;
_


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
