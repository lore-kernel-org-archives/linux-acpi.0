From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: RE: DSDT in initrd
Date: Tue, 20 May 2003 18:56:59 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0305191725350.9728@dynast.gaugusch.at>
References: <A5974D8E5F98D511BB910002A50A6647054FC40A@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <A5974D8E5F98D511BB910002A50A6647054FC40A-MgY+aF+eRfZviC08c4yzC1DQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On May 19, Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> The concept of a DSDT override is a workaround -- fine for bringup,
> development, hackers, enthusiasts, wizards etc.  But somebody who pays
> money for a production box that runs Linux will buy one that the OSD
> certifies and supports.
Isn't linux the OS that runs on nearly EVERY hardware? Although there is a
lot of power behind the linux movement, we should not become arrogant.
We can't force the industry to support old machines (sometimes not even
new ones).

> So unless the Linux community wants to slide down the slippery slope of
> running any old broken BIOS -- forever -- we should maintain -- indeed
> sharpen -- our ability to reject bad firmware -- and generously apply that
> ability when the OEM goes before an OSD for certification.
Certification is usually expensive (at least one has to do it, I am not
even talking about paying for it). I am NOT always in the position where I
can choose the hardware, and many other people as well.

My patch is configurable (can be turned off via menuconfig), so please
apply it and do us hackers a favor.

kind regards
Markus


--- linux.orig/drivers/acpi/osl.c	2003-05-09 20:08:34.000000000 +0200
+++ linux/drivers/acpi/osl.c	2003-05-09 20:16:37.000000000 +0200
@@ -36,6 +36,8 @@
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>

 #ifdef CONFIG_ACPI_EFI
 #include <linux/efi.h>
@@ -222,14 +224,59 @@
 	return AE_OK;
 }

+
+#ifdef CONFIG_ACPI_INITRD
+unsigned char* get_dsdt_from_initrd(unsigned char *start, unsigned char *end)
+{
+	unsigned char *data;
+	unsigned char signature[] = "INITRDDSDT123DSDT123";
+
+	if (start == NULL)
+		return NULL;
+	printk(KERN_INFO "Looking for DSDT in initrd ...");
+	if (!memcmp(start, "DSDT", 4)) {
+		printk(" found at beginning!\n");
+		return start;
+	}
+	end-=sizeof(signature)+5; /* don't scan above end, signature+\0+DSDT */
+	for (data=start; data < end ; ++data) {
+		if (!memcmp(data, signature, sizeof(signature)-1)) {
+			if (!memcmp(data+sizeof(signature), "DSDT", 4)) {
+				printk(" found (at offset %u)!\n", data+sizeof(signature)-start);
+				return data+sizeof(signature);
+			}
+		}
+	}
+	printk(" not found!\n");
+
+	return NULL;
+}
+#endif
+
+
 acpi_status
 acpi_os_table_override (struct acpi_table_header *existing_table,
 			struct acpi_table_header **new_table)
 {
+#ifdef CONFIG_ACPI_INITRD
+	extern unsigned long initrd_start, initrd_end;
+	unsigned char* new_dsdt=NULL;
+
+#endif
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;

+#ifdef CONFIG_ACPI_INITRD
+	if (strncmp(existing_table->signature, "DSDT", 4) == 0 &&
+		(new_dsdt=get_dsdt_from_initrd((unsigned char*)initrd_start,
+			(unsigned char*)initrd_end)) != NULL)
+		*new_table = (struct acpi_table_header*)new_dsdt;
+	else
+		*new_table = NULL;
+#else
 	*new_table = NULL;
+#endif
+
 	return AE_OK;
 }

--- linux.orig/drivers/acpi/Config.in	2003-05-05 18:44:41.000000000 +0200
+++ linux/drivers/acpi/Config.in	2003-05-05 20:19:06.000000000 +0200
@@ -12,6 +12,10 @@
       bool         'CPU Enumeration Only' CONFIG_ACPI_HT_ONLY
     fi

+    if [ "$CONFIG_BLK_DEV_INITRD" = "y" ]; then
+      bool         'Read DSDT from initrd' CONFIG_ACPI_INITRD
+    fi
+
     if [ "$CONFIG_ACPI_HT_ONLY" = "y" ]; then
       define_bool CONFIG_ACPI_BOOT		y
     else
--- linux.orig/Documentation/Configure.help	2003-05-05 19:51:09.000000000 +0200
+++ linux/Documentation/Configure.help	2003-05-05 20:18:56.000000000 +0200
@@ -18602,6 +18602,14 @@
   handles PnP messages.  All ACPI devices use its services, so using
   them requires saying Y here.

+ACPI DSDT in initrd
+CONFIG_ACPI_INITRD
+	The DSDT (Differentiated System Description Table) often needs to be
+	overridden because of broken BIOS implementations. If you want to use
+	a customized DSDT, just copy it to /boot/initrd (which must be used as
+  initrd, of course). See http://gaugusch.at/kernel.shtml for instructions
+  on using an existing initrd with ACPI. If unsure, say N here.
+
 ACPI System Driver
 CONFIG_ACPI_SYS
   This driver will enable your system to shut down using ACPI, and

-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
