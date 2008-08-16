From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Sat, 16 Aug 2008 13:47:40 +1000
Message-ID: <200808161347.41253.rusty@rustcorp.com.au>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au> <1218854219.3629.30.camel@lgn.site> <48A64235.2030108@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <48A64235.2030108@linux.intel.com>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, gregkh <greg@kroah.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 16 August 2008 12:57:57 Andi Kleen wrote:
> >> Extract is:
> >>
> >> XXX adding modparam:'acpi.power_nocheck' 34 (ffffffff806a4cf0)
> >
> > ...
> >
> >> XXX adding modparam:'acpi.acpica_version' 45 (ffffffff806a4ea8)
> >
> > Two different "modules" use the same prefix, which does not work with
> > the current logic, they need to live next to each other in the sequence
> > of options.
>
> Sequence of options being defined by link order?

Simplest fix is to shuffle Makefile.  But better is to create an acpi "module"
so the namespacing just works, something like below.  Overriding MODULE_PREFIX
only works for builtin code anyway.  (Which makes sense: moving a parameter
from one module to another isn't a change we can cover up).

(Sam: foo-objs-y would make this neater)

diff -r 5f7194400572 drivers/acpi/Makefile
--- a/drivers/acpi/Makefile	Sat Aug 16 13:23:26 2008 +1000
+++ b/drivers/acpi/Makefile	Sat Aug 16 13:44:17 2008 +1000
@@ -21,10 +21,18 @@ obj-$(CONFIG_X86)		+= blacklist.o
 #
 # ACPI Core Subsystem (Interpreter)
 #
-obj-y				+= osl.o utils.o reboot.o\
+obj-y				+= osl.o utils.o reboot.o acpi.o \
 				   dispatcher/ events/ executer/ hardware/ \
 				   namespace/ parser/ resources/ tables/ \
 				   utilities/
+
+# "acpi." module_param namespace.
+ifdef CONFIG_ACPI_POWER
+acpi-objs	+= power.o
+endif
+ifdef CONFIG_ACPI_SYSTEM
+acpi-objs	+= system.o event.o
+endif
 
 #
 # ACPI Bus and Device Drivers
@@ -49,11 +57,9 @@ obj-$(CONFIG_ACPI_VIDEO)	+= video.o
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
diff -r 5f7194400572 drivers/acpi/system.c
--- a/drivers/acpi/system.c	Sat Aug 16 13:23:26 2008 +1000
+++ b/drivers/acpi/system.c	Sat Aug 16 13:44:17 2008 +1000
@@ -33,10 +33,6 @@
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("system");
-#ifdef MODULE_PARAM_PREFIX
-#undef MODULE_PARAM_PREFIX
-#endif
-#define MODULE_PARAM_PREFIX "acpi."
 
 #define ACPI_SYSTEM_CLASS		"system"
 #define ACPI_SYSTEM_DEVICE_NAME		"System"
