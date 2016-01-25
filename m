From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH V3 18/21] ACPI, PCI: Refine the way to handle
 translation_offset for ACPI resources
Date: Mon, 25 Jan 2016 11:57:46 -0500
Message-ID: <1453741066.28109.117.camel@redhat.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
	 <1452691267-32240-19-git-send-email-tn@semihalf.com>
	 <20160119122026.GA5185@red-moon> <20160125095252.GB32652@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35351 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932259AbcAYQ5v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jan 2016 11:57:51 -0500
In-Reply-To: <20160125095252.GB32652@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>, jiang.liu@linux.intel.com
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, okaya@codeaurora.org, Stefano.Stabellini@eu.citrix.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com

On Mon, 2016-01-25 at 09:52 +0000, Lorenzo Pieralisi wrote:
> On Tue, Jan 19, 2016 at 12:20:26PM +0000, Lorenzo Pieralisi wrote:
> > Gerry,
> >=20
> > On Wed, Jan 13, 2016 at 02:21:04PM +0100, Tomasz Nowicki wrote:
> > > From: Liu Jiang <jiang.liu@linux.intel.com>
> > >=20
> > > Some architectures, such as IA64 and ARM64, have no instructions =
to
> > > directly access PCI IO ports, so they map PCI IO ports into PCI M=
MIO
> > > address space. Typically PCI host bridges on those architectures =
take
> > > the responsibility to map (translate) PCI IO port transactions in=
to
> > > Memory-Mapped IO transactions. ACPI specification provides suppor=
t
> > > of such a usage case by using resource translation_offset.
> > >=20
> > > But current ACPI resource parsing interface isn't neutral enough,
> > > it still has some special logic for IA64. So refine the ACPI reso=
urce
> > > parsing interface and IA64 code to neutrally handle translation_o=
ffset
> > > by:
> > > 1) ACPI resource parsing interface doesn't do any translation, it=
 just
> > > =C2=A0=C2=A0=C2=A0save the translation_offset to be used by arch =
code.
> > > 2) Arch code will do the mapping(translation) based on arch speci=
fic
> > > =C2=A0=C2=A0=C2=A0information. Typically it does:
> > > 2.a) Translate per PCI domain IO port address space into system g=
lobal
> > > =C2=A0=C2=A0=C2=A0IO port address space.
> > > 2.b) Setup MMIO address mapping for IO ports.
> >=20
> > This patch fixes IO space handling on IA64 and should go in as a fi=
x.
> >=20
> > IA64 PCI IO space is currently broken (Hanjun tested this on an IA6=
4 box).
> >=20
> > The first broken commit is:
> >=20
> > 3772aea7d6f3 ("ia64/PCI/ACPI: Use common ACPI resource parsing inte=
rface for host bridge")
> >=20
> > because acpi core code checks (in acpi_dev_ioresource_flags()) the
> > resource.end>=3D0x10003, which fails on ia64 - currently resource.e=
nd is
> > set in acpi_decode_space() to:
> >=20
> > AddressMaximum + AddressTranslation
> >=20
> > where AddressTranslation is the CPU physical address mapping IO spa=
ce
> > on IA64, the >=3D0x10003 check in acpi_dev_ioresource_flags always
> > triggers and the IO resource is then disabled.
> >=20
> > Do you want me to re-send this patch as a fix, with updated commit =
log ?
>=20
> Two more points to discuss here. IA64, in its prepare_resources() cal=
lback
> calls acpi_pci_probe_root_resources() in turn. That function parses t=
he
> _CRS and validate the resources (acpi_pci_root_validate_resources()).
>=20
> That does not make sense IMO, because IA64 changes the IO port resour=
ces
> after calling acpi_pci_probe_root_resources(), hence the validation
> carried out in acpi_pci_probe_root_resources(), at least for IO ports
> seems wrong (what's the point of validating the CRS against
> ioport_resource if we change the _CRS IO space resources afterwards ?=
).
>=20

I agree that acpi_pci_root_validate_resources() is doing the wrong thin=
g
generally. The current code (without this patch series) is checking CPU
bus address range for PCI IO window against ioport_resource which is ba=
sed
on ioport cookies made up by the kernel. This patch takes out the addit=
ion
of the translation offset so the check is now PCI bus io address range
validated against the cookies in ioport_resource. I think that works by
chance because all ia64 PCI segments use the same PCI bus io address
range based at zero. So the PCI bus io addresses will always look valid
against ia64 IO space zero in the ioport_resource list. The PCI ioports
actually get installed after ia64 changes the resource to hold the
cookie. Interestingly, ia64 also installs an iomem resource for the CPU
bus address of the ioport range window. The generic ACPI PCI host=C2=A0
code should probably do the same in pci_acpi_root_prepare_resource().
And at some point, it might make sense to consolidate the ia64 ioport
cookie handling with that done by the devicetree interfaces used by
the generic ACPI PCI host code.

> Second point: we are aware that by removing the offset addition in
> acpi_decode_space(), if for any reason on x86 or IA64 a resource has
> that offset !=3D0 (speaking in terms of memory resources for instance=
)
> we are in trouble. Jiang mentioned that on x86 and IA64 offset is alw=
ays
> 0x0 for memory resources, but just want to make sure we are all aware
> of this potential pitfall.

I think that has always been the case. At least for x86 which doesn't
appear to have ever used the offset in _CRS. In any case, it still
leaves us with the same problem where acpi_pci_root_validate_resources(=
)
is validating PCI bus addresses against something different (cookies/cp=
u
iospace for ioport, CPU bus for iomem).

>=20
> Comments appreciated, it is time to a) fix IA64 and b) get this _CRS
> parsing consolidation done.
>=20
> Thanks,
> Lorenzo

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
