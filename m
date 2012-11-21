From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND] acpi: Fix logging when no pci_irq is allocated
Date: Wed, 21 Nov 2012 22:25:12 +0100
Message-ID: <5752160.0Aavql38JJ@vostro.rjw.lan>
References: <1353487401-10279-1-git-send-email-daniel@numascale-asia.com> <1483298.SPL34HcZVJ@vostro.rjw.lan> <1353531235.24807.39.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:58895 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964856Ab2KUVUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Nov 2012 16:20:43 -0500
In-Reply-To: <1353531235.24807.39.camel@joe-AO722>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jan =?ISO-8859-1?Q?H=2E_Sch=F6nherr?= <schnhrr@cs.tu-berlin.de>, Daniel J Blueman <daniel@numascale-asia.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, November 21, 2012 12:53:55 PM Joe Perches wrote:
> On Wed, 2012-11-21 at 21:50 +0100, Rafael J. Wysocki wrote:
> > On Wednesday, November 21, 2012 05:46:04 AM Joe Perches wrote:
> > > On Wed, 2012-11-21 at 16:43 +0800, Daniel J Blueman wrote:
> > > > Previously a new line is implicitly added in the no GSI case:
> > > >=20
> > > > [    7.185182] pci 0001:00:12.0: can't derive routing for PCI I=
NT A
> > > > [    7.191352] pci 0001:00:12.0: PCI INT A: no GSI
> > > > [    7.195956]  - using ISA IRQ 10
> > > >=20
> > > > The code thus prints a blank line where no legacy IRQ is availa=
ble:
> > > >=20
> > > > [    1.650124] pci 0000:00:14.0: can't derive routing for PCI I=
NT A
> > > > [    1.650126] pci 0000:00:14.0: PCI INT A: no GSI
> > > > [    1.650126]=20
> > > > [    1.650180] pci 0000:00:14.0: can't derive routing for PCI I=
NT A
> > > >=20
> > > > Fix this by making the newline explicit and removing the superf=
luous
> > > > one.
> > >=20
> > > This breaks the logging code below it when there is an ISA irq.
> > >=20
> > > The below works, but is a workaround for a defect in the printk
> > > subsystem introduced by a logging change that will be fixed in
> > > a near future release.
> >=20
> > What exactly do you mean by "near future"?
>=20
> I mean Jan Sch=C3=B6nherr's patches that should fix this are
> likely to be picked up one day.
>=20
> https://lkml.org/lkml/2012/11/13/678

Till then, we need the patch you sent, right?  And it won't hurt to app=
ly it
anyway?

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
