From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Please, please help me enable a serial port.
Date: Thu, 27 Nov 2003 17:15:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031127161544.GO7374@poupinou.org>
References: <10686.192.176.33.6.1069948970.squirrel@firewall.isacson.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <10686.192.176.33.6.1069948970.squirrel-v+aXH1h/sVyADFAv7lKxfSLkJAjfWD+zmbswZGvKH74@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Isacson <alexander-O4oeKNg1Q5OZuzBka8ofvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 27, 2003 at 05:02:50PM +0100, Alexander Isacson wrote:
> Thank you for taking your time to help me. I really appreciate it.
> 
> The port is an internal serial port that recieves signals from a
> "pen"-pointing device. The problem is that the serial port is not active
> on boot-up but has to be enabled through ACPI. There is a XFree driver
> that works with the pen as soon as the signals from the device are sent to
> /dev/ttyS0.
> 
> I've had the pen up and running under kernel 2.4 but I was forced to
> switch to 2.6 to get my WLAN working. All I need to do is enable the
> serial port and I should be good to go.
> 
> Thanks again for you help.

No problem.

Try following patch.

You have though to build with something like this:
make -C /home/ducrot/linux/linux-2.6.0-test9 SUBDIRS=`pwd` modules

That will bulid the module, then

make -C /home/ducrot/linux/linux-2.6.0-test9 SUBDIRS=`pwd` modules_install

for installation purpose.
You can make a script to wrap the make(s), also.  Left as exercise ;)

(you have to change the /home/ducrot/linux/linux-2.6.0-test9
to the path of you kernel source, of course).

I will look probably when I found time to add something in ACPI system
instead of that little hack (but well, that is low priority though).


--- fpi2002-0.1/Makefile	2003/11/27 15:56:00	1.1
+++ fpi2002-0.1/Makefile	2003/11/27 16:05:26
@@ -1,14 +1 @@
-LINUX=/usr/src/linux
-LINUX_HEADERS=$(LINUX)/include
-MODDIR := /lib/modules/2.4.20/kernel
-
-MODFLAGS := -D__KERNEL__ -DMODULE -fomit-frame-pointer -I/lib/modules/2.4.20/build/include -I/usr/src/linux-2.4/include
-OPTFLAGS := -O2
-
-fpi2002.o: fpi2002.c
-	$(CC) $(OPTFLAGS) $(MODFLAGS) -c $< -o $@
-
-install: fpi2002.o
-	cp fpi2002.o $(MODDIR)/fpi2002.o
-	depmod -a
-
+obj-m   :=      fpi2002.o
--- fpi2002-0.1/fpi2002.c	2003/11/27 15:56:00	1.1
+++ fpi2002-0.1/fpi2002.c	2003/11/27 16:06:26
@@ -19,12 +19,6 @@
 #include <linux/pci.h>
 #include <linux/fs.h>       /* The character device 
                              * definitions are here */
-#include <linux/wrapper.h>  /* A wrapper which does 
-                             * next to nothing at
-                             * at present, but may 
-                             * help for compatibility
-                             * with future versions 
-                             * of Linux */
 
 const unsigned short confindex=0x3F0,confdata=0x3F1;
 const unsigned char spcidx=0xEE;
@@ -40,10 +34,13 @@
   struct pci_dev *pcidev = NULL;
   unsigned char confval,val;
   unsigned char local0, local1;
+  
   /* See if we have a via chip */
   pcidev = pci_find_device (PCI_VENDOR_ID_VIA,PCI_DEVICE_ID_VIA_82C686,NULL);
   if (pcidev) {
-    cli();
+    unsigned long flags;
+
+    local_irq_save(flags);
     /* start config ACPI ENCG */
     pci_read_config_byte(pcidev,0x85,&confval);
     confval |= 0x2;
@@ -76,7 +73,7 @@
     confval &= 0xfd;
     pci_write_config_byte (pcidev, 0x85,confval);
 
-    sti();
+    local_irq_restore(flags);
     printk (KERN_INFO "Enabled FPI2002 Interface\n");
   }
   else {
@@ -93,7 +90,9 @@
   unsigned char local0, local1;
   pcidev = pci_find_device (PCI_VENDOR_ID_VIA,PCI_DEVICE_ID_VIA_82C686,NULL);
   if (pcidev) {
-    cli();
+    unsigned long flags;
+
+    local_irq_save(flags);
     /* start config */
     pci_read_config_byte(pcidev,0x85,&confval);
     confval |= 0x2;
@@ -113,7 +112,7 @@
     pci_read_config_byte(pcidev,0x85,&confval);
     confval &= 0xfd;
     pci_write_config_byte (pcidev, 0x85,confval);
-    sti();
+    local_irq_restore(flags);
     printk (KERN_INFO "FPI2002 disabled\n");
   }
 }

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
