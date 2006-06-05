From: Daniel Drake <dsd@gentoo.org>
Subject: Re: Most interrupts are edge-triggered, non-APIC system
Date: Mon, 05 Jun 2006 20:56:10 +0100
Message-ID: <44848C5A.8090409@gentoo.org>
References: <447F566E.4060502@gentoo.org> <200606051243.23006.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:11922 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751335AbWFETzh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Jun 2006 15:55:37 -0400
In-Reply-To: <200606051243.23006.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, joliveirinha@gmail.com, Stephen Hemminger <shemminger@osdl.org>

Bjorn Helgaas wrote:
> On Thursday 01 June 2006 15:04, Daniel Drake wrote:
>> Jo=C3=A3o Oliveirinha reported a bug related to the sky2 network dri=
ver on=20
>> the Gentoo bugzilla. Stephen Hemminger (sky2 author) kindly helped=20
>> diagnose the issues, and he believes that one of the reasons why thi=
ngs=20
>> are running sub-optimally is because the interrupt assigned to sky2 =
is=20
>> edge-triggered (NAPI requires things to be level-triggered).
>=20
> I'm not convinced that the sky2 interrupt is edge-triggered.

Thanks for the explanation, that makes sense. Stephen, you might be=20
interested in this: (don't worry, nothing is broken!)

> The "ELCR" line:
>   ACPI: setting ELCR to 0200 (from 0c20)
> only shows the ELCR state early during boot when we're setting
> up the ACPI SCI interrupt.
>=20
> Interrupts can also be set to level-triggered mode later, when
> the driver claims the device.  This in the acpi_register_gsi() ->
> eisa_set_level_irq() path and prints a different message.
>=20
> Attachment http://bugs.gentoo.org/attachment.cgi?id=3D85619&action=3D=
view
> shows that sky2 should be on IRQ11, and it should be level-triggered:
>=20
>   ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
>   PCI: setting IRQ 11 as level-triggered
>   ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 11 (level=
, low) -> IRQ 11
>   ...
>   ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level=
, low) -> IRQ 11
>   PCI: Setting latency timer of device 0000:02:00.0 to 64
>   sky2 v0.15 addr 0xbc000000 irq 11 Yukon-FE (0xb7) rev 1
>=20
> (sky2 shares the interrupt with other devices, so we set IRQ 11
> to be level-triggered when we enable the interrupt for one of
> the other devices, so the "setting IRQ 11 as level-triggered"
> message is earlier than the sky2 driver init.)

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
