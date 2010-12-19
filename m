From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 8/9] x86: avoid E820 regions when allocating address
 space
Date: Sun, 19 Dec 2010 16:33:25 -0700
Message-ID: <20101219233325.GA2013@helgaas.com>
References: <20101216173614.8185.19462.stgit@bob.kio>
 <20101216173856.8185.98094.stgit@bob.kio>
 <AANLkTim68DbGeWbYKYx3_WOGFkA8KZFVHFyEFGtXt-cr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim68DbGeWbYKYx3_WOGFkA8KZFVHFyEFGtXt-cr@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 19, 2010 at 01:50:50AM -0800, Yinghai Lu wrote:
> On Thu, Dec 16, 2010 at 9:38 AM, Bjorn Helgaas <bjorn.helgaas@hp.com>=
 wrote:
> >
> > When we allocate address space, e.g., to assign it to a PCI device,=
 don't
> > allocate anything mentioned in the BIOS E820 memory map.
> >
> > On recent machines (2008 and newer), we assign PCI resources from t=
he
> > windows described by the ACPI PCI host bridge _CRS. =A0On many Dell
> > machines, these windows overlap some E820 reserved areas, e.g.,
> >
> > =A0 =A0BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
> > =A0 =A0pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xdf=
ffffff]
> >
> > If we put devices at 0xbff00000, they don't work, probably because
> > that's really RAM, not I/O memory. =A0This patch prevents that by r=
emoving
> > the 0xbfe4dc00-0xbfffffff area from the "available" resource.
> >
> > I'm not very happy with this solution because Windows solves the pr=
oblem
> > differently (it seems to ignore E820 reserved areas and it allocate=
s
> > top-down instead of bottom-up; details at comment 45 of the bugzill=
a
> > below). =A0That means we're vulnerable to BIOS defects that Windows=
 would not
> > trip over. =A0For example, if BIOS described a device in ACPI but d=
idn't
> > mention it in E820, Windows would work fine but Linux would fail.
> >
> > Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D16228
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > ---
> >
> > =A0arch/x86/kernel/resource.c | =A0 38 ++++++++++++++++++++++++++++=
+++++++++-
> > =A01 files changed, 37 insertions(+), 1 deletions(-)
> >
> >
> > diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.=
c
> > index 407a900..89638af 100644
> > --- a/arch/x86/kernel/resource.c
> > +++ b/arch/x86/kernel/resource.c
> > @@ -1,11 +1,47 @@
> > =A0#include <linux/ioport.h>
> > =A0#include <asm/e820.h>
> >
> > +static void resource_clip(struct resource *res, resource_size_t st=
art,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t e=
nd)
> > +{
> > + =A0 =A0 =A0 resource_size_t low =3D 0, high =3D 0;
> > +
> > + =A0 =A0 =A0 if (res->end < start || res->start > end)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return; =A0 =A0 =A0 =A0 /* no conflic=
t */
> > +
> > + =A0 =A0 =A0 if (res->start < start)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 low =3D start - res->start;
> > +
> > + =A0 =A0 =A0 if (res->end > end)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 high =3D res->end - end;
> > +
> > + =A0 =A0 =A0 /* Keep the area above or below the conflict, whichev=
er is larger */
> > + =A0 =A0 =A0 if (low > high)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end =3D start - 1;
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D end + 1;
> > +}
> > +
> > +static void remove_e820_regions(struct resource *avail)
> > +{
> > + =A0 =A0 =A0 int i;
> > + =A0 =A0 =A0 struct e820entry *entry;
> > +
> > + =A0 =A0 =A0 for (i =3D 0; i < e820.nr_map; i++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 entry =3D &e820.map[i];
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_clip(avail, entry->addr,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 entry->ad=
dr + entry->size - 1);
> > + =A0 =A0 =A0 }
> > +}
> > +
> > =A0void arch_remove_reservations(struct resource *avail)
> > =A0{
> > - =A0 =A0 =A0 /* Trim out BIOS area (low 1MB) */
> > + =A0 =A0 =A0 /* Trim out BIOS area (low 1MB) and E820 regions */
> > =A0 =A0 =A0 =A0if (avail->flags & IORESOURCE_MEM) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (avail->start < BIOS_END)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0avail->start =3D BIO=
S_END;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove_e820_regions(avail);
> > =A0 =A0 =A0 =A0}
> > =A0}
>=20
> that looks expensive. it will keep going through e820 tables...

It's expensive when we do it, but we do it very rarely, i.e., only
when we call allocate_resource().

> but e820 should have been reserved in resource tree...

E820 regions don't fit very well in the resource tree.  The
tree normally contains devices, which are mutually exclusive
and fit nicely in a hierarchy.

The E820 RAM regions fit that description (they can't conflict
with anything else).  But generic "reserved" regions do not.
A reserved region might cover several devices, it might cover
part of a device, it might cover a piece of RAM, or it might
not be related to a device at all.  We do try to wedge those
reservations into the resource tree, but I think that's a
mistake because it doesn't work very well.

In this case, the E820 reservation *is* in the resource tree,
but we took the reasonable 0xbfe4dc00 - 0xc0000000 E820 entry
and turned it into the bogus 0xbfe4dc00-0xf7ffffff range:

  bfe4dc00-f7ffffff reserved (expanded)
    bff00000-f7ffffff PCI Bus 0000:00

More details here:

  https://bugzilla.kernel.org/show_bug.cgi?id=3D16228#c45

Bjorn
