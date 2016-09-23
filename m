From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] acpiexec: Move an acpiexec specific purposed new line to acpiexec specific file
Date: Fri, 23 Sep 2016 14:46:15 +0800
Message-ID: <1474613175-23008-1-git-send-email-lv.zheng@intel.com>
References: <20160909161253.30952-1-bp@alien8.de> <20160919101234.r2zfor37m7eq6k6p@pd.tnic>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160919101234.r2zfor37m7eq6k6p@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E. Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, devel@acpica.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> No need, Robert did it already:
> 
> 1d435008fd9e ("Update an info message during table load phase.")

Not exactly what I meant. I meant the following on top of the above
mentioned commit. As the newline is an acpiexec specific logic, it should
be kept in acpiexec, shouldn't be left polluting a common file. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: <linux-acpi@vger.kernel.org>
--
Index: acpica/source/components/tables/tbxfload.c
===================================================================
--- acpica.orig/source/components/tables/tbxfload.c
+++ acpica/source/components/tables/tbxfload.c
@@ -348,11 +348,6 @@ AcpiTbLoadNamespace (
         Status = AE_CTRL_TERMINATE;
     }
 
-#ifdef ACPI_APPLICATION
-    ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT, "\n"));
-#endif
-
-
 UnlockAndExit:
     (void) AcpiUtReleaseMutex (ACPI_MTX_TABLES);
     return_ACPI_STATUS (Status);
Index: acpica/source/tools/acpiexec/aetables.c
===================================================================
--- acpica.orig/source/tools/acpiexec/aetables.c
+++ acpica/source/tools/acpiexec/aetables.c
@@ -625,6 +625,7 @@ AeLoadTables (
 
     Status = AcpiLoadTables ();
     ACPI_CHECK_OK (AcpiLoadTables, Status);
+    ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT, "\n"));
 
     /*
      * Test run-time control method installation. Do it twice to test code
