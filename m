From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: [PATCH] acpica-20030714 and "-g"
Date: Sun, 20 Jul 2003 19:17:44 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307201917.44668.hrvoje.habjanic@zg.htnet.hr>
References: <F760B14C9561B941B89469F59BA3A847E9701F@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_46sG/xZiy/YXYtL"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E9701F-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_46sG/xZiy/YXYtL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi all!

As you all noticed, "-g" isn't working in latest acpica release. I've managed 
to fix that.

BUT - it can be fixed in two ways:

1. (which i preffer) Using built-in acpi helper functions (tables/* directory)
 - advantages - hopefully, in this way you know what to expect when you 
"unleash" these functions/subs in real kernel on real machine
- disadvantages - everything stays complicated ;-)

2. to copy/paste all important things to osunixxf.c
 - advantages - all important parts in one place
 - disadvantages - code in osunixxf.c and tables/* CAN get out-of-sync, and 
maintaining is more complicated

So, i've decided to go with (1).

Changed files:
common/adisasm.c
compiler/aslstubs.c
compiler/Makefile
osunixxf.c

Changes in adisasm.c are from replacing AcpiOverrideTable*. 

(Andy, i know that it would be "nicer" to put everything in osunixxf.c, but 
use of AcpiOverrideTable is, among other things, causing circular calling. It 
becomes quite complicated to write "clean" code. I think that suggested 
modifications are minimal, and they make disassembler work more like some 
kernel based on this code.)

Still, there is room for improvements, so ....

And another note; currently SSDT tables ONLY get saved, and not disassembled. 
It would be nice to get them disassembled (maybe someone with more knowledge 
of this code/parsing ...)

Hrvoje

p.s. Sorry on bad english... >:-)

--Boundary-00=_46sG/xZiy/YXYtL
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="acpica-unix-20030714.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acpica-unix-20030714.diff"

diff -Nru acpica-unix-20030714/common/adisasm.c acpica-unix-20030714.new/common/adisasm.c
--- acpica-unix-20030714/common/adisasm.c	2003-07-14 22:09:45.000000000 +0200
+++ acpica-unix-20030714.new/common/adisasm.c	2003-07-20 18:52:24.000000000 +0200
@@ -861,33 +861,15 @@
     BOOLEAN                 GetAllTables)
 {
     ACPI_STATUS             Status;
-    ACPI_TABLE_HEADER       TableHeader;
-    ACPI_TABLE_HEADER       *NewTable;
-    UINT32                  NumTables;
-    UINT32                  PointerSize;
+    ACPI_TABLE_DESC         Table;
+    ACPI_TABLE_HEADER       NewTable;
 
 
     if (GetAllTables)
     {
-        ACPI_STRNCPY (TableHeader.Signature, "RSDT", 4);
-        AcpiOsTableOverride (&TableHeader, &NewTable);
-        if (!NewTable)
-        {
-            fprintf (stderr, "Could not obtain RSDT\n");
-            return AE_NO_ACPI_TABLES;
-        }
-
-#if ACPI_MACHINE_WIDTH != 64
-
-        if (!ACPI_STRNCMP (NewTable->Signature, "RSDT", 4))
-        {
-            PointerSize = sizeof (UINT32);
-        }
-        else
-#endif
-        {
-            PointerSize = sizeof (UINT64);
-        }
+        Status = AcpiLoadTables();
+        if (ACPI_FAILURE (Status) != AE_SUPPORT)
+            return Status;
 
         /*
          * Determine the number of tables pointed to by the RSDT/XSDT.
@@ -895,43 +877,29 @@
          * pointers contained within the RSDT/XSDT.  The size of the pointers
          * is architecture-dependent.
          */
-        NumTables = (NewTable->Length - sizeof (ACPI_TABLE_HEADER)) / PointerSize;
-        AcpiOsPrintf ("There are %d tables defined in the %4.4s\n\n",
-            NumTables, NewTable->Signature);
+        AcpiOsPrintf ("There are %d tables defined in the RDST\n\n",AcpiGbl_RsdtTableCount);
 
         /* Get the FADT */
 
-        ACPI_STRNCPY (TableHeader.Signature, "FADT", 4);
-        AcpiOsTableOverride (&TableHeader, &NewTable);
-        if (NewTable)
+        if(AcpiGbl_FADT)
         {
-            AcpiGbl_FADT = (void *) NewTable;
-            AdWriteTable (NewTable, NewTable->Length,
-                "FADT", NewTable->OemTableId);
+            AdWriteTable (&(AcpiGbl_FADT->Header), AcpiGbl_FADT->Header.Length,
+                "FADT", AcpiGbl_FADT->Header.OemTableId);
         }
-        AcpiOsPrintf ("\n");
 
         /* Get the FACS */
 
-        ACPI_STRNCPY (TableHeader.Signature, "FACS", 4);
-        AcpiOsTableOverride (&TableHeader, &NewTable);
-        if (NewTable)
+        if(AcpiGbl_FACS)
         {
-            AcpiGbl_FACS = (void *) NewTable;
-            AdWriteTable (NewTable, AcpiGbl_FACS->Length,
+            AdWriteTable ((void *)AcpiGbl_FACS, AcpiGbl_FACS->Length,
                 "FACS", AcpiGbl_FADT->Header.OemTableId);
         }
-        AcpiOsPrintf ("\n");
     }
 
     /* Always get the DSDT */
 
-    ACPI_STRNCPY (TableHeader.Signature, DSDT_SIG, 4);
-    AcpiOsTableOverride (&TableHeader, &NewTable);
-    if (NewTable)
+    if(AcpiGbl_DSDT)
     {
-        Status = AE_OK;
-        AcpiGbl_DSDT = NewTable;
         AdWriteTable (AcpiGbl_DSDT, AcpiGbl_DSDT->Length,
             "DSDT", AcpiGbl_DSDT->OemTableId);
     }
@@ -945,16 +913,30 @@
 
     /* Get all SSDTs */
 
-    ACPI_STRNCPY (TableHeader.Signature, SSDT_SIG, 4);
-    Status = AcpiOsTableOverride (&TableHeader, &NewTable);
-    if (NewTable)
-    {
-        while (NewTable)
-        {
-            Status = AcpiOsTableOverride (&TableHeader, &NewTable);
+    Table.Pointer = &NewTable;
+    ACPI_STRNCPY (Table.Pointer->Signature, SSDT_SIG, 4);
+    Status = AcpiTbMatchSignature(Table.Pointer->Signature,&Table,ACPI_TABLE_PRIMARY);
+    if(!ACPI_FAILURE (Status))
+    {
+        ACPI_TABLE_LIST *ListHead;
+        ACPI_NATIVE_UINT i;
+        ACPI_TABLE_DESC *TableDesc;
+
+        ListHead = &AcpiGbl_TableLists[Table.Type];
+        if(ListHead->Count)
+        {
+            AcpiOsPrintf ("There are %d SSDT tables defined in the RDST\n\n",ListHead->Count);
+            TableDesc = ListHead->Next;
+            for(i=0; i < ListHead->Count ; i++)
+            {
+                AdWriteTable (TableDesc->Pointer, TableDesc->Length,
+                "SSDT", TableDesc->Pointer->OemTableId);
+                TableDesc = TableDesc->Next;
+            }
         }
     }
 
+
 #ifdef _HPET
     AfGetHpet ();
 #endif
diff -Nru acpica-unix-20030714/compiler/aslstubs.c acpica-unix-20030714.new/compiler/aslstubs.c
--- acpica-unix-20030714/compiler/aslstubs.c	2003-07-14 22:09:48.000000000 +0200
+++ acpica-unix-20030714.new/compiler/aslstubs.c	2003-07-20 18:28:33.000000000 +0200
@@ -255,11 +255,16 @@
 }
 
 ACPI_STATUS
-AcpiTbFindTable (
-    char                    *Signature,
-    char                    *OemId,
-    char                    *OemTableId,
-    ACPI_TABLE_HEADER       **TablePtr)
+AcpiNsLoadNamespace (
+    void)
+{
+    return (AE_SUPPORT);
+}
+
+ACPI_STATUS
+AcpiNsLoadTable (
+    ACPI_TABLE_DESC         *TableDesc,
+    ACPI_NAMESPACE_NODE     *Node)
 {
     return (AE_SUPPORT);
 }
diff -Nru acpica-unix-20030714/compiler/Makefile acpica-unix-20030714.new/compiler/Makefile
--- acpica-unix-20030714/compiler/Makefile	2003-07-14 22:09:48.000000000 +0200
+++ acpica-unix-20030714.new/compiler/Makefile	2003-07-20 18:28:33.000000000 +0200
@@ -73,7 +73,13 @@
 	../disassembler/dmwalk.c \
 	../tables/tbinstal.c \
 	../tables/tbutils.c \
-	../osunixxf.c
+	../osunixxf.c \
+	../tables/tbxfroot.c \
+	../tables/tbrsdt.c \
+	../tables/tbget.c \
+	../tables/tbconvrt.c \
+	../tables/tbxface.c \
+	../tables/tbgetall.c
 
 NOMAN=	YES
 CFLAGS+= -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../include 
diff -Nru acpica-unix-20030714/osunixxf.c acpica-unix-20030714.new/osunixxf.c
--- acpica-unix-20030714/osunixxf.c	2003-07-14 22:10:02.000000000 +0200
+++ acpica-unix-20030714.new/osunixxf.c	2003-07-20 18:28:33.000000000 +0200
@@ -124,11 +124,16 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include <sys/time.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include "acpi.h"
 #include "amlcode.h"
 #include "acparser.h"
 #include "acdebug.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_OS_SERVICES
         ACPI_MODULE_NAME    ("osunixxf")
@@ -136,6 +141,7 @@
 
 extern FILE                    *AcpiGbl_DebugFile;
 FILE                           *AcpiGbl_OutputFile;
+int                            AcpiGbl_Memory=-1;
 
 
 /******************************************************************************
@@ -155,6 +161,10 @@
 {
     AcpiGbl_OutputFile = stdout;
 
+    AcpiGbl_Memory=open("/dev/mem", O_RDONLY);
+    if(AcpiGbl_Memory==-1)
+        return AE_NOT_FOUND;
+
     return AE_OK;
 }
 
@@ -162,6 +172,7 @@
 ACPI_STATUS
 AcpiOsTerminate (void)
 {
+    close(AcpiGbl_Memory);
     return AE_OK;
 }
 
@@ -184,7 +195,11 @@
     UINT32                  Flags,
     ACPI_POINTER           *Address)
 {
+    ACPI_STATUS Status;
 
+    Status = AcpiFindRootPointer( Flags, Address );
+    if(ACPI_FAILURE (Status))
+        return (AE_NOT_FOUND);
     return (AE_OK);
 }
 
@@ -243,9 +258,11 @@
         return (AE_BAD_PARAMETER);
     }
 
-    /* TODO: Add table-getting code here */
     *NewTable = NULL;
-    return (AE_NO_ACPI_TABLES);
+
+//    return (AE_NO_ACPI_TABLES);
+
+    return (AE_OK);
 }
 
 
@@ -456,7 +473,24 @@
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
+        return AE_NOT_FOUND;
+
+    if(my_where != where )
+      *there += (UINT32)(where-my_where);
 
     return AE_OK;
 }
@@ -481,7 +515,7 @@
     void                    *where,
     UINT32                  length)
 {
-
+    munmap(where,length);
     return;
 }
 

--Boundary-00=_46sG/xZiy/YXYtL--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
