From: Orion Poplawski <orion@cora.nwra.com>
Subject: ACPI Error (evevent-0312): No installed handler for fixed event [00000002]
 [20060127]
Date: Wed, 07 Jun 2006 09:15:20 -0600
Message-ID: <e66qi8$rrm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:59877 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932246AbWFGPUF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2006 11:20:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FnzpD-0000Pq-3n
	for linux-acpi@vger.kernel.org; Wed, 07 Jun 2006 17:20:03 +0200
Received: from inferno.cora.nwra.com ([65.125.157.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jun 2006 17:20:03 +0200
Received: from orion by inferno.cora.nwra.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jun 2006 17:20:03 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Starting to see this on a Dell OptiPlex GX150 with FC5 kernel 
2.6.16-1.2122_FC5.  Any idea what it means?

  BIOS-e820: 000000001fef7000 - 000000001ff16000 (ACPI data)
ACPI: RSDP (v000 DELL                                  ) @ 0x000fd6d0
ACPI: RSDT (v001 DELL    GX150   0x00000005 ASL  0x00000061) @ 0x000fd6e4
ACPI: FADT (v001 DELL    GX150   0x00000005 ASL  0x00000061) @ 0x000fd718
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000b) @ 0xfffe7465
ACPI: BOOT (v001 DELL    GX150   0x00000005 ASL  0x00000061) @ 0x000fd7e8
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: setting ELCR to 0200 (from 0e00)
ACPI: bus type pci registered
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 15)
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
apm: overridden by ACPI.
ACPI wakeup devices:
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.2[D] -> Link [LNKD] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:1f.4[C] -> Link [LNKH] -> GSI 9 (level, low) 
-> IRQ 9
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:1f.2[D] -> Link [LNKD] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:1f.4[C] -> Link [LNKH] -> GSI 9 (level, low) 
-> IRQ 9
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
ACPI Error (evevent-0312): No installed handler for fixed event 
[00000002] [20060127]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
ACPI: PCI Interrupt 0000:00:1f.2[D] -> Link [LNKD] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:1f.4[C] -> Link [LNKH] -> GSI 9 (level, low) 
-> IRQ 9
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
ACPI Error (evevent-0312): No installed handler for fixed event 
[00000002] [20060127]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11

-- 
Orion Poplawski
System Administrator                   303-415-9701 x222
Colorado Research Associates/NWRA      FAX: 303-415-9702
3380 Mitchell Lane, Boulder CO 80301   http://www.co-ra.com

