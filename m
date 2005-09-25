From: Dimitris Mandalidis <mandas-a3G4OTGJCpcdnm+yROfE0A@public.gmane.org>
Subject: ACPI+PS/2 mouse problem
Date: Sun, 25 Sep 2005 22:34:51 +0300
Message-ID: <20050925193451.GB11527@aldus.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
I 'm experiencing a problem, with my old QDI Advance 9 based PC. The
problem is that without a PS/2 mouse connected to the mobo I cannot
shutdown my PC using the power button. With the PS/2 mouse connected
everything works fine. 
To make things worse, acpid logs and all my system logs don't report
anything about the fact that I 'm pressing the button. This situation has
been tested with 2.6.13 and 2.6.14-rc2 kernel, and acpid-1.0.3. I don't
think that's an acpid related problem, but a kernel related problem, but
due to ECN I cannot subscribe to linux-kernel, so please forward if
necessary.

Thanks in advance

D.

PS. I think that's the necessary information, all my acpi handling scripts
are working in general 

 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
ACPI: RSDP (v000 QDIGRP                                ) @ 0x000f7430
ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x07ff3000
ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x07ff3040
ACPI: DSDT (v001 QDIGRP AWRDACPI 0x00001000 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: setting ELCR to 0020 (from 1c20)
ACPI: bus type pci registered
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
PCI: Using ACPI for IRQ routing
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNKB] -> GSI 12 (level, low) -> IRQ 12
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] -> GSI 12 (level, low) -> IRQ 12
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
ACPI wakeup devices: 
ACPI: (supports S0 S1 S5)

-- 
PGP key 39A40276 at wwwkeys.eu.pgp.net 
key fingeprint: 9A0B 61C6 B826 4B73 69BB  972B C5E7 A153 39A4 0276


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
