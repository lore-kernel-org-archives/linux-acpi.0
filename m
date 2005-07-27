From: Kristen Accardi <kristen.kml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Date: Wed, 27 Jul 2005 11:29:39 -0700
Message-ID: <512afbf905072711295f87ad24@mail.gmail.com>
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
	 <b115cb5f0507241949da02aa7@mail.gmail.com>
Reply-To: Kristen Accardi <kristen.kml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <b115cb5f0507241949da02aa7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Rajat Jain <rajat.noida.india-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-newbie-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-hotplug-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dkumar-QByN7dn/BetQWC9lL0RKGQC/G2K4zDHf@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 7/24/05, Rajat Jain <rajat.noida.india-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Tue, Jul 12, 2005 at 06:01:22PM +0900, Rajat Jain
> > wrote:
> >
> > > Hi,
> > >
> > > I'm trying to use the PCI Express Hot-Plug Controller driver
> > > (pciehp.ko) with Kernel 2.6 so that I can get hot-plug events
> > > whenever I add a card to my PCI Express slot.
> > >
> > > I built the driver as a module, and am trying to load it
> > > manually using modprobe. However, when trying to insert,
> > > I'm getting the following error:
> > >
> > > pciehp: acpi_pciehprm:\_SB.PCI0 _OSC fails=3D0x5
> > > pciehp: Both _OSC and OSHP methods do not exist
> > > FATAL: Error inserting pciehp
> > >
> > > (/lib/modules/2.6.9-5.18AXcustom-hotplug/kernel/drivers/pci/hotplug/p=
ciehp.ko):
> > > No such device
> > >
>=20
> > --- Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> > Your bios does not support pci express hotplug.  Are
> > you sure you have pci express hotplug hardware in your
> > system?  If so, contact your bios vendor to get an
> > updated version.
> >
> > Good luck,
> >
> >  greg k-h
>=20
> Thanks for replying Greg. I checked again, I have the hardware in my
> system. I asked the vendor for bios update, but he says mine is the
> latest version.
>=20
> I downloaded the Intel "iasl" compiler
> (http://developer.intel.com/technology/iapc/acpi/downloads.htm),  and
> used it to decompile "/proc/acpi/dsdt" file (in AML) to its equivalent
> ACPI source code. I could not find the _OSC and OSHP control methods
> there. Is this information sufficient enough to deduce that I need a
> BIOS update? And the hardware is OK but the problem is with the bios?
>=20
> Just out of curosity, I would appreciate if you could provide me
> pointers to OSHP and _OSC methods. What exactly do they mean? Does
> every hardware containing a hot-plug controller necessarily has to
> implement them both? I checked with ACPI Specs but it contains no
> refrence to "OSHP" method.
>=20
> Any pointers are more than appreciated,
>=20
> TIA,
>=20
> Rajat

Hi Rajat, you can learn more about the OSHP method by reading the PCI
express spec.  It is used to tell an ACPI bios that the OS will be
handling the hotplug events natively.  It may be that your BIOS does
not allow native hotplug for pcie, in which case you need to be using
the acpiphp driver instead of the pciehp driver.  You could just try
modprobing acpiphp and see if this will handle the hotplug events.  A
recent version of lspci (which understands pcie) will tell you as well
if pcie hotplug capability is supported (lspci -vv).

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
