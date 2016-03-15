From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 1/4] acpi,pci,irq: reduce resource requirements
Date: Mon, 14 Mar 2016 22:28:11 -0400
Message-ID: <56E7733B.4050308@codeaurora.org>
References: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
 <20160314185251.GA19703@localhost> <56E7211F.3070203@codeaurora.org>
 <20160314210147.GA11459@localhost> <56E73232.9030704@codeaurora.org>
 <20160315014843.GA16967@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20160315014843.GA16967@localhost>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com, bhelgaas@google.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 3/14/2016 9:48 PM, Bjorn Helgaas wrote:

Yes. I was talking about PCIe on ARM64.=20

> If you go to Fry's and buy a conventional PCI card, it is going to
> pull INTA# low to assert an interrupt.  It doesn't matter whether you
> put it in an x86 system or an arm64 system.
>=20

I don't see INTA# of the PCIe card at the system level. The PCIe wire=20
interrupt gets converted to the system level interrupt by the PCIe cont=
roller.

>> > I pasted the code here again. It looks like you want to validate t=
hat
>> > PCI interrupts are always level low.=20
> I don't really care whether PCI interrupts are always level low.  Wha=
t
> matters is that the PCI interrupt line matches the configuration of
> the interrupt controller input.
>=20

Agreed. But the interrupt controller configuration is system specific. =
How would
you check interrupt line against what the interrupt controller requires
on each architecture as this is common code?


> If the PCI interrupt can be a different type, e.g., level high, and
> there's a way to discover that, we can check that against the
> interrupt controller configuration.
>=20
> This is all in the context of conventional PCI, and we're probably
> talking about arm64 PCIe systems, not conventional PCI.=20

INTx interrupts are TLP messages on PCIe as you already know. There is =
no INTA=20
interrupt wire.

"6.1.2. PCI Compatible INTx Emulation" section of the PCIe spec describ=
es
INTx emulation on PCIe.

I pasted that section here for your reference.

"Two types of Messages are defined, Assert_INTx and Deassert_INTx, for =
emulation of PCI INTx
signaling, where x is A, B, C, and D for respective PCI interrupt signa=
ls. These Messages are used to
provide =93virtual wires=94 for signaling interrupts across a Link. Swi=
tches collect these virtual wires and
present a combined set at the Switch=92s Upstream Port. Ultimately, the=
 virtual wires are routed to the
Root Complex which maps the virtual wires to system interrupt resources=
=2E Devices must use
10 assert/de-assert Messages in pairs to emulate PCI interrupt level-tr=
iggered signaling. Actual
mapping of PCI Express INTx emulation to system interrupts is implement=
ation specific as is
mapping of physical interrupt signals in conventional PCI."


> I'm not sure what an Interrupt Link device means in PCIe.  I suppose =
it would have
> to connect an INTx virtual wire to a system interrupt?  The PCIe spec
> says this sort of mapping is system implementation specific (r3.0, se=
c
> 2.2.8.1).
>=20

The INTx messages are converted to the system interrupt by the PCIe con=
troller.
The interrupt type between the PCIe controller and the ARM GIC interrup=
t=20
controller is dictated by the ARM GIC Interrupt Controller Specificatio=
n for
ARM64.

Here is what ACPI table looks like for reference

	Name(_PRT, Package(){
		Package(){0x0FFFF, 0, \_SB.LN0A, 0},  // Slot 0, INTA
		Package(){0x0FFFF, 1, \_SB.LN0B, 0},  // Slot 0, INTB
		Package(){0x0FFFF, 2, \_SB.LN0C, 0},  // Slot 0, INTC
		Package(){0x0FFFF, 3, \_SB.LN0D, 0}   // Slot 0, INTD
	})=20

Device(LN0A){
	Name(_HID, EISAID("PNP0C0F")) // PCI interrupt link
	Name(_UID, 1)
	Name(_PRS, ResourceTemplate(){
	Interrupt(ResourceProducer, Level, ActiveHigh, Exclusive, , ,) {0x123}
	})
	Method(_DIS) {}
	Method(_CRS) { Return (_PRS) }
	Method(_SRS, 1) {}
}=20




--=20
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, In=
c.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Li=
nux Foundation Collaborative Project
