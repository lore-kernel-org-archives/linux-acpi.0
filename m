From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] acpi: pci: don't ignore function ID of bridge device in _PRT
Date: Sat, 8 Apr 2017 12:22:15 +0100
Message-ID: <CAKv+Gu9EoUo+_BDSBj_v6eS7yYdjktcbQQA_eiLoqY47y1oK6w@mail.gmail.com>
References: <20170407132222.28300-1-ard.biesheuvel@linaro.org>
 <20170407170654.GA30103@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_rivjMaQ740LWO1Nm8SPMGuQ1J1TFeD8QXnRch8Lv6bg@mail.gmail.com>
 <20170407180652.GA12301@red-moon> <CAKv+Gu-wXAU9_eHFLSDNKa6hTznHne=HDU8qi-c69PrgSR1i=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34419 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdDHLWR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Apr 2017 07:22:17 -0400
Received: by mail-io0-f172.google.com with SMTP id b140so62676851iof.1
        for <linux-acpi@vger.kernel.org>; Sat, 08 Apr 2017 04:22:16 -0700 (PDT)
In-Reply-To: <CAKv+Gu-wXAU9_eHFLSDNKa6hTznHne=HDU8qi-c69PrgSR1i=Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alan Ott <alan@softiron.co.uk>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>

On 7 April 2017 at 19:35, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 7 April 2017 at 19:06, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> On Fri, Apr 07, 2017 at 06:12:05PM +0100, Ard Biesheuvel wrote:
>>> On 7 April 2017 at 18:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
[...]
>
> OK, I have changed my DSDT as follows:
>
>
> Device (PCI0)
> {
>     Name (_ADR, 0x00)
>     Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
>     Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
>     Name (_SEG, 0x00)  // _SEG: PCI Segment
>     Name (_BBN, 0x00)  // _BBN: BIOS Bus Number
>     Name (_CCA, 0x01)  // _CCA: Cache Coherency Attribute
>
>     Device (EXP1)
>     {
>         Name (_ADR, 0x20001)  // _ADR: Address
>         Name (_PRT, Package ()  // _PRT: PCI Routing Table
>         {
>             // slot 1: dev 2 fn 1
>             Package () { 0xFFFF, 0x0, 0x0, 0x140 },
>             Package () { 0xFFFF, 0x1, 0x0, 0x141 },
>             Package () { 0xFFFF, 0x2, 0x0, 0x142 },
>             Package () { 0xFFFF, 0x3, 0x0, 0x143 }
>         }) // _PRT
>     }
>     Device (EXP2)
>     {
>         Name (_ADR, 0x20002)  // _ADR: Address
>         Name (_PRT, Package ()  // _PRT: PCI Routing Table
>         {
>             // slot 2: dev 2 fn 2
>             Package () { 0xFFFF, 0x0, 0x0, 0x144 },
>             Package () { 0xFFFF, 0x1, 0x0, 0x145 },
>             Package () { 0xFFFF, 0x2, 0x0, 0x146 },
>             Package () { 0xFFFF, 0x3, 0x0, 0x147 }
>         }) // _PRT
>     }
>     Device (EXP3)
>     {
>         Name (_ADR, 0x20003)  // _ADR: Address
>         Name (_PRT, Package ()  // _PRT: PCI Routing Table
>         {
>             // slot 3: dev 2 fn 3
>             Package () { 0xFFFF, 0x0, 0x0, 0x148 },
>             Package () { 0xFFFF, 0x1, 0x0, 0x149 },
>             Package () { 0xFFFF, 0x2, 0x0, 0x14a },
>             Package () { 0xFFFF, 0x3, 0x0, 0x14b }
>         }) // _PRT
>     }
>
> but it does not get picked up, and I am back to
>
> [    3.357555] pcieport 0000:00:02.2: can't derive routing for PCI INT A
> [    3.370477] pcieport 0000:00:02.2: PCI INT A: no GSI
> [    3.380549] pcieport 0000:00:02.3: can't derive routing for PCI INT A
> [    3.393476] pcieport 0000:00:02.3: PCI INT A: no GSI
>

OK, this does appear to work in fact, for the devices behind the
bridges. These messages are from the pcieport driver trying to request
an IRQ for the bridge device itself, which no longer works now that
the _PRT methods have been moved out.

So that mostly solves the problem. I'll try adding back a _PRT in the
PCI root device itself, but i'm not sure if I can make any inferences
about the IRQ wiring from the data i have.

Thanks all,
