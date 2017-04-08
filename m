From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] acpi: pci: don't ignore function ID of bridge device in _PRT
Date: Sat, 8 Apr 2017 15:02:32 +0100
Message-ID: <CA6B8A91-B540-435A-9DE6-39B88DCBCE35@linaro.org>
References: <20170407132222.28300-1-ard.biesheuvel@linaro.org> <20170407170654.GA30103@bhelgaas-glaptop.roam.corp.google.com> <CAKv+Gu_rivjMaQ740LWO1Nm8SPMGuQ1J1TFeD8QXnRch8Lv6bg@mail.gmail.com> <20170407180652.GA12301@red-moon> <CAKv+Gu-wXAU9_eHFLSDNKa6hTznHne=HDU8qi-c69PrgSR1i=Q@mail.gmail.com> <CAKv+Gu9EoUo+_BDSBj_v6eS7yYdjktcbQQA_eiLoqY47y1oK6w@mail.gmail.com> <20170408132232.GA13027@red-moon>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36645 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdDHOCj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Apr 2017 10:02:39 -0400
Received: by mail-wm0-f49.google.com with SMTP id o81so10129715wmb.1
        for <linux-acpi@vger.kernel.org>; Sat, 08 Apr 2017 07:02:38 -0700 (PDT)
In-Reply-To: <20170408132232.GA13027@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Alan Ott <alan@softiron.co.uk>, Bjorn Helgaas <helgaas@kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>


> On 8 Apr 2017, at 14:22, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wro=
te:
>=20
>> On Sat, Apr 08, 2017 at 12:22:15PM +0100, Ard Biesheuvel wrote:
>>> On 7 April 2017 at 19:35, Ard Biesheuvel <ard.biesheuvel@linaro.org> wro=
te:
>>>> On 7 April 2017 at 19:06, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>=
 wrote:
>>>>> On Fri, Apr 07, 2017 at 06:12:05PM +0100, Ard Biesheuvel wrote:
>>>>>> On 7 April 2017 at 18:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> [...]
>>>=20
>>> OK, I have changed my DSDT as follows:
>>>=20
>>>=20
>>> Device (PCI0)
>>> {
>>>    Name (_ADR, 0x00)
>>>    Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
>>>    Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
>>>    Name (_SEG, 0x00)  // _SEG: PCI Segment
>>>    Name (_BBN, 0x00)  // _BBN: BIOS Bus Number
>>>    Name (_CCA, 0x01)  // _CCA: Cache Coherency Attribute
>>>=20
>>>    Device (EXP1)
>>>    {
>>>        Name (_ADR, 0x20001)  // _ADR: Address
>>>        Name (_PRT, Package ()  // _PRT: PCI Routing Table
>>>        {
>>>            // slot 1: dev 2 fn 1
>>>            Package () { 0xFFFF, 0x0, 0x0, 0x140 },
>>>            Package () { 0xFFFF, 0x1, 0x0, 0x141 },
>>>            Package () { 0xFFFF, 0x2, 0x0, 0x142 },
>>>            Package () { 0xFFFF, 0x3, 0x0, 0x143 }
>>>        }) // _PRT
>>>    }
>>>    Device (EXP2)
>>>    {
>>>        Name (_ADR, 0x20002)  // _ADR: Address
>>>        Name (_PRT, Package ()  // _PRT: PCI Routing Table
>>>        {
>>>            // slot 2: dev 2 fn 2
>>>            Package () { 0xFFFF, 0x0, 0x0, 0x144 },
>>>            Package () { 0xFFFF, 0x1, 0x0, 0x145 },
>>>            Package () { 0xFFFF, 0x2, 0x0, 0x146 },
>>>            Package () { 0xFFFF, 0x3, 0x0, 0x147 }
>>>        }) // _PRT
>>>    }
>>>    Device (EXP3)
>>>    {
>>>        Name (_ADR, 0x20003)  // _ADR: Address
>>>        Name (_PRT, Package ()  // _PRT: PCI Routing Table
>>>        {
>>>            // slot 3: dev 2 fn 3
>>>            Package () { 0xFFFF, 0x0, 0x0, 0x148 },
>>>            Package () { 0xFFFF, 0x1, 0x0, 0x149 },
>>>            Package () { 0xFFFF, 0x2, 0x0, 0x14a },
>>>            Package () { 0xFFFF, 0x3, 0x0, 0x14b }
>>>        }) // _PRT
>>>    }
>>>=20
>>> but it does not get picked up, and I am back to
>>>=20
>>> [    3.357555] pcieport 0000:00:02.2: can't derive routing for PCI INT A=

>>> [    3.370477] pcieport 0000:00:02.2: PCI INT A: no GSI
>>> [    3.380549] pcieport 0000:00:02.3: can't derive routing for PCI INT A=

>>> [    3.393476] pcieport 0000:00:02.3: PCI INT A: no GSI
>>>=20
>>=20
>> OK, this does appear to work in fact, for the devices behind the
>> bridges. These messages are from the pcieport driver trying to request
>> an IRQ for the bridge device itself, which no longer works now that
>> the _PRT methods have been moved out.
>>=20
>> So that mostly solves the problem. I'll try adding back a _PRT in the
>> PCI root device itself, but i'm not sure if I can make any inferences
>> about the IRQ wiring from the data i have.
>=20
> Yes and IIUC with the $SUBJECT patch applied, the endpoints would match
> the _PRT entry under PNP0A08 through their bridge (PCIe port device =3D 2
> fn =3D X) device entry, not their own (device =3D 0) (ie first look-up in
> acpi_pci_irq_lookup() through acpi_pci_irq_find_prt_entry() should fail
> for the endpoints, then the same look-up is carried out with the bridge
> device instead and that succeeds, the _PRT entry routes IRQs for the
> PCIeport AND their downstream endpoint with $SUBJECT patch applied).
>=20
> If you add the _PRT under the PCIe port itself (table above) the PCIe
> port can't find an ACPI parent device to route its own IRQx, that's my
> reading of what's going on, I will debug it next week.
>=20

This is my understanding as well, and i think there remains little to debug o=
n the kernel side.

Moving the three banks of legacy interrupts to separate companion devices is=
 the correct thing to do, and works as expected for the devices behind the b=
ridge.

The only thing that is lacking now is a _PRT description in the pci root tha=
t describes how INTA is wired for the bridges themselves. I am not sure how t=
his matters, and whether this pci h/w ever asserts that interrupt in the fir=
st place, so i am just going to map it to 0x140 for now until someone tells m=
e otherwise.


