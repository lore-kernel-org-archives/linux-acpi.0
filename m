From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>
Subject: Re: ACPI + IO-APIC power off by button problems
Date: 06 Mar 2003 11:12:05 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046949157.1869.6.camel@darkstar.portugal>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10440E41B@cceexc19.americas.cpqcorp.net>
	<3E6286C3.1050504@tin.it>  <20030303105554.GA12170@clara.net>
	<1046904893.1505.23.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-I5KGcjFa+2El6CXpsl91"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1046904893.1505.23.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>, AnonimoVeneziano <voloterreno-nc/lrvXPQ4s@public.gmane.org>, "Cagle, John          (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-I5KGcjFa+2El6CXpsl91
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

and the patch that I made.
--=20
S=E9rgioMB
email: sbasto-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me all.


--=-I5KGcjFa+2El6CXpsl91
Content-Disposition: attachment; filename=acpi_pressario7xx.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=acpi_pressario7xx.diff; charset=ISO-8859-1

--- arch/i386/kernel/pci-pc.c.orig	Sun Nov 17 23:40:17 2002
+++ arch/i386/kernel/pci-pc.c	Sun Nov 17 23:40:50 2002
@@ -1437,9 +1437,9 @@
 #endif
 	if (!pci_using_acpi_prt) {
 		pci_root_bus =3D pcibios_scan_root(0);
-		pcibios_irq_init();
-		pcibios_fixup_peer_bridges();
-		pcibios_fixup_irqs();
+/* 		pcibios_irq_init(); */
+/* 		pcibios_fixup_peer_bridges(); */
+/* 		pcibios_fixup_irqs(); */
 	}
 	if (clustered_apic_mode && (numnodes > 1)) {
 		for (quad =3D 1; quad < numnodes; ++quad) {

--=-I5KGcjFa+2El6CXpsl91--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
