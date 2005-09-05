From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: fix IO Macro/Namestring name clash in iasl compiler
Date: Mon, 05 Sep 2005 16:54:43 +0200
Message-ID: <431C5C33.4060606@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I got a DSDT that uses IO as an OperationRegion/Field definition.
As this seems to be working with the M$ compiler, it does not with the Intel.

This fixes/workarounds the problem (Thanks to Michael Matz for helping me to find a fix):
DSDT to test: http://www.renninger.de/acpi/dsdt.dsl

--- acpica-unix-20050624/compiler/aslcompiler.y.orig    2005-09-06 16:46:21.000000000 +0200
+++ acpica-unix-20050624/compiler/aslcompiler.y 2005-09-06 15:40:37.000000000 +0200
@@ -2951,6 +2951,7 @@
  NameString
      : NameSeg                       {}
      | PARSEOP_NAMESTRING            {$$ = TrCreateValuedLeafNode (PARSEOP_NAMESTRING, (ACPI_NATIVE_INT) AslCompilerlval.s);}
+    | PARSEOP_IO                    {$$ = TrCreateValuedLeafNode (PARSEOP_IO, (ACPI_NATIVE_INT) "IO");}
      ;

  NameSeg

     Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
