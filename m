From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: [PATCH] Acpica-20030619 and "-g" option
Date: Tue, 1 Jul 2003 12:34:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307011234.20470.hrvoje.habjanic@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sOWA/YtS5tQkmwo"
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


--Boundary-00=_sOWA/YtS5tQkmwo
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Well, hello again ... ;-)


After few hours of grep/vi/grep , i've finally made this to work (that is, 
./iasl -g to dump DSDT tables).

Looking at it now, it seems very easy - mmap-ing memory was the most trickier 
part because of page aligement ....

Patch is attached ... it will work on x86 (32bit) - for others - i'm not 
shure.

And another thing. It currently dumps ONLY DSDT table, but, i think it could 
be nice to dump all tables ... maybe later.


Hrvoje


--Boundary-00=_sOWA/YtS5tQkmwo
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="acpica-unix-20030619.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acpica-unix-20030619.diff"

diff -Nru acpica-unix-20030619/common/adisasm.c acpica-unix-20030619.ok/common/adisasm.c
--- acpica-unix-20030619/common/adisasm.c	2003-06-20 02:30:28.000000000 +0200
+++ acpica-unix-20030619.ok/common/adisasm.c	2003-07-01 12:06:02.000000000 +0200
@@ -123,6 +123,7 @@
 #include "acdispat.h"
 #include "acnamesp.h"
 #include "acapps.h"
+#include "actables.h"
 
 #include <stdio.h>
 #include <string.h>
@@ -865,24 +866,74 @@
     ACPI_TABLE_HEADER       *NewTable;
     UINT32                  NumTables;
     UINT32                  PointerSize;
+    ACPI_POINTER            RsdpAddress;
 
+    ACPI_FUNCTION_TRACE ("AdGetLocalTables");
+    memset(&TableHeader,0,sizeof(ACPI_TABLE_HEADER));
 
-    if (GetAllTables)
+
+    /* Get the RSDP */
+
+    Status = AcpiOsGetRootPointer (ACPI_LOGICAL_ADDRESSING,
+                    &RsdpAddress);
+    if (ACPI_FAILURE (Status))
+    {
+        ACPI_REPORT_ERROR (("AcpiLoadTables: Could not get RSDP, %s\n",
+                        AcpiFormatException (Status)));
+        return_ACPI_STATUS (Status);
+    }
+
+    /* Map and validate the RSDP */
+
+    AcpiGbl_TableFlags = RsdpAddress.PointerType;
+    if(RsdpAddress.Pointer.Logical==NULL)
+    {
+        ACPI_STRNCPY (TableHeader.Signature, "RSDP", 4);
+       	Status = AcpiOsTableOverride (&TableHeader, &NewTable);
+	if (ACPI_FAILURE (Status) || NewTable == NULL)
+	{
+        	ACPI_REPORT_ERROR (("AcpiLoadTables: Could not load RSDP: %s\n",
+                        	AcpiFormatException (Status)));
+        	return_ACPI_STATUS (Status);
+	}
+	RsdpAddress.Pointer.Logical=NewTable;
+    }
+
+    Status = AcpiTbVerifyRsdp (&RsdpAddress);
+    if (ACPI_FAILURE (Status))
+    {
+        ACPI_REPORT_ERROR (("AcpiLoadTables: RSDP Failed validation: %s\n",
+                        AcpiFormatException (Status)));
+        return_ACPI_STATUS (Status);
+    }
+
+    /* Get the RSDT via the RSDP */
+
+    Status = AcpiTbGetTableRsdt ();
+    if (ACPI_FAILURE (Status))
     {
         ACPI_STRNCPY (TableHeader.Signature, "RSDT", 4);
-        AcpiOsTableOverride (&TableHeader, &NewTable);
+       	Status = AcpiOsTableOverride (&TableHeader, &NewTable);
+	if (ACPI_FAILURE (Status) || NewTable == NULL)
+	{
+        	ACPI_REPORT_ERROR (("AcpiLoadTables: Could not load RSDT: %s\n",
+                        	AcpiFormatException (Status)));
+        	return_ACPI_STATUS (Status);
+	}
+    }
 
