From: Hrvoje Habjanic <hrvoje.habjanic-ZeoyiJGIzEM@public.gmane.org>
Subject: [PATCH] acpica-unix-20031002 and -g
Date: Mon, 27 Oct 2003 09:57:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200310270957.11691.hrvoje.habjanic@htnet.hr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_n3Nn/0xRpjlHqbF"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_n3Nn/0xRpjlHqbF
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi!

I've finally found some time to fix this, again.

My patch will make "-g" to work again. But, please note that my knowelage of 
ACPI is wery limited, so this code my be in error.

Anyhow, at least, it corectly dumps DSDT & disassemble it just fine. Again, i 
tried to use tables/* code, without too much tempering in anything else than 
osunixxf.c .

I must admit, i get impression that SSDT tables are still enigma for 
disassembler. Can anybody fix this? Like include it in DSDT? Is that posible?


Hrvoje


p.s. I'm too lazy to run this thru spellchecker, so enjoy! :-)

--Boundary-00=_n3Nn/0xRpjlHqbF
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="acpica-unix-20031002.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acpica-unix-20031002.diff"

diff -Nru acpica-unix-20031002/compiler/aslstubs.c acpica-unix-20031002.new/compiler/aslstubs.c
--- acpica-unix-20031002/compiler/aslstubs.c	2003-10-02 20:47:57.000000000 +0200
+++ acpica-unix-20031002.new/compiler/aslstubs.c	2003-10-24 18:33:42.000000000 +0200
@@ -255,12 +255,16 @@
 }
 
 ACPI_STATUS
-AcpiTbFindTable (
-    char                    *Signature,
-    char                    *OemId,
-    char                    *OemTableId,
-    ACPI_TABLE_HEADER       **TablePtr)
+AcpiNsLoadNamespace (
+    void)
 {
-    return (AE_SUPPORT);
+    return (AE_OK);
 }
 
+ACPI_STATUS
+AcpiNsLoadTable (
+    ACPI_TABLE_DESC         *TableDesc,
+    ACPI_NAMESPACE_NODE     *Node)
+{
+    return (AE_OK);
+}
diff -Nru acpica-unix-20031002/compiler/Makefile acpica-unix-20031002.new/compiler/Makefile
--- acpica-unix-20031002/compiler/Makefile	2003-10-02 20:47:57.000000000 +0200
+++ acpica-unix-20031002.new/compiler/Makefile	2003-10-24 18:33:21.000000000 +0200
@@ -73,6 +73,12 @@
 	../disassembler/dmwalk.c \
 	../tables/tbinstal.c \
 	../tables/tbutils.c \
+	../tables/tbxfroot.c \
+	../tables/tbrsdt.c \
+	../tables/tbget.c \
+	../tables/tbconvrt.c \
+	../tables/tbgetall.c \
+	../tables/tbxface.c \
 	../osunixxf.c
 
 NOMAN=	YES
Binary files acpica-unix-20031002/interpreter/dispatcher/dsinit.o and acpica-unix-20031002.new/interpreter/dispatcher/dsinit.o differ
Binary files acpica-unix-20031002/interpreter/dispatcher/dsmethod.o and acpica-unix-20031002.new/interpreter/dispatcher/dsmethod.o differ
Binary files acpica-unix-20031002/namespace/nsload.o and acpica-unix-20031002.new/namespace/nsload.o differ
diff -Nru acpica-unix-20031002/osunixxf.c acpica-unix-20031002.new/osunixxf.c
--- acpica-unix-20031002/osunixxf.c	2003-10-02 20:48:11.000000000 +0200
+++ acpica-unix-20031002.new/osunixxf.c	2003-10-24 18:54:09.000000000 +0200
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
@@ -155,6 +161,9 @@
 {
     AcpiGbl_OutputFile = stdout;
 
+    AcpiGbl_Memory=open("/dev/mem", O_RDONLY);
+    if(AcpiGbl_Memory==-1)
+        return AE_ERROR;
     return AE_OK;
 }
 
@@ -162,6 +171,9 @@
 ACPI_STATUS
 AcpiOsTerminate (void)
 {
+    if(AcpiGbl_Memory!=-1)
+        close(AcpiGbl_Memory);
+
     return AE_OK;
 }
 
@@ -184,8 +196,11 @@
     UINT32                  Flags,
     ACPI_POINTER           *Address)
 {
+    ACPI_STATUS             Status;
 
-    return (AE_OK);
+    Status = AcpiFindRootPointer(Flags,Address);
+
+    return (Status);
 }
 
 
@@ -238,14 +253,97 @@
     ACPI_TABLE_HEADER       *ExistingTable,
     ACPI_TABLE_HEADER       **NewTable)
 {
+    ACPI_STATUS             Status;
+    static int              i=0,j=0;
+
     if (!ExistingTable || !NewTable)
     {
         return (AE_BAD_PARAMETER);
     }
 
-    /* TODO: Add table-getting code here */
+    /* Why static variables?
+     *
+     * Well, as i explained before, all Acpi* functions rely on this AcpiOS* funcions
+     * for overriding purposes. So, to avoid circular calling, only FIRST caller gets in
+     * (that is from iasl) and other calls get NULL.
+     *
+     * 'i' has simple function - to prevent recursive calling. When everything is done with one call
+     * 'i' gets decremented so next call from iasl gets thru.
+     *
+     * 'j' is more complicated. It's like init procedure - in there all global variables get initialized.
+     *
+     * AGAIN, all this could be done with fairly simple copy/paste. But in this way, there is fewer lines
+     * needed here ;-)
+     *
+     * AND one small note: Why AcpiLoadTables does not set up AcpiGbl_RSDP?
+     */
+
+    if(i==0)
+    {
+        i++;
+
+        if(j==0)
+        {
+            j++;
+            Status = AcpiLoadTables();
+            if(ACPI_FAILURE (Status))
+                return(Status);
+        }
+
+        Status = AE_NOT_FOUND;
+
+        if(!strncmp(ExistingTable->Signature,"RSDT",4))
+        {
+            static ACPI_TABLE_DESC RsdtInfo;
+            ACPI_POINTER Tmp;
+
+            /* this is needed to get AcpiGbl_RSDP set up */
+            AcpiTbFindTable("PERO","\0","\0",NewTable);
+
+            /* this is ugly - is there a better way? */
+            AcpiTbGetRsdtAddress (&Tmp);
+            AcpiTbGetTable (&Tmp, &RsdtInfo);
+            *NewTable = RsdtInfo.Pointer;
+            Status = AE_OK;
+        }
+
+        if(!strncmp(ExistingTable->Signature,"FACP",4))
+        {
+            *NewTable = AcpiGbl_FADT;
+            Status = AE_OK;
+        }
+
+        if(!strncmp(ExistingTable->Signature,"FACS",4))
+        {
+            *NewTable = AcpiGbl_FACS;
+            Status = AE_OK;
+        }
+
+        if(!strncmp(ExistingTable->Signature,"DSDT",4))
+        {
+            *NewTable = AcpiGbl_DSDT;
+            Status = AE_OK;
+        }
+
+        if(!strncmp(ExistingTable->Signature,"SSDT",4))
+        {
+            ACPI_TABLE_HEADER *my_head;
+            static int k=1;
+            Status = AcpiGetFirmwareTable(ExistingTable->Signature,k,ACPI_LOGICAL_ADDRESSING,&my_head);
+            *NewTable = my_head;
+            k++;
+        }
+
+        if(ACPI_FAILURE (Status))
+            *NewTable = NULL;
+
+        i--;
+        return (AE_OK);
+    }
+
+
     *NewTable = NULL;
-    return (AE_NO_ACPI_TABLES);
+    return (AE_OK);
 }
 
 
@@ -456,7 +554,24 @@
     ACPI_SIZE               length,
     void                    **there)
 {
-    *there = ACPI_TO_POINTER (where);
+    ACPI_PHYSICAL_ADDRESS my_where;
+    int my_page=getpagesize();
+    ACPI_SIZE my_length;
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
+      *there += (long)(where-my_where);
 
     return AE_OK;
 }
@@ -481,6 +596,7 @@
     void                    *where,
     ACPI_SIZE               length)
 {
+    munmap(where,length);
 
     return;
 }

--Boundary-00=_n3Nn/0xRpjlHqbF--



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
