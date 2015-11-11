From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
Date: Wed, 11 Nov 2015 18:12:07 +0000
Message-ID: <20151111181207.GU963@e106497-lin.cambridge.arm.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <5640A8AA.4000806@semihalf.com>
 <20151109171042.GA11909@red-moon>
 <6488357.xJV65iBRHq@wuerfel>
 <564185B6.8040006@linux.intel.com>
 <20151111174647.GA30051@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32881 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbbKKSMJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Nov 2015 13:12:09 -0500
Content-Disposition: inline
In-Reply-To: <20151111174647.GA30051@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

On Wed, Nov 11, 2015 at 05:46:47PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Nov 10, 2015 at 01:50:46PM +0800, Jiang Liu wrote:
>=20
> [...]
>=20
> > >> In particular, I would like to understand, for an eg DWordIO des=
criptor,
> > >> what Range Minimum, Range Maximum and Translation Offset represe=
nt,
> > >> they can't mean different things depending on the SW parsing the=
m,
> > >> this totally defeats the purpose.
> > >=20
> > > I have no clue about what those mean in ACPI though.
> > >=20
> > > Generally speaking, each PCI domain is expected to have a (normal=
ly 64KB)
> > > range of CPU addresses that gets translated into PCI I/O space th=
e same
> > > way that config space and memory space are handled.
> > > This is true for almost every architecture except for x86, which =
uses
> > > different CPU instructions for I/O space compared to the other sp=
aces.
> > >=20
> > >> By the way, ia64 ioremaps the translation_offset (ie new_space()=
), so
> > >> basically that's the CPU physical address at which the PCI host =
bridge
> > >> map the IO space transactions), I do not think ia64 is any diffe=
rent from
> > >> arm64 in this respect, if it is please provide an HW description=
 here from
> > >> the PCI bus perspective here (also an example of ia64 ACPI PCI h=
ost bridge
> > >> tables would help).
> > >=20
> > > The main difference between ia64 and a lot of the other architect=
ures (e.g.
> > > sparc is different again) is that ia64 defines a logical address =
range
> > > in terms of having a small number for each I/O space followed by =
the
> > > offset within that space as a 'port number' and uses a mapping fu=
nction
> > > that is defined as
> > >=20
> > > static inline void *__ia64_mk_io_addr (unsigned long port)
> > > {
> > >         struct io_space *space =3D &io_space[IO_SPACE_NR(port)];
> > >         return (space->mmio_base | IO_SPACE_PORT(port););
> > > }
> > > static inline unsigned int inl(unsigned long port)
> > > {
> > >         return *__ia64_mk_io_addr(port);
> > > }
> > >=20
> > > Most architectures allow only one I/O port range and put it at a =
fixed
> > > virtual address so that inl() simply becomes=20
> > >=20
> > > static inline u32 inl(unsigned long addr)
> > > {
> > >         return readl(PCI_IOBASE + addr);
> > > }
> > >=20
> > > which noticeably reduces code size.
> > >=20
> > > On some architectures (powerpc, arm, arm64), we then get the same=
 simplified
> > > definition with a fixed virtual address, and use pci_ioremap_io()=
 or
> > > something like that to to map a physical address range into this =
virtual
> > > address window at the correct io_offset;
> > Hi all,
> > 	Thanks for explanation, I found a way to make the ACPI resource
> > parsing interface arch neutral, it should help to address Lorenzo's
> > concern. Please refer to the attached patch. (It's still RFC, not t=
ested
> > yet).
>=20
> If we go with this approach though, you are not adding the offset to
> the resource when parsing the memory spaces in acpi_decode_space(), a=
re we
> sure that's what we really want ?
>=20
> In DT, a host bridge range has a:
>=20
> - CPU physical address
> - PCI bus address
>=20
> We use that to compute the offset between primary bus (ie CPU physica=
l
> address) and secondary bus (ie PCI bus address).
>=20
> The value ending up in the PCI resource struct (for memory space) is
> the CPU physical address, if you do not add the offset in acpi_decode=
_space
> that does not hold true on platforms where CPU<->PCI offset !=3D 0 on=
 ACPI,
> am I wrong ?
>=20
> Overall I think the point is related to ioport_resource and its check
> in acpi_pci_root_validate_resources() which basically that's the
> problem that started this thread.
>=20
> On arm64, IO_SPACE_LIMIT is 16M, which, AFAIK is a kernel limit, not
> a HW one.=20

You're right, it is a kernel limit. There is no HW limit for IO on arm6=
4.

> Comparing the resources parsed from the PCI bridge _CRS against
> the range 0..IO_SPACE_LIMIT is not necessarily meaningful (or at leas=
t
> not meaningful in its current form), on ia64 it works because IO_SPAC=
E_LIMIT
> is bumped up to 4G, that's the reason why adding the offset to the AC=
PI IO
> resources work on ia64 as far as I understand.
>=20
> And that's why I pulled Arnd in this discussion since he knows better
> than me: what does ioport_resource _really_ represent on ARM64 ? It s=
eems
> to me that it is a range of IO ports values (ie a window that defines
> the allowed offset in the virtual address space allocated to PCI IO) =
that
> has _nothing_ to do with the CPU physical address at which the IO spa=
ce is
> actually mapped.

Correct. The idea is that you can have any number of host bridges and w=
hat
you get back for an ioport_resource is a window inside the host bridge =
IO
space. That space is also offset-ed inside the kernel's IO port space
(0..IO_SPACE_LIMIT) by the amount of space already taken by preceeding
host bridges, so that two ioport_resources comming from two different
host bridges don't overlap in the CPU address space.

Best regards,
Liviu


>=20
> To sum it up for a, say, DWordIo/Memory descriptor:
>=20
> - AddressMinimum, AddressMaximum represent the PCI bus addresses defi=
ning
>   the resource start..end
> - AddressTranslation is the offset that has to be added to AddressMin=
imum
>   and AddressMaximum to get the window in CPU physical address space
>=20
> So:
>=20
> - Either we go with the patch attached (but please check my comment o=
n
>   the memory spaces)
> - Or we patch acpi_pci_root_validate_resources() to amend the way
>   IORESOURCE_IO is currently checked against ioport_resource, it can'=
t
>   work on arm64 at present, I described why above
>=20
> Thoughts appreciated it is time we got this sorted and thanks for
> the patch.
>=20
> Thanks,
> Lorenzo
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
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