-#if ACPI_MACHINE_WIDTH != 64
+    /* Now get the tables needed by this subsystem (FADT, DSDT, etc.) */
 
-        if (!ACPI_STRNCMP (NewTable->Signature, "RSDT", 4))
-        {
+    Status = AcpiTbGetRequiredTables ();
+    if (ACPI_FAILURE (Status))
+    {
+
+
+#if ACPI_MACHINE_WIDTH != 64
             PointerSize = sizeof (UINT32);
-        }
-        else
-#endif
-        {
+#else
             PointerSize = sizeof (UINT64);
-        }
+#endif
 
         /*
          * Determine the number of tables pointed to by the RSDT/XSDT.
@@ -890,14 +941,20 @@
          * pointers contained within the RSDT/XSDT.  The size of the pointers
          * is architecture-dependent.
          */
-        NumTables = (NewTable->Length - sizeof (ACPI_TABLE_HEADER)) / PointerSize;
-        AcpiOsPrintf ("There are %d tables defined in the %4.4s\n\n",
-            NumTables, NewTable->Signature);
+	if(NewTable)
+	{
+        	NumTables = (NewTable->Length - sizeof (ACPI_TABLE_HEADER)) / PointerSize;
+        	AcpiOsPrintf ("There are %d tables defined in the %4.4s\n\n",
+        	    NumTables, NewTable->Signature);
+	}
 
         /* Get the FADT */
 
         ACPI_STRNCPY (TableHeader.Signature, "FADT", 4);
-        AcpiOsTableOverride (&TableHeader, &NewTable);
+	Status = AcpiTbFindTable(TableHeader.Signature,"\0","\0",&TableHeader);
+	if (ACPI_FAILURE(Status))
+        	AcpiOsTableOverride (&TableHeader, &NewTable);
+
         if (NewTable)
         {
             AcpiGbl_FADT = (void *) NewTable;
@@ -917,23 +974,26 @@
                 "FACS", AcpiGbl_FADT->Header.OemTableId);
         }
         AcpiOsPrintf ("\n");
-    }
 
     /* Always get the DSDT */
 
     ACPI_STRNCPY (TableHeader.Signature, DSDT_SIG, 4);
-    AcpiOsTableOverride (&TableHeader, &NewTable);
-    if (NewTable)
+    Status = AcpiTbFindTable(TableHeader.Signature,"\0","\0",&TableHeader);
+    if(ACPI_FAILURE(Status))
     {
-        Status = AE_OK;
-        AcpiGbl_DSDT = NewTable;
-        AdWriteTable (AcpiGbl_DSDT, AcpiGbl_DSDT->Length,
-            "DSDT", AcpiGbl_DSDT->OemTableId);
-    }
-    else
-    {
-        fprintf (stderr, "Could not obtain DSDT\n");
-        Status = AE_NO_ACPI_TABLES;
+        AcpiOsTableOverride (&TableHeader, &NewTable);
+        if (NewTable)
+        {
+            Status = AE_OK;
+            AcpiGbl_DSDT = NewTable;
+            AdWriteTable (AcpiGbl_DSDT, AcpiGbl_DSDT->Length,
+                "DSDT", AcpiGbl_DSDT->OemTableId);
+        }
+        else
+        {
+            fprintf (stderr, "Could not obtain DSDT\n");
+            Status = AE_NO_ACPI_TABLES;
+        }
     }
 
     AcpiOsPrintf ("\n");
@@ -950,6 +1010,8 @@
         }
     }
 
+    }
+
 #ifdef _HPET
     AfGetHpet ();
 #endif
