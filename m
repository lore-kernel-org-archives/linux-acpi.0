From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: "new" kernel acpi irq routing breaks tulip driver for admtek
 network card
Date: Wed, 30 Mar 2005 16:06:33 -0700
Message-ID: <1112223993.20358.87.camel@eeyore>
References: <42419BE6.7000702@gmx.net> <1111685885.24547.2.camel@eeyore>
	 <4248070F.7080802@gmx.net> <1112031435.11720.23.camel@eeyore>
	 <424B1AFB.8040508@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-/F9e2IpFQ229P6voqlID"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <424B1AFB.8040508-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sapier <sapier-hi6Y0CQ0nG0@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-/F9e2IpFQ229P6voqlID
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-03-30 at 23:32 +0200, Sapier wrote:
> when you look at the attached dmesg log you see that first try to use 
> eth0 device fails but when pcmcia modules are loaded notice the line
> "ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10"
> after that the network card gets an ip address and seems to work

This is very interesting.  And your theory sounds good to me.
Just to confirm -- if you load tulip first (without loading
yenta), the NIC doesn't work.  And if you load yenta first,
*then* load tulip, the NIC does work.  Alternatively, if you
boot with "pci=routeirq", the NIC works regardless of the
tulip/yenta load order.

That suggests that the ACPI PRT says tulip is directly connected
to IRQ 10, but in fact, it is connected to LNKB.  We disable the
IRQ links at boot-time (in acpi_pci_link_add()), so that would
explain why it doesn't work until yenta gets loaded.  "pci=routeirq"
enables all the links before drivers start up, so that explains
why it works then.

You could disassemble your DSDT to verify what it says about
the NIC.  In short, "cp /proc/acpi/dsdt dsdt; iasl -d dsdt;
cat dsdt.dsl".  Look for the entry under \_SB_.PCI0._PRT
for 0x0009FFFF, since the NIC is 0000:00:09.0.

You can get iasl here:
    http://www.intel.com/technology/IAPC/acpi/downloads.htm
I had to use the attached patch to build it cleanly.

This mentions what looks like a similar problem:
    http://www.kybs.de/boris/notebook.shtml

A BIOS upgrade would be the best way to fix this, but
you already said no BIOS updates are available.

I don't know whether ACPI has a "quirk" model to deal with
things like this.

> Linux version 2.6.11 (root@mobility) (gcc-Version 3.4.1) #5 Wed Mar 30 22:36:22 CEST 2005
> ...
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
> ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
> ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 5) *0, disabled.
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
> ...
> Linux Tulip driver version 1.1.13 (May 11, 2002)
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
> PCI: setting IRQ 10 as level-triggered
> ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 10 (level, low) -> IRQ 10
> tulip0:  MII transceiver #1 config 1000 status 786d advertising 01e1.
> eth0: ADMtek Comet rev 17 at 00011c00, 00:90:96:1A:32:D1, IRQ 10.
> ...
> 0000:00:09.0: tulip_stop_rxtx() failed
> eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
> 0000:00:09.0: tulip_stop_rxtx() failed
> Linux Kernel Card Services
>   options:  [pci] [cardbus] [pm]
> ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
> Yenta: CardBus bridge found at 0000:00:0c.0 [1509:1860]
> Yenta O2: res at 0x94/0xD4: e8/00
> Yenta O2: enabling read prefetch/write burst
> Yenta: ISA IRQ mask 0x0800, PCI irq 10
> Socket status: 30000006
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:0c.1[B] -> GSI 10 (level, low) -> IRQ 10
> Yenta: CardBus bridge found at 0000:00:0c.1 [1509:1860]
> Yenta: ISA IRQ mask 0x0800, PCI irq 10
> Socket status: 30000006
> cs: IO port probe 0xc00-0xcff: clean.
> cs: IO port probe 0xc00-0xcff: clean.
> cs: IO port probe 0x800-0x8ff: clean.
> cs: IO port probe 0x800-0x8ff: clean.
> cs: IO port probe 0x100-0x4ff: excluding 0x2f8-0x2ff 0x378-0x37f 0x3f8-0x3ff
> cs: IO port probe 0x100-0x4ff: excluding 0x2f8-0x2ff 0x378-0x37f 0x3f8-0x3ff
> cs: IO port probe 0xa00-0xaff: clean.
> cs: IO port probe 0xa00-0xaff: clean.
> 0000:00:09.0: tulip_stop_rxtx() failed
> eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
> eth0: no IPv6 routers present

--=-/F9e2IpFQ229P6voqlID
Content-Disposition: attachment; filename=diffs
Content-Type: text/x-patch; name=diffs; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff -u -r acpica-unix-20050309/compiler/Makefile fixed/compiler/Makefile
--- acpica-unix-20050309/compiler/Makefile	2005-03-09 12:34:09.000000000 -0700
+++ fixed/compiler/Makefile	2005-03-30 14:29:04.000000000 -0700
@@ -82,7 +82,7 @@
 YACC=	bison
 YFLAGS+= -v -d
 LEX=	flex
-LFLAGS+= -i
+LFLAGS+= -i --array
 
 #.if $(YACC) == "bison"
 YFLAGS+= -y -pAslCompiler
diff -u -r acpica-unix-20050309/compiler/aslglobal.h fixed/compiler/aslglobal.h
--- acpica-unix-20050309/compiler/aslglobal.h	2005-03-09 12:34:08.000000000 -0700
+++ fixed/compiler/aslglobal.h	2005-03-30 14:26:26.000000000 -0700
@@ -141,7 +141,7 @@
 extern FILE                         *AslCompilerin;
 extern int                          AslCompilerdebug;
 extern const ASL_MAPPING_ENTRY      AslKeywordMapping[];
-extern char                         *AslCompilertext;
+extern char                         AslCompilertext[];
 extern char                         hex[];
 
 #define ASL_LINE_BUFFER_SIZE        512

--=-/F9e2IpFQ229P6voqlID--



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
