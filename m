From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Sat, 16 Aug 2008 15:56:48 +1000
Message-ID: <200808161556.48956.rusty@rustcorp.com.au>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au> <200808161347.41253.rusty@rustcorp.com.au> <20080816052552.GA21668@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:44695 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbYHPF4z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Aug 2008 01:56:55 -0400
In-Reply-To: <20080816052552.GA21668@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andi Kleen <ak@linux.intel.com>, Kay Sievers <kay.sievers@vrfy.org>, Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, gregkh <greg@kroah.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Saturday 16 August 2008 15:25:52 Sam Ravnborg wrote:
> On Sat, Aug 16, 2008 at 01:47:40PM +1000, Rusty Russell wrote:
> > (Sam: foo-objs-y would make this neater)
>
> foo-y is even neater and works today.

Ah, missed that.  Thanks Sam!

I had another bug: if both options were off, compile would fail.  Put
everything in acpi.o to fix this.

Rusty.

diff -r 79f0d024aebc drivers/acpi/Makefile
--- a/drivers/acpi/Makefile	Fri Aug 15 11:23:34 2008 +1000
+++ b/drivers/acpi/Makefile	Sat Aug 16 15:55:10 2008 +1000
@@ -21,10 +21,15 @@ obj-$(CONFIG_X86)		+= blacklist.o
 #
 # ACPI Core Subsystem (Interpreter)
 #
-obj-y				+= osl.o utils.o reboot.o\
+obj-y				+= acpi.o \
 				   dispatcher/ events/ executer/ hardware/ \
 				   namespace/ parser/ resources/ tables/ \
 				   utilities/
+
+# "acpi." module_param namespace.
+acpi-y				+= osl.o utils.o reboot.o 
+acpi-$(CONFIG_ACPI_POWER)	+= power.o
+acpi-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
 
 #
 # ACPI Bus and Device Drivers
@@ -49,11 +54,9 @@ obj-$(CONFIG_ACPI_VIDEO)	+= video.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
 obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
-obj-$(CONFIG_ACPI_POWER)	+= power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
-obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_WMI)		+= wmi.o
diff -r 79f0d024aebc drivers/acpi/system.c
--- a/drivers/acpi/system.c	Fri Aug 15 11:23:34 2008 +1000
+++ b/drivers/acpi/system.c	Sat Aug 16 15:55:10 2008 +1000
@@ -33,10 +33,6 @@
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("system");
-#ifdef MODULE_PARAM_PREFIX
-#undef MODULE_PARAM_PREFIX
-#endif
-#define MODULE_PARAM_PREFIX "acpi."
 
 #define ACPI_SYSTEM_CLASS		"system"
 #define ACPI_SYSTEM_DEVICE_NAME		"System"