diff -Nru acpica-unix-20030619/compiler/aslstubs.c acpica-unix-20030619.ok/compiler/aslstubs.c
--- acpica-unix-20030619/compiler/aslstubs.c	2003-06-20 02:30:32.000000000 +0200
+++ acpica-unix-20030619.ok/compiler/aslstubs.c	2003-06-30 17:48:18.000000000 +0200
@@ -254,13 +254,3 @@
     return (AE_SUPPORT);
 }
 
-ACPI_STATUS
-AcpiTbFindTable (
-    char                    *Signature,
-    char                    *OemId,
-    char                    *OemTableId,
-    ACPI_TABLE_HEADER       **TablePtr)
-{
-    return (AE_SUPPORT);
-}
-
diff -Nru acpica-unix-20030619/compiler/Makefile acpica-unix-20030619.ok/compiler/Makefile
--- acpica-unix-20030619/compiler/Makefile	2003-06-20 02:30:32.000000000 +0200
+++ acpica-unix-20030619.ok/compiler/Makefile	2003-07-01 12:01:50.000000000 +0200
@@ -73,10 +73,15 @@
 	../disassembler/dmwalk.c \
 	../tables/tbinstal.c \
 	../tables/tbutils.c \
+	../tables/tbxfroot.c \
+	../tables/tbget.c \
+	../tables/tbrsdt.c \
+	../tables/tbconvrt.c \
+	../tables/tbgetall.c \
 	../osunixxf.c
 
 NOMAN=	YES
-CFLAGS+= -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../include 
+CFLAGS+= -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../include 
 
 #YACC=	yacc
 YACC=	bison
diff -Nru acpica-unix-20030619/osunixxf.c acpica-unix-20030619.ok/osunixxf.c
--- acpica-unix-20030619/osunixxf.c	2003-06-20 02:30:49.000000000 +0200
+++ acpica-unix-20030619.ok/osunixxf.c	2003-07-01 12:17:31.000000000 +0200
@@ -124,6 +124,12 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include <sys/time.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+
 
 #include "acpi.h"
 #include "amlcode.h"
@@ -136,6 +142,7 @@
 
 extern FILE                    *AcpiGbl_DebugFile;
 FILE                           *AcpiGbl_OutputFile;
+int                            AcpiGbl_Memory=-1;
 
 
 /******************************************************************************
@@ -155,6 +162,10 @@
 {
     AcpiGbl_OutputFile = stdout;
 
+    AcpiGbl_Memory=open("/dev/mem", O_RDONLY);
+    if(AcpiGbl_Memory==-1)
+        return AE_NOT_FOUND;
+
     return AE_OK;
 }
 
@@ -185,6 +196,10 @@
     ACPI_POINTER           *Address)
 {
 
+    if(ACPI_FAILURE (AcpiFindRootPointer(Flags,Address)))
+    {
+	return (AE_NOT_FOUND);
+    }
     return (AE_OK);
 }
 
@@ -455,7 +470,27 @@
     UINT32                  length,
     void                    **there)
 {
-    *there = (void *) (UINT32) where;
+    ACPI_PHYSICAL_ADDRESS my_where;
+    int my_page=getpagesize();
+    UINT32 my_length;
+
+    if(AcpiGbl_Memory==-1)
+        return AE_NOT_FOUND;
+
+    /* find page boundary */
+    my_where=(where/my_page)*my_page;
+    my_length=((length/my_page)+3)*my_page;
+
+    *there = mmap(NULL, my_length, PROT_READ, MAP_PRIVATE,AcpiGbl_Memory, my_where);
+
+    if(*there == MAP_FAILED)
+    {
+        return AE_NOT_FOUND;
+    }
+   /* *there = (void *) (UINT32) where; */
+
+    if(my_where != where )
+      *there += (UINT32)(where-my_where);
 
     return AE_OK;
 }
@@ -481,6 +516,7 @@
     UINT32                  length)
 {
 
+    munmap(where,length);
     return;
 }
 

--Boundary-00=_sOWA/YtS5tQkmwo--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
