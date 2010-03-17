From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/3] hpet: convert to PNP driver
Date: Wed, 17 Mar 2010 16:00:18 -0700
Message-ID: <201003171700.19573.bjorn.helgaas@hp.com>
References: <20100317173329.31124.69795.stgit@bob.kio> <20100317173500.31124.53755.stgit@bob.kio> <3055132f1003171518o46c4712bk5089a7bab8574019@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:14701 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab0CQXAW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Mar 2010 19:00:22 -0400
In-Reply-To: <3055132f1003171518o46c4712bk5089a7bab8574019@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venkatesh Pallipadi <venki@google.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-acpi@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org

On Wednesday 17 March 2010 04:18:27 pm Venkatesh Pallipadi wrote:
> On Wed, Mar 17, 2010 at 10:35 AM, Bjorn Helgaas <bjorn.helgaas@hp.com=
> wrote:
> >
> > PNPACPI already parses _CRS, and does a more complete job than we d=
id here,
> > so let's just take advantage of that.
>=20
> Patch looks good.
> One comment is that we now have a dependency on CONFIG_PNP. That
> probably needs to be added in drivers/char/Kconfig. But, that also
> means we may fail for users who do not have PNP in their config today=
=2E
> May be just select PNP when HPET is selected?

Good point; I missed that.  I could just add #ifdef CONFIG_PNP around
the relevant code in hpet.c.  That's the typical way we handle this.

drivers/char/hpet.c already depends on ACPI for another reason
(acpi_irq_model), and we do select PNP whenever CONFIG_ACPI=3Dy, so
I don't think the CONFIG_PNP=3Dn case will arise in practice.  But
it'd probably be better to have the #ifdef wrapper than to have the
implicit dependency on the "select PNP" in drivers/acpi/Kconfig.

> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > ---
> >
> > =A0drivers/char/hpet.c | =A0103 +++++++++++++----------------------=
----------------
> > =A01 files changed, 27 insertions(+), 76 deletions(-)
> >
> >
> >
> > - =A0 =A0 =A0 if (!data.hd_address || !data.hd_nirqs) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s: no address or irqs in _CR=
S\n", __func__);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > - =A0 =A0 =A0 }
> > + =A0 =A0 =A0 data.hd_address =3D ioremap(mem->start, resource_size=
(mem));
> >
> > =A0 =A0 =A0 =A0return hpet_alloc(&data);
> > =A0}
>=20
> Not a problem with this patch. But, don't we have a problem of rogue
> ioremap when hpet_alloc() fails here?

You're right.  I'll add a patch to fix that while I'm at it.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
