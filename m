From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI + IO-APIC power off by button problems
Date: Thu, 6 Mar 2003 14:22:27 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96CD2@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>, AnonimoVeneziano <voloterreno-nc/lrvXPQ4s@public.gmane.org>, "Cagle, John         \"\"(ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--- arch/i386/kernel/pci-pc.c.orig	Sun Nov 17 23:40:17 2002
+++ arch/i386/kernel/pci-pc.c	Sun Nov 17 23:40:50 2002
@@ -1437,9 +1437,9 @@
 #endif
 	if (!pci_using_acpi_prt) {
 		pci_root_bus = pcibios_scan_root(0);
-		pcibios_irq_init();
-		pcibios_fixup_peer_bridges();
-		pcibios_fixup_irqs();
+/* 		pcibios_irq_init(); */
+/* 		pcibios_fixup_peer_bridges(); */
+/* 		pcibios_fixup_irqs(); */
 	}
 	if (clustered_apic_mode && (numnodes > 1)) {
 		for (quad = 1; quad < numnodes; ++quad) {


Huh? You should never be executing the code in this conditional anyways, if
ACPI is working properly.

Am I missing something?

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
