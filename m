From: Franck Routier <franck.routier-i39dT1/MG/sAvxtiuMwx3w@public.gmane.org>
Subject: Samsung X10
Date: Thu, 24 Jun 2004 17:04:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40DAED8B.50105@axege.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I am trying to install Debian Sid on a Samsung X10 laptop. ACPI is 
required to handled power management.
The kernel I use is stock 2.6.6.

When I boot, I get the following messages (from a 'cat /var/log/messages 
| grep ACPI') :

Jun 24 15:56:34 etamine kernel:  BIOS-e820: 000000001ff70000 - 
000000001ff7c000 (ACPI data)
Jun 24 15:56:34 etamine kernel:  BIOS-e820: 000000001ff7c000 - 
000000001ff80000 (ACPI NVS)
Jun 24 15:56:34 etamine kernel: ACPI: RSDP (v000 
SENSX                                     ) @ 0x000f7580
Jun 24 15:56:34 etamine kernel: ACPI: RSDT (v001 SENSX  AQUILA   
0x06040000 SENS 0x00000000) @ 0x1ff77eda
Jun 24 15:56:34 etamine kernel: ACPI: FADT (v001 SENSX  SENSX10  
0x06040000 SENS 0x00000050) @ 0x1ff7bf64
Jun 24 15:56:34 etamine kernel: ACPI: BOOT (v001 SENSX  $SBFTBL$ 
0x06040000 SENS 0x00000001) @ 0x1ff7bfd8
Jun 24 15:56:34 etamine kernel: ACPI: SSDT (v001  INTEL  EISTRef 
0x00002000 INTL 0x02012044) @ 0x1ff77f0a
Jun 24 15:56:34 etamine kernel: ACPI: DSDT (v001 SENSX  AQUILA   
0x06040000 MSFT 0x0100000e) @ 0x00000000
Jun 24 15:56:34 etamine kernel: ACPI: PM-Timer IO Port: 0x1008
Jun 24 15:56:34 etamine kernel: ACPI: Subsystem revision 20040326
Jun 24 15:56:34 etamine kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Jun 24 15:56:34 etamine kernel: ACPI: Interpreter enabled
Jun 24 15:56:34 etamine kernel: ACPI: Using PIC for interrupt routing
Jun 24 15:56:34 etamine kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *10)
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs *5)
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 5) 
*0, disabled.
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 
10) *0, disabled.
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs *5)
Jun 24 15:56:34 etamine kernel: ACPI: Embedded Controller [H_EC] (gpe 28)
Jun 24 15:56:34 etamine kernel:     ACPI-0347: *** Error: Handler for 
[EmbeddedControl] returned AE_BAD_PARAMETER
Jun 24 15:56:34 etamine kernel:     ACPI-1133: *** Error: Method 
execution failed [\_SB_.PCI0.LPCB.H_EC._REG] (Node c14e7e1c), 
AE_BAD_PARAMETER
Jun 24 15:56:34 etamine kernel: ACPI: Power Resource [PFAN] (on)
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKA] enabled 
at IRQ 11
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKD] enabled 
at IRQ 10
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKH] enabled 
at IRQ 5
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKC] enabled 
at IRQ 10
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKB] enabled 
at IRQ 11
Jun 24 15:56:34 etamine kernel: ACPI: PCI Interrupt Link [LNKE] enabled 
at IRQ 5
Jun 24 15:56:34 etamine kernel: PCI: Using ACPI for IRQ routing
Jun 24 15:56:35 etamine kernel:     ACPI-0347: *** Error: Handler for 
[EmbeddedControl] returned AE_BAD_PARAMETER
Jun 24 15:56:35 etamine kernel:     ACPI-1133: *** Error: Method 
execution failed [\_SB_.BAT1._STA] (Node c14eb51c), AE_AML_NO_RETURN_VALUE
Jun 24 15:56:35 etamine kernel:     ACPI-0347: *** Error: Handler for 
[EmbeddedControl] returned AE_BAD_PARAMETER
Jun 24 15:56:35 etamine kernel:     ACPI-1133: *** Error: Method 
execution failed [\_SB_.ADP1._PSR] (Node c14eb65c), AE_BAD_PARAMETER
Jun 24 15:56:35 etamine kernel: ACPI: Processor [CPU0] (supports C1 C2 
C3, 8 throttling states)
Jun 24 15:56:35 etamine kernel: ACPI: Power Button (FF) [PWRF]
Jun 24 15:56:35 etamine kernel: ACPI: Lid Switch [LID0]
Jun 24 15:56:35 etamine kernel: ACPI: Sleep Button (CM) [SLPB]
Jun 24 15:56:35 etamine kernel: ACPI: Fan [FAN0] (on)
Jun 24 15:56:35 etamine kernel:     ACPI-0347: *** Error: Handler for 
[EmbeddedControl] returned AE_BAD_PARAMETER
Jun 24 15:56:35 etamine kernel:     ACPI-1133: *** Error: Method 
execution failed [\_TZ_.THRM._TMP] (Node c14eb8dc), AE_BAD_PARAMETER

The system boots up, but for example the battery is not recognized...

Any hint ?

Thanks,

Franck


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
