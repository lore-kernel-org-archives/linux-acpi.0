From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: [PATCH] iasl disasm OEM revision fix
Date: Tue, 25 Nov 2003 05:16:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031125051656.A26111@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

The attached patch makes iasl disassembler print the OEM revision as an
unsigned int instead of a signed int. The compiler wasn't happy with the
negative value produced on my laptop...

--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="iasl_oem_rev.patch"

--- acpica-unix-20031029/common/adisasm.c~	2003-10-30 01:44:33.000000000 +0200
+++ acpica-unix-20031029/common/adisasm.c	2003-11-25 04:24:05.000000000 +0200
@@ -597,7 +597,7 @@
     AcpiOsPrintf (" *\n * Disassembly of %s, %s */\n", Filename, ctime (&Timer));
 
     AcpiOsPrintf (
-        "DefinitionBlock (\"%4.4s.aml\", \"%4.4s\", %hd, \"%.6s\", \"%.8s\", %d)\n",
+        "DefinitionBlock (\"%4.4s.aml\", \"%4.4s\", %hd, \"%.6s\", \"%.8s\", %u)\n",
         Table->Signature, Table->Signature, Table->Revision,
         Table->OemId, Table->OemTableId, Table->OemRevision);
 }

--Kj7319i9nmIyA2yE--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
