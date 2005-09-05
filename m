From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: pmtools - acpiexec
Date: Mon, 05 Sep 2005 18:30:43 +0200
Message-ID: <431C72B3.6090008@suse.de>
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

I recently played with acpiexec to debug a DSDT.

This seems to be a very useful tool to debug/execute DSDTs outside the kernel?
Is it supposed to work?

The first Hunk of this patch makes it compile/link again.

It came out that the AcpiGbl_RootNode was not allocated.
I tried it with the second Hunk, but it seems as if this Node has
to be created in some special way, as parsing of the DSDT segfaults
when it tries to find the parent of the (global root?) node.

Thanks,

      Thomas
---------------------------------------------
diff -ru tmp/pmtools/acpica-unix-20050624/tools/acpiexec/aemain.c /home/trenn/pmtools/acpica-unix-20050624/tools/acpiexec/aemain.c
--- tmp/pmtools/acpica-unix-20050624/tools/acpiexec/aemain.c    2005-06-24 23:31:40.000000000 +0200
+++ /home/trenn/pmtools/acpica-unix-20050624/tools/acpiexec/aemain.c    2005-09-05 01:41:23.000000000 +0200
@@ -308,6 +308,8 @@

      /* Get the command line options */

+    AcpiUtInitGlobals ();
+
      while ((j = AcpiGetopt (argc, argv, "?b^dgio:svx:")) != EOF) switch(j)
      {
      case 'b':
@@ -384,6 +386,9 @@
          }

          AeBuildLocalTables (Table);
+   if (AcpiGbl_RootNode == NULL)
+       AcpiGbl_RootNode = AcpiNsCreateNode (0);
+
          Status = AeInstallTables ();
          if (ACPI_FAILURE (Status))
          {


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
