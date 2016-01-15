From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Date: Fri, 15 Jan 2016 12:12:31 +0000
Message-ID: <20160115121231.GD8520@xora-haswell.xora.org.uk>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <20160114134440.GA8520@xora-haswell.xora.org.uk>
 <1452780100.28109.3.camel@redhat.com>
 <20160114141501.GC8520@xora-haswell.xora.org.uk>
 <1452781481.28109.8.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1452781481.28109.8.camel@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Salter <msalter@redhat.com>
Cc: linaro-acpi@lists.linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com, Lorenzo.Pieralisi@arm.com, Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, linux-pci@vger.kernel.org, jcm@redhat.com, arnd@arndb.de, Stefano.Stabellini@eu.citrix.com, Liviu.Dudau@arm.com, bhelgaas@google.com, tglx@linutronix.de, mw@semihalf.com, linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, jiang.liu@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 14, 2016 at 09:24:41AM -0500, Mark Salter wrote:
> On Thu, 2016-01-14 at 14:15 +0000, Graeme Gregory wrote:
> > On Thu, Jan 14, 2016 at 09:01:40AM -0500, Mark Salter wrote:
> > > On Thu, 2016-01-14 at 13:44 +0000, Graeme Gregory wrote:
> > > > On Wed, Jan 13, 2016 at 02:20:46PM +0100, Tomasz Nowicki wrote:
> > > > > From the functionality point of view this series might be split i=
nto the
> > > > > following logic parts:
> > > > > 1. Make MMCONFIG code arch-agnostic which allows all architecture=
s to collect
> > > > > =A0=A0=A0PCI config regions and used when necessary.
> > > > > 2. Move non-arch specific bits to the core code.
> > > > > 3. Use MMCONFIG code and implement generic ACPI based PCI host co=
ntroller driver.
> > > > > 4. Enable above driver on ARM64
> > > > > =

> > > > > Patches has been built on top of 4.4 and can be found here:
> > > > > git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
> > > > > =

> > > > > NOTE, this patch set depends on Matthew's patches:
> > > > > http://www.spinics.net/lists/linux-pci/msg45950.html
> > > > > https://github.com/Vality/linux/tree/pci-fixes
> > > > > =

> > > > > This has been tested on Cavium ThunderX server and QEMU.
> > > > > Any help in reviewing and testing is very appreciated.
> > > > =

> > > > I have tested this on my AMD Overdrive so
> > > > =

> > > > Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> > > > =

> > > > But to actually get my r8169 network card working I also need the
> > > > following patch.
> > > > =

> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index 2fbf840..40e24e2 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -1717,7 +1717,7 @@ void pci_device_add(struct pci_dev *dev, stru=
ct pci_bus *bus)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0set_dev_node(&dev->dev, pcibus_to_node(bus)=
);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0dev->dev.dma_mask =3D &dev->dma_mask;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0dev->dev.dma_parms =3D &dev->dma_parms;
> > > > -=A0=A0=A0=A0=A0=A0=A0dev->dev.coherent_dma_mask =3D 0xffffffffull;
> > > > +=A0=A0=A0=A0=A0=A0=A0dev->dev.coherent_dma_mask =3D DMA_BIT_MASK(6=
4);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0pci_dma_configure(dev);
> > > > =

> > > > =A0=A0=A0=A0=A0=A0=A0=A0pci_set_dma_max_seg_size(dev, 65536);
> > > > =

> > > > I suspect we need to set coherent_dma_mask somewhere in the platfor=
m but I do
> > > > not know where this should happen. Hopefully an ARM64 expert can he=
lp.
> > > =

> > > I've run into a number of cards which don't work on some arm64 machin=
es where there are
> > > no DMA address below 4G. For the realtek card you can use r8169.use_d=
ac=3D1 on the cmdline
> > > to get it to work.
> > > =

> > I need r8169.use_dac=3D1 and this patch to get card to work.
> > =

> =

> Hmm. I didn't need a patch in the past but I don't think I've used that c=
ard with
> this patch series. I will try that when I get a chance...
> =


>From my previous debugging on this issue I was getting an address bigger
than 32bits. As r8169 is a whole range of chips are guess they are not
all equal?

I can stick debug stuff in if someone tells me where to put them.

Graeme
