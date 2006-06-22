From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: how I know if a interrupt is ioapic_edge_type or
	ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
	2.6.17-rc6-mm2 - USB issues]]
Date: Thu, 22 Jun 2006 12:56:25 +0100
Message-ID: <1150977386.2859.34.camel@localhost.localdomain>
References: <44953B4B.9040108@agotnes.com> <4497DA3F.80302@agotnes.com>
	 <20060620044003.4287426d.akpm@osdl.org> <4499245C.8040207@agotnes.com>
	 <1150936606.2855.21.camel@localhost.portugal>
	 <20060621174754.159bb1d0.rdunlap@xenotime.net>
	 <1150938288.3221.2.camel@localhost.portugal>
	 <20060621210817.74b6b2bc.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:40363 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1161089AbWFVL4g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 07:56:36 -0400
In-Reply-To: <20060621210817.74b6b2bc.rdunlap@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu, cw@f00f.org, vsu@altlinux.ru

On Wed, 2006-06-21 at 21:08 -0700, Randy.Dunlap wrote:
>=20
> If you have a specific issue/problem, it would probably be
> better just to focus on that.=20

on linux-2.6.17/drivers/pci/quirks.c=09

  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
  * interrupts delivered properly.
  */

 static void quirk_via_irq(struct pci_dev *dev)
 {
 	u8 irq, new_irq;

I want here put something like:  if ( dev->irq !=3D XT-PIC) return and =
don't quirk this dev.
 	else=20

	new_irq =3D dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
=20

--
S=C3=A9rgio M. B.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
