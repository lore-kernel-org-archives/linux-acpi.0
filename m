From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Button implementation question
Date: Thu, 17 Aug 2006 16:23:08 +0200
Message-ID: <ec1u4c$342$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:56289 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965137AbWHQPZG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Aug 2006 11:25:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GDjjy-0001Fv-0W
	for linux-acpi@vger.kernel.org; Thu, 17 Aug 2006 17:25:02 +0200
Received: from pd95f891d.dip0.t-ipconnect.de ([217.95.137.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2006 17:25:02 +0200
Received: from hs4233 by pd95f891d.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2006 17:25:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi !

I don't have much knowlegde about ACPI :-(

What I have is a device called "FuturePad PC" which has some four
keys at the bottom and one double key at the side. It also has a
button on the left side to switch it off, which works fine with
Linux' ACPI, acpid and /etc/acpi/events/powerbt

When I run Linux 2.6.16 (the Debian variety), and
press one of the keys, I get this error output:

ACPI Error (evregion-0303): No handler for Region [ASI2] (bebb42a4) [user_defined_region] [20060127]
ACPI Error (exfldio-0279): Region user_defined_region(81) has no handler [20060127]
ACPI Exception (dswexec-0458): AE_NOT_EXIST, While resolving operands for [AE_NOT_CONFIGURED] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_GPE._L2A] (Node bebaffe0), AE_NOT_EXIST
ACPI Exception (evgpe-0553): AE_NOT_EXIST, While evaluating method [_L2A] for GPE[ 0] [20060127]

Now I googled for "region 81" and "ASI2" and have some questions:


a) there is a driver for some "Atlas Wallmount Touchscreen" device from
Jaya Kumar which claims to implement something for region 81 (whatever that
is). I took the code from
http://marc.theaimsgroup.com/?l=linux-acpi&m=115391161115058&w=2,
compiled that and loaded it as a module. That worked so far. But it didn't
change anything, I still get those errors.

Is there any documented way on how to implement kernel support for
arbitrary ACPI buttons?



b) I used "iaml" to dissemble my dsdt. There I found a section like this:

    Scope (\_SB)
    {
        Device (ASIM)
        {
            Name (_HID, "ASIM0000")
            Name (_GPE, 0x00)
            Name (_UID, 0x00)
            OperationRegion (ASI2, 0x81, 0x00, 0x00010000)
            Field (ASI2, AnyAcc, Lock, Preserve)
            {
                BNE1,   8,
                BNE2,   8,
                BNE3,   8,
                BNE4,   8,
                BNEU,   8,
                BNED,   8,
                BNEL,   8,
                BNER,   8,
                BNEE,   8,
                BNES,   8,
                BNEC,   8,
                BNRB,   8,
                BNRC,   8,
                BNRD,   8,
                BNRE,   8,
                BNRF,   8,
                BNS1,   8,
                BNS2,   8,
                BNS3,   8,
                BNS4,   8,
                BNSU,   8,
                BNSD,   8,
                BNSL,   8,
                BNSR,   8,
                BNSE,   8,
                BNSS,   8,
                BNSC,   8,
                BSRB,   8,
                BSRC,   8,
                BSRD,   8,
                BSRE,   8,
                BSRF,   8,
                BNT1,   8,
                BNT2,   8,
                BNT3,   8,
                BNT4,   8,
                BNTU,   8,
                BNTD,   8,
                BNTL,   8,
                BNTR,   8,
                BNTE,   8,
                BNTS,   8,
                BNTC,   8,
                BRIT,   8,
                BTRC,   8,
                BTRD,   8,
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }
    }

Here I see both 'ASI2' and 0x81. In what relation is this code to any
possible kernel module that I could write?



c) one error messages referred to some "AE_NOT_EXIST, While evaluating
method [_L2A]" (hey, the "While" should be "while"!). Whatever an AE is.
Anyway, I found a method named _L2A in my dsdt.dsl:

        Method (_L2A, 0, NotSerialized)
        {
            Store (0x2A, DEBP)
            If (LEqual (\_SB.ASIM.BNS3, 0x00))
            {
                If (\_SB.PCI0.PM.EGS2)
                {
                    Store (0x00, \_SB.ASIM.BNSU)
                }
                Else
                {
                    Store (0x01, \_SB.ASIM.BNEU)
                    Store (0x01, \_SB.ASIM.BNSU)
                }
            }
            Else
            {
                If (LEqual (\_SB.PCI0.PM.EGS2, 0x00))
                {
                    BRTU ()
                    STBS ()
                }
            }
        }

Anything erraneous with that?


d) When I recompile my dsdt.dsl file, I get 3 errors and a bunch of
warnings (but not in the area of the above posted ASI2 stuff. Also,
the ACPI output in "dmesg" don't look erraneous to me. Shoud I still
seek help in this list to fix the DSDT?

ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7000
ACPI: RSDT (v001 PTLTD    RSDT   0x06040005  LTP 0x00000000) @ 0x0eff9583
ACPI: FADT (v001 TMETA  PDB.ALI  0x06040005 PTL  0x000f4240) @ 0x0effee77
ACPI: SSDT (v001 PTLTD  ACPIPST1 0x06040005  LTP 0x00000001) @ 0x0effeeeb
ACPI: DSDT (v001     TM PDBALI35 0x06040005 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
...
ACPI: setting ELCR to 0200 (from 8ca0)
...
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]
ACPI: PCI Root Bridge [PCI0] (0000:00)
...
PCI quirk: region 8000-803f claimed by ali7101 ACPI
...
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 *7 10 11 12 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 6 7 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 6 7 10 11 12 *15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 6 7 *10 11 12 15)
ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 *5 7 15)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 7 10 *11)
ACPI: Power Resource [LRP0] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
...
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNK1] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ACPI: PCI Interrupt 0000:00:0e.1[A] -> Link [LNK1] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:0e.1 to 64
...
ACPI wakeup devices:

ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 144k freed
ACPI: Fan [LRA0] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (60 C)
...
a bunch of lines like
ACPI: PCI Interrupt 0000:00:0e.1[A] -> Link [LNK1] -> GSI 7 (level, low) -> IRQ 7
for various built-in devices
...
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Sleep Button (CM) [SLPB]


