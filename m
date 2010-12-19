From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 8/9] x86: avoid E820 regions when allocating address space
Date: Sun, 19 Dec 2010 01:50:50 -0800
Message-ID: <AANLkTim68DbGeWbYKYx3_WOGFkA8KZFVHFyEFGtXt-cr@mail.gmail.com>
References: <20101216173614.8185.19462.stgit@bob.kio>
	<20101216173856.8185.98094.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20101216173856.8185.98094.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 16, 2010 at 9:38 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> w=
rote:
>
> When we allocate address space, e.g., to assign it to a PCI device, d=
on't
> allocate anything mentioned in the BIOS E820 memory map.
>
> On recent machines (2008 and newer), we assign PCI resources from the
> windows described by the ACPI PCI host bridge _CRS. =A0On many Dell
> machines, these windows overlap some E820 reserved areas, e.g.,
>
> =A0 =A0BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
> =A0 =A0pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xdfff=
ffff]
>
> If we put devices at 0xbff00000, they don't work, probably because
> that's really RAM, not I/O memory. =A0This patch prevents that by rem=
oving
> the 0xbfe4dc00-0xbfffffff area from the "available" resource.
>
> I'm not very happy with this solution because Windows solves the prob=
lem
> differently (it seems to ignore E820 reserved areas and it allocates
> top-down instead of bottom-up; details at comment 45 of the bugzilla
> below). =A0That means we're vulnerable to BIOS defects that Windows w=
ould not
> trip over. =A0For example, if BIOS described a device in ACPI but did=
n't
> mention it in E820, Windows would work fine but Linux would fail.
>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D16228
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>
> =A0arch/x86/kernel/resource.c | =A0 38 ++++++++++++++++++++++++++++++=
+++++++-
> =A01 files changed, 37 insertions(+), 1 deletions(-)
>
>
> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index 407a900..89638af 100644
> --- a/arch/x86/kernel/resource.c
> +++ b/arch/x86/kernel/resource.c
> @@ -1,11 +1,47 @@
> =A0#include <linux/ioport.h>
> =A0#include <asm/e820.h>
>
> +static void resource_clip(struct resource *res, resource_size_t star=
t,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t end=
)
> +{
> + =A0 =A0 =A0 resource_size_t low =3D 0, high =3D 0;
> +
> + =A0 =A0 =A0 if (res->end < start || res->start > end)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return; =A0 =A0 =A0 =A0 /* no conflict =
*/
> +
> + =A0 =A0 =A0 if (res->start < start)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 low =3D start - res->start;
> +
> + =A0 =A0 =A0 if (res->end > end)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 high =3D res->end - end;
> +
> + =A0 =A0 =A0 /* Keep the area above or below the conflict, whichever=
 is larger */
> + =A0 =A0 =A0 if (low > high)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end =3D start - 1;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D end + 1;
> +}
> +
> +static void remove_e820_regions(struct resource *avail)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct e820entry *entry;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < e820.nr_map; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 entry =3D &e820.map[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_clip(avail, entry->addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 entry->addr=
 + entry->size - 1);
> + =A0 =A0 =A0 }
> +}
> +
> =A0void arch_remove_reservations(struct resource *avail)
> =A0{
> - =A0 =A0 =A0 /* Trim out BIOS area (low 1MB) */
> + =A0 =A0 =A0 /* Trim out BIOS area (low 1MB) and E820 regions */
> =A0 =A0 =A0 =A0if (avail->flags & IORESOURCE_MEM) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (avail->start < BIOS_END)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0avail->start =3D BIOS_=
END;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove_e820_regions(avail);
> =A0 =A0 =A0 =A0}
> =A0}

that looks expensive. it will keep going through e820 tables...

but e820 should have been reserved in resource tree...

So why we need to check e820 again?

Yinghai
