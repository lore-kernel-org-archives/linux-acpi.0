From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Most interrupts are edge-triggered, non-APIC system
Date: Mon, 5 Jun 2006 12:43:22 -0600
Message-ID: <200606051243.23006.bjorn.helgaas@hp.com>
References: <447F566E.4060502@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:39653 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751279AbWFESn3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2006 14:43:29 -0400
In-Reply-To: <447F566E.4060502@gentoo.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-acpi@vger.kernel.org, joliveirinha@gmail.com

On Thursday 01 June 2006 15:04, Daniel Drake wrote:
> Jo=C3=A3o Oliveirinha reported a bug related to the sky2 network driv=
er on=20
> the Gentoo bugzilla. Stephen Hemminger (sky2 author) kindly helped=20
> diagnose the issues, and he believes that one of the reasons why thin=
gs=20
> are running sub-optimally is because the interrupt assigned to sky2 i=
s=20
> edge-triggered (NAPI requires things to be level-triggered).

I'm not convinced that the sky2 interrupt is edge-triggered.

The "ELCR" line:
  ACPI: setting ELCR to 0200 (from 0c20)
only shows the ELCR state early during boot when we're setting
up the ACPI SCI interrupt.

Interrupts can also be set to level-triggered mode later, when
the driver claims the device.  This in the acpi_register_gsi() ->
eisa_set_level_irq() path and prints a different message.

Attachment http://bugs.gentoo.org/attachment.cgi?id=3D85619&action=3Dvi=
ew
shows that sky2 should be on IRQ11, and it should be level-triggered:

  ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
  PCI: setting IRQ 11 as level-triggered
  ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 11 (level, =
low) -> IRQ 11
  ...
  ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, =
low) -> IRQ 11
  PCI: Setting latency timer of device 0000:02:00.0 to 64
  sky2 v0.15 addr 0xbc000000 irq 11 Yukon-FE (0xb7) rev 1

(sky2 shares the interrupt with other devices, so we set IRQ 11
to be level-triggered when we enable the interrupt for one of
the other devices, so the "setting IRQ 11 as level-triggered"
message is earlier than the sky2 driver init.)

Bjorn
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
