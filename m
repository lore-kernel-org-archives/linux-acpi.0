From: John M Trostel <john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org>
Subject: Overriding DSDT Tables with external files - 2 Methods
Date: Thu, 05 Sep 2002 14:57:05 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031252226.3011.76.camel@jtsdell>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: ACPI-list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

There seem to be 2 closely related methods of overriding the DSDT in a
BIOS with your own files.

My question is... Do they both work? If they do both work, is one
prefered over the other?

***********************************
Method 1 (from http://www.cpqlinux.com/acpi-howto.html and others)

1. get the dsdt.hex file

2. cp -a dsdt.hex to drivers/acpi/tables/acpi_dsdt.c

3. apply  the following patch

--- linux/drivers/acpi/osl.c    Sat Jul 13 16:16:25 2002
+++ linux-2.4.18-xfs-acpi/drivers/acpi/osl.c    Sat Jul 13 14:33:09 2002
@@ -70,6 +70,7 @@
 static OSD_HANDLER acpi_irq_handler = NULL;
 static void *acpi_irq_context = NULL;

+extern unsigned char AmlCode[];

 acpi_status
 acpi_os_initialize(void)
@@ -221,7 +222,10 @@
        if (!existing_table || !new_table)
                return AE_BAD_PARAMETER;

-       *new_table = NULL;
+       if (strncmp(existing_table->signature, "DSDT", 4) == 0)
+               *new_table = (acpi_table_header*)AmlCode;
+       else
+               *new_table = NULL;
        return AE_OK;
 }


***********************************
Method 2 (from Christophe Boyanique) :

1. get the dsdt.hex file

2. copy that file into drivers/acpi

3. patch drivers/acpi/osl.c as follows:

diff -urP drivers/acpi/osl.c /usr/src/linux/drivers/acpi/osl.c
 --- drivers/acpi/osl.c  Mon Jul 29 23:30:42 2002
 +++ /usr/src/linux/drivers/acpi/osl.c   Sat Jul 27 18:32:34 2002
 @@ -71,6 +71,9 @@
  static void *acpi_irq_context = NULL;
 
 
 +#include "dsdt.hex"
 +acpi_table_header *myDST = (acpi_table_header *) AmlCode;
 +
  acpi_status
  acpi_os_initialize(void)
  {
 @@ -221,7 +224,10 @@
         if (!existing_table || !new_table)
                 return AE_BAD_PARAMETER;
 
 -       *new_table = NULL;
 +       if (!strncmp(existing_table->signature, DSDT_SIG, 4))
 +               *new_table = myDST;
 +       else
 +               *new_table = NULL;
         return AE_OK;
  }


-- 
John M. Trostel
Senior Software Engineer
Quantum Corp.
john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
