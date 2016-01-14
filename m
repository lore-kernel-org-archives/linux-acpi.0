From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Date: Thu, 14 Jan 2016 09:59:57 -0500
Message-ID: <1452783597.28109.12.camel@redhat.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
	 <20160114134440.GA8520@xora-haswell.xora.org.uk>
	 <20160114140038.GE2071@e104818-lin.cambridge.arm.com>
	 <1452780599.28109.5.camel@redhat.com>
	 <20160114145010.GF2071@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20160114145010.GF2071@e104818-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com, Lorenzo.Pieralisi@arm.com, Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, jcm@redhat.com, arnd@arndb.de, Stefano.Stabellini@eu.citrix.com, Liviu.Dudau@arm.com, bhelgaas@google.com, tglx@linutronix.de, mw@semihalf.com, linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, jiang.liu@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On Thu, 2016-01-14 at 14:50 +0000, Catalin Marinas wrote:
> On Thu, Jan 14, 2016 at 09:09:59AM -0500, Mark Salter wrote:
> > On Thu, 2016-01-14 at 14:00 +0000, Catalin Marinas wrote:
> > > On Thu, Jan 14, 2016 at 01:44:40PM +0000, Graeme Gregory wrote:
> > > > On Wed, Jan 13, 2016 at 02:20:46PM +0100, Tomasz Nowicki wrote:
> > > > > From the functionality point of view this series might be spl=
it into the
> > > > > following logic parts:
> > > > > 1. Make MMCONFIG code arch-agnostic which allows all architec=
tures to collect
> > > > > =C2=A0=C2=A0=C2=A0PCI config regions and used when necessary.
> > > > > 2. Move non-arch specific bits to the core code.
> > > > > 3. Use MMCONFIG code and implement generic ACPI based PCI hos=
t controller driver.
> > > > > 4. Enable above driver on ARM64
> > > > >=20
> > > > > Patches has been built on top of 4.4 and can be found here:
> > > > > git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3=
)
> > > > >=20
> > > > > NOTE, this patch set depends on Matthew's patches:
> > > > > http://www.spinics.net/lists/linux-pci/msg45950.html
> > > > > https://github.com/Vality/linux/tree/pci-fixes
> > > > >=20
> > > > > This has been tested on Cavium ThunderX server and QEMU.
> > > > > Any help in reviewing and testing is very appreciated.
> > > >=20
> > > > I have tested this on my AMD Overdrive so
> > > >=20
> > > > Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> > > >=20
> > > > But to actually get my r8169 network card working I also need t=
he
> > > > following patch.
> > > >=20
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index 2fbf840..40e24e2 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -1717,7 +1717,7 @@ void pci_device_add(struct pci_dev *dev, =
struct pci_bus *bus)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set_dev_node(&d=
ev->dev, pcibus_to_node(bus));
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.dma_ma=
sk =3D &dev->dma_mask;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.dma_pa=
rms =3D &dev->dma_parms;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.coherent_dm=
a_mask =3D 0xffffffffull;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.coherent_dm=
a_mask =3D DMA_BIT_MASK(64);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_dma_configu=
re(dev);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_set_dma_max=
_seg_size(dev, 65536);
> > >=20
> > > With OF, we get the coherent_dma_mask set by of_dma_configure(). =
But I
> > > have no idea how you do this with ACPI.
> >=20
> > That doesn't get called for a PCI device (not listed in DT) does it=
?
>=20
> pci_device_add
> =C2=A0 pci_dma_configure
> =C2=A0=C2=A0=C2=A0=C2=A0of_dma_configure(&dev->dev, bridge->parent->o=
f_node);
>=20
> So it gets configured based on the bridge information the device is
> attached to.
>=20

Oh right. And there is an ACPI path in pci_dma_configure but it only se=
ts the
coherency. But I still don't know why Graeme is having issues. I just t=
ried
an r8169 card on Mustang and Seattle with this patch series in a 4.4 ke=
rnel
and it worked fine with r8169.use_dac=3D1.
