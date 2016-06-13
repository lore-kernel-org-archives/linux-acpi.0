From: Liviu.Dudau@arm.com
Subject: Re: [PATCH V9 09/11] ARM64/PCI: ACPI support for legacy IRQs parsing
 and consolidation with DT code
Date: Mon, 13 Jun 2016 16:56:46 +0100
Message-ID: <20160613155646.GF1165@e106497-lin.cambridge.arm.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
 <1465588519-11334-10-git-send-email-tn@semihalf.com>
 <20160610233612.GB7671@localhost>
 <20160613104005.GA26738@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160613104005.GA26738@red-moon>
Sender: linux-pci-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Tomasz Nowicki <tn@semihalf.com>, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, okaya@codeaurora.org, jchandra@broadcom.com, robert.richter@caviumnetworks.com, mw@semihalf.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 13, 2016 at 11:40:05AM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 10, 2016 at 06:36:12PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 10, 2016 at 09:55:17PM +0200, Tomasz Nowicki wrote:
> > > To enable PCI legacy IRQs on platforms booting with ACPI, arch co=
de
> > > should include ACPI specific callbacks that parse and set-up the
> > > device IRQ number, equivalent to the DT boot path. Owing to the c=
urrent
> > > ACPI core scan handlers implementation, ACPI PCI legacy IRQs bind=
ings
> > > cannot be parsed at device add time, since that would trigger ACP=
I scan
> > > handlers ordering issues depending on how the ACPI tables are def=
ined.
> >=20
> > Uh, OK :)  I can't figure out exactly what the problem is here -- I
> > don't know where to look if I wanted to fix the scan handler orderi=
ng
> > issues, and I don't know how I could tell if it would ever be safe =
to
> > move this from driver probe-time back to device add-time.
>=20
> Right, the commit log could have been more informative.
>=20
> pcibios_add_device() was added in:
>=20
> commit d1e6dc91b532 ("arm64: Add architectural support for PCI")
>=20
> whose commit log does not specify why legacy IRQ parsing should
> be done at pcibios_add_device() either, so honestly we had to
> do with the information we have at hand.

Because at that time (September 2014) there was no pcibios_alloc_irq() =
(added
June 2015 by commit 890e4847587fcf) and after that nobody bothered to u=
pdate
the arm64 code to make use of the new API.

Best regards,
Liviu

>=20
> > I also notice that x86 and ia64 call acpi_pci_irq_enable() even lat=
er,
> > when the driver *enables* the device.  Is there a reason you didn't=
 do
> > it at the same time as x86 and ia64?  This is another of those pcib=
ios
> > hooks that really don't do anything arch-specific, so I can imagine
> > refactoring this somehow, someday.
>=20
> Yes, with [1], that was the goal, that stopped because [1] does not
> work on x86.
>=20
> Only DT platform(s) affected by this change are all platforms relying=
 on
> drivers/pci/host/pci-xgene.c (others rely on pci_fixup_irqs() that
> should be removed too), if on those platforms probing IRQs at device
> enable time works ok I can update this patch (it can be done through =
[1]
> once we figure out what to do with it on x86) and move the IRQ set-up=
 at
> pcibios_enable_device() time.
>=20
> @Duc: any feedback on this ?
>=20
> Thanks,
> Lorenzo
>=20
> [1] http://www.spinics.net/lists/linux-pci/msg45950.html
>=20
> > Did we have this conversation before?  It seems vaguely familiar, s=
o I
> > apologize if you already explained this once.
> >=20
> > > To solve this problem and consolidate FW PCI legacy IRQs parsing =
in
> > > one single pcibios callback (pending final removal), this patch m=
oves
> > > DT PCI IRQ parsing to the pcibios_alloc_irq() callback (called by
> > > PCI core code at device probe time) and adds ACPI PCI legacy IRQs
> > > parsing to the same callback too, so that FW PCI legacy IRQs pars=
ing
> > > is confined in one single arch callback that can be easily remove=
d
> > > when code parsing PCI legacy IRQs is consolidated and moved to co=
re
> > > PCI code.
> > >=20
> > > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > > Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > ---
> > >  arch/arm64/kernel/pci.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > > index d5d3d26..b3b8a2c 100644
> > > --- a/arch/arm64/kernel/pci.c
> > > +++ b/arch/arm64/kernel/pci.c
> > > @@ -51,11 +51,16 @@ int pcibios_enable_device(struct pci_dev *dev=
, int mask)
> > >  }
> > > =20
> > >  /*
> > > - * Try to assign the IRQ number from DT when adding a new device
> > > + * Try to assign the IRQ number when probing a new device
> > >   */
> > > -int pcibios_add_device(struct pci_dev *dev)
> > > +int pcibios_alloc_irq(struct pci_dev *dev)
> > >  {
> > > -	dev->irq =3D of_irq_parse_and_map_pci(dev, 0, 0);
> > > +	if (acpi_disabled)
> > > +		dev->irq =3D of_irq_parse_and_map_pci(dev, 0, 0);
> > > +#ifdef CONFIG_ACPI
> > > +	else
> > > +		return acpi_pci_irq_enable(dev);
> > > +#endif
> > > =20
> > >  	return 0;
> > >  }
> > > --=20
> > > 1.9.1
> > >=20
> >=20
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
