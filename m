From: haller-aGcF43uWAqI@public.gmane.org (Nicolas Haller)
Subject: problem with acpi and strange message(for me) on dmesg
Date: Fri, 30 Jul 2004 23:23:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040730212334.GA5083@efrei.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

I don't know if it is the good place to post my question and if not,
please excuse me.

I have a problem with the acpi support. I had compiled acpi support in a
2.6.7 kernel and I run it on my laptop Samsung X15+. The acpi doesn't
completly work because I have some information on /proc/acpi like info,
my fan, my processor status, but some information doesn't appear like
thermal zone, embedded_controler, ac_adapter, battery,...

All options in kernel are selected and I see when they are loaded in
dmesg, but some strange message appears too. So I give you a piece of
log:

nicolas@hermes:/proc/acpi$ dmesg | grep ACPI
 BIOS-e820: 000000001ff70000 - 000000001ff7c000 (ACPI data)
  BIOS-e820: 000000001ff7c000 - 000000001ff80000 (ACPI NVS)
  ACPI: RSDP (v000 SENSX                                     ) @
  0x000f7540
  ACPI: RSDT (v001 SENSX  AQUILA   0x06040000 SENS 0x00000000) @
  0x1ff77dd9
  ACPI: FADT (v001 SENSX  SENSX10  0x06040000 SENS 0x00000050) @
  0x1ff7bf64
  ACPI: BOOT (v001 SENSX  $SBFTBL$ 0x06040000 SENS 0x00000001) @
  0x1ff7bfd8
  ACPI: SSDT (v001  INTEL  EISTRef 0x00002000 INTL 0x20020725) @
  0x1ff77e09
  ACPI: DSDT (v001 SENSX  AQUILA   0x06040000 MSFT 0x0100000e) @
  0x00000000
  ACPI: Subsystem revision 20040326
  ACPI: IRQ9 SCI: Edge set to Level Trigger.
  ACPI: Interpreter enabled
  ACPI: Using PIC for interrupt routing
  ACPI: PCI Root Bridge [PCI0] (00:00)
  ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
  ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
  ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
  ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
  ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
  ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
  ACPI: PCI Interrupt Link [LNKD] (IRQs *10)
  ACPI: PCI Interrupt Link [LNKE] (IRQs *5)
  ACPI: PCI Interrupt Link [LNKF] (IRQs 5) *0, disabled.
  ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
  ACPI: PCI Interrupt Link [LNKH] (IRQs *5)
  ACPI: Embedded Controller [H_EC] (gpe 28)
  ACPI-0347: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
  ACPI-1133: *** Error: Method execution failed[\_SB_.PCI0.LPCB.H_EC._REG] (Node c14be1a8), AE_BAD_PARAMETER
  ACPI: Power Resource [PFAN] (on)
  ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
  ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
  ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
  ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
  ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
  ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
  PCI: Using ACPI for IRQ routing
  ACPI-0347: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
   ACPI-1133: *** Error: Method execution failed [\_SB_.ADP1._PSR] (Node 
   c14c06c8), AE_BAD_PARAMETER
  ACPI-0347: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
  ACPI-1133: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node c14c0588),AE_AML_NO_RETURN_VALUE
  ACPI: Power Button (FF) [PWRF]
  ACPI: Lid Switch [LID0]
  ACPI: Sleep Button (CM) [SLPB]
  ACPI: Fan [FAN0] (on)
  ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
  ACPI-0347: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
  ACPI-1133: *** Error: Method execution failed [\_TZ_.THRM._TMP] (Node dff30948), AE_BAD_PARAMETER
		  
So whitout all information I can't use acpi like I want, for a laptop,
to not have information about battery ac_adaptor and thermal zones is
not really good :-)

Thanks and excuse me about my bad english level

-- 
Nicolas Haller



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
