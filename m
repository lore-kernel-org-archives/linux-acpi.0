From: Thomas Renninger <trenn@suse.de>
Subject: RE: DSDT on Averatec 1050
Date: Fri, 19 May 2006 15:02:46 +0200
Message-ID: <1148043766.9319.419.camel@queen.suse.de>
References: <B28E9812BAF6E2498B7EC5C427F293A44245D8@orsmsx415.amr.corp.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-BbExzFfuTiZX4F1QvlR7"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:11481 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751100AbWESNAM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 May 2006 09:00:12 -0400
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A44245D8@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Paul Wagner <paul_spam@gmx.at>, linux-acpi@vger.kernel.org


--=-BbExzFfuTiZX4F1QvlR7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-05-11 at 10:56 -0700, Moore, Robert wrote:
> May have gotten lost in the noise, please send to me.

Attached are two patches:
 1) Fixes compiler nameclash if IO keyword is used as field declaration
 2) If (generic, dsdt.dsl) output file is already created with
insufficient
    privileges to the current user, iasl -d dsdt segfaults.
    This patch makes iasl to exit gracefully.

      Thomas


--=-BbExzFfuTiZX4F1QvlR7
Content-Disposition: attachment; filename=fix_IO_nameclash.patch
Content-Type: text/x-patch; name=fix_IO_nameclash.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Fixes compiler nameclash if IO keyword is used as field declaration

Signed-off-by: Thomas Renninger <trenn@suse.de>

--- acpica-unix-20050624/compiler/aslcompiler.y.orig	2005-09-06 16:46:21.000000000 +0200
+++ acpica-unix-20050624/compiler/aslcompiler.y	2005-09-06 15:40:37.000000000 +0200
@@ -2951,6 +2951,7 @@
 NameString
     : NameSeg                       {}
     | PARSEOP_NAMESTRING            {$$ = TrCreateValuedLeafNode (PARSEOP_NAMESTRING, (ACPI_NATIVE_INT) AslCompilerlval.s);}
+    | PARSEOP_IO                    {$$ = TrCreateValuedLeafNode (PARSEOP_IO, (ACPI_NATIVE_INT) "IO");}
     ;
 
 NameSeg

--=-BbExzFfuTiZX4F1QvlR7
Content-Disposition: attachment; filename=iasl_invalid_output_file.patch
Content-Type: text/x-patch; name=iasl_invalid_output_file.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

If (generic, dsdt.dsl) output file is already created with insufficient
privileges to the current user, iasl -d xy segfaults.
This patch fixes that.
Reference: https://bugzilla.novell.com/show_bug.cgi?id=152112

Signed-off-by: Thomas Renninger <trenn@suse.de>

 acpica-unix-20060127/common/adisasm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: acpica-unix-20060127/common/adisasm.c
===================================================================
--- acpica-unix-20060127/common/adisasm.c
+++ acpica-unix-20060127/common/adisasm.c
@@ -125,6 +125,7 @@
 #include "acapps.h"
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <time.h>
 
@@ -549,9 +550,8 @@ AdAmlDisassemble (
         File = fopen (DisasmFilename, "w+");
         if (!File)
         {
-            fprintf (stderr, "Could not open output file\n");
-            Status = AE_ERROR;
-            goto Cleanup;
+            fprintf (stderr, "Could not open output file %s\n", DisasmFilename);
+	    exit (EXIT_FAILURE);
         }
 
         AcpiOsRedirectOutput (File);

--=-BbExzFfuTiZX4F1QvlR7--

