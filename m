From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Date: Thu, 14 Jan 2016 09:24:41 -0500
Message-ID: <1452781481.28109.8.camel@redhat.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
	 <20160114134440.GA8520@xora-haswell.xora.org.uk>
	 <1452780100.28109.3.camel@redhat.com>
	 <20160114141501.GC8520@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20160114141501.GC8520@xora-haswell.xora.org.uk>
Sender: linux-pci-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Tomasz Nowicki <tn@semihalf.com>, linaro-acpi@lists.linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com, Lorenzo.Pieralisi@arm.com, ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, linux-pci@vger.kernel.org, jcm@redhat.com, arnd@arndb.de, Stefano.Stabellini@eu.citrix.com, Liviu.Dudau@arm.com, bhelgaas@google.com, tglx@linutronix.de, mw@semihalf.com, linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, jiang.liu@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On Thu, 2016-01-14 at 14:15 +0000, Graeme Gregory wrote:
> On Thu, Jan 14, 2016 at 09:01:40AM -0500, Mark Salter wrote:
> > On Thu, 2016-01-14 at 13:44 +0000, Graeme Gregory wrote:
> > > On Wed, Jan 13, 2016 at 02:20:46PM +0100, Tomasz Nowicki wrote:
> > > > From the functionality point of view this series might be split=
 into the
> > > > following logic parts:
> > > > 1. Make MMCONFIG code arch-agnostic which allows all architectu=
res to collect
> > > > =C2=A0=C2=A0=C2=A0PCI config regions and used when necessary.
> > > > 2. Move non-arch specific bits to the core code.
> > > > 3. Use MMCONFIG code and implement generic ACPI based PCI host =
controller driver.
> > > > 4. Enable above driver on ARM64
> > > >=20
> > > > Patches has been built on top of 4.4 and can be found here:
> > > > git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
> > > >=20
> > > > NOTE, this patch set depends on Matthew's patches:
> > > > http://www.spinics.net/lists/linux-pci/msg45950.html
> > > > https://github.com/Vality/linux/tree/pci-fixes
> > > >=20
> > > > This has been tested on Cavium ThunderX server and QEMU.
> > > > Any help in reviewing and testing is very appreciated.
> > >=20
> > > I have tested this on my AMD Overdrive so
> > >=20
> > > Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> > >=20
> > > But to actually get my r8169 network card working I also need the
> > > following patch.
> > >=20
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 2fbf840..40e24e2 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1717,7 +1717,7 @@ void pci_device_add(struct pci_dev *dev, st=
ruct pci_bus *bus)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set_dev_node(&dev=
->dev, pcibus_to_node(bus));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.dma_mask=
 =3D &dev->dma_mask;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.dma_parm=
s =3D &dev->dma_parms;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.coherent_dma_=
mask =3D 0xffffffffull;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.coherent_dma_=
mask =3D DMA_BIT_MASK(64);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_dma_configure=
(dev);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_set_dma_max_s=
eg_size(dev, 65536);
> > >=20
> > > I suspect we need to set coherent_dma_mask somewhere in the platf=
orm but I do
> > > not know where this should happen. Hopefully an ARM64 expert can =
help.
> >=20
> > I've run into a number of cards which don't work on some arm64 mach=
ines where there are
> > no DMA address below 4G. For the realtek card you can use r8169.use=
_dac=3D1 on the cmdline
> > to get it to work.
> >=20
> I need r8169.use_dac=3D1 and this patch to get card to work.
>=20

Hmm. I didn't need a patch in the past but I don't think I've used that=
 card with
this patch series. I will try that when I get a chance...

> Graeme
>=20
