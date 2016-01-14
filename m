From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Date: Thu, 14 Jan 2016 09:09:59 -0500
Message-ID: <1452780599.28109.5.camel@redhat.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
	 <20160114134440.GA8520@xora-haswell.xora.org.uk>
	 <20160114140038.GE2071@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47169 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667AbcANOKC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 09:10:02 -0500
In-Reply-To: <20160114140038.GE2071@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>
Cc: Tomasz Nowicki <tn@semihalf.com>, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com, Lorenzo.Pieralisi@arm.com, ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, jcm@redhat.com, arnd@arndb.de, Stefano.Stabellini@eu.citrix.com, Liviu.Dudau@arm.com, bhelgaas@google.com, tglx@linutronix.de, mw@semihalf.com, linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, jiang.liu@linux.intel.com

On Thu, 2016-01-14 at 14:00 +0000, Catalin Marinas wrote:
> On Thu, Jan 14, 2016 at 01:44:40PM +0000, Graeme Gregory wrote:
> > On Wed, Jan 13, 2016 at 02:20:46PM +0100, Tomasz Nowicki wrote:
> > > From the functionality point of view this series might be split i=
nto the
> > > following logic parts:
> > > 1. Make MMCONFIG code arch-agnostic which allows all architecture=
s to collect
> > > =C2=A0=C2=A0=C2=A0PCI config regions and used when necessary.
> > > 2. Move non-arch specific bits to the core code.
> > > 3. Use MMCONFIG code and implement generic ACPI based PCI host co=
ntroller driver.
> > > 4. Enable above driver on ARM64
> > >=20
> > > Patches has been built on top of 4.4 and can be found here:
> > > git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
> > >=20
> > > NOTE, this patch set depends on Matthew's patches:
> > > http://www.spinics.net/lists/linux-pci/msg45950.html
> > > https://github.com/Vality/linux/tree/pci-fixes
> > >=20
> > > This has been tested on Cavium ThunderX server and QEMU.
> > > Any help in reviewing and testing is very appreciated.
> >=20
> > I have tested this on my AMD Overdrive so
> >=20
> > Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> >=20
> > But to actually get my r8169 network card working I also need the
> > following patch.
> >=20
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 2fbf840..40e24e2 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1717,7 +1717,7 @@ void pci_device_add(struct pci_dev *dev, stru=
ct pci_bus *bus)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set_dev_node(&dev->=
dev, pcibus_to_node(bus));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.dma_mask =3D=
 &dev->dma_mask;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.dma_parms =
=3D &dev->dma_parms;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.coherent_dma_ma=
sk =3D 0xffffffffull;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.coherent_dma_ma=
sk =3D DMA_BIT_MASK(64);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_dma_configure(d=
ev);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_set_dma_max_seg=
_size(dev, 65536);
>=20
> With OF, we get the coherent_dma_mask set by of_dma_configure(). But =
I
> have no idea how you do this with ACPI.
>=20
That doesn't get called for a PCI device (not listed in DT) does it?

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
