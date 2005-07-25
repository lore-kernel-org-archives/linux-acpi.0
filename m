From: Rajat Jain <rajat.noida.india-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Date: Mon, 25 Jul 2005 11:49:22 +0900
Message-ID: <b115cb5f0507241949da02aa7@mail.gmail.com>
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
Reply-To: Rajat Jain <rajat.noida.india-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050725021747.67869.qmail-6mNr3ekj/EivuULXzWHTWIglqE1Y4D90QQ4Iyu8u01E@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: rajat.noida.india-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-newbie-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-hotplug-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dkumar-QByN7dn/BetQWC9lL0RKGQC/G2K4zDHf@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> On Tue, Jul 12, 2005 at 06:01:22PM +0900, Rajat Jain
> wrote:
>
> > Hi,
> >=20
> > I'm trying to use the PCI Express Hot-Plug Controller driver
> > (pciehp.ko) with Kernel 2.6 so that I can get hot-plug events=20
> > whenever I add a card to my PCI Express slot.
> >=20
> > I built the driver as a module, and am trying to load it=20
> > manually using modprobe. However, when trying to insert,
> > I'm getting the following error:
> >
> > pciehp: acpi_pciehprm:\_SB.PCI0 _OSC fails=3D0x5
> > pciehp: Both _OSC and OSHP methods do not exist
> > FATAL: Error inserting pciehp
> >
> > (/lib/modules/2.6.9-5.18AXcustom-hotplug/kernel/drivers/pci/hotplug/pci=
ehp.ko):
> > No such device
> >

> --- Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> Your bios does not support pci express hotplug.  Are
> you sure you have pci express hotplug hardware in your
> system?  If so, contact your bios vendor to get an=20
> updated version.
>=20
> Good luck,
>=20
>  greg k-h

Thanks for replying Greg. I checked again, I have the hardware in my
system. I asked the vendor for bios update, but he says mine is the
latest version.

I downloaded the Intel "iasl" compiler
(http://developer.intel.com/technology/iapc/acpi/downloads.htm),  and
used it to decompile "/proc/acpi/dsdt" file (in AML) to its equivalent
ACPI source code. I could not find the _OSC and OSHP control methods
there. Is this information sufficient enough to deduce that I need a
BIOS update? And the hardware is OK but the problem is with the bios?

Just out of curosity, I would appreciate if you could provide me
pointers to OSHP and _OSC methods. What exactly do they mean? Does
every hardware containing a hot-plug controller necessarily has to
implement them both? I checked with ACPI Specs but it contains no
refrence to "OSHP" method.

Any pointers are more than appreciated,

TIA,

Rajat


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
