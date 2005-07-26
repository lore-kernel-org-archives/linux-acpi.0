From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: ACPI hot-plug notification help needed
Date: Tue, 26 Jul 2005 13:56:08 -0600
Message-ID: <200507261356.08152.bjorn.helgaas@hp.com>
References: <200507251735.23394.bjorn.helgaas@hp.com> <20050725173911.A24040@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050725173911.A24040-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
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
To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 25 July 2005 6:39 pm, Keshavamurthy Anil S wrote:
> On Mon, Jul 25, 2005 at 05:35:23PM -0600, Bjorn Helgaas wrote:
> > Can somebody explain how the notification stuff in the ACPI
> > memory and container drivers works?
> Sure.

Thanks for your useful response!

> During system boot the ACPI core scans for all the devices 
> in its root namespace scope i.e by calling acpi_bus_scan() 
> and for each device whose _STA is present calls acpi_bus_add() 
> which stores the device in linked list. Later when ACPI driver 
> registers its IDs the ACPI core just looks in this device list.
> The core does not keep track of devices whose _STA became present
> after boot.

Is this the way you think it *should* work, or just the way it
happens to work today?  Certainly PCI doesn't work this way --
the driver may register at boot-time, but when a new device is
added later via hot-plug, the hot-plug infrastructure arranges
to call the driver's probe() method.

> This is how the ACPI core expects us to register for all the devices
> for which we care notifications. We want to register for all the devices
> i.e for the devices which are present and for devices which are not present.
> To do this we walk the entire namespace scope and check for _HID or _CID
> match and register a notify handler for this device.

If we really have to do this, should we change things around so
an ACPI driver can request that its add() method be called
for non-present devices as well as present ones?  That would
at least centralize all the _HID/_CID checking and remove the
namespace walks from the drivers.

> > It seems strange to attach notify handlers to devices that are
> > not present.  Maybe ACPI allows events to be sent to devices that
> > don't exist, but it just seems weird.  I'd expect a hotplug add to
> 
> When we were implementing this even for us it looked strange that
> we have to attach a notify handlers for each and every device. Believe
> me this is how we had to do.
> 
> > cause events to some previously-present *parent* of the new device.
> > The parent's driver could then re-scan its children and add any
> > that are newly-added or newly-marked "present".
> 
> This might not alway be true. Some f/w might not want to send
> notification on the parent as the re-scan might be a costly operation
> as the parent might contain a large number of children. Imaging a case
> where we want to attach a device under _SB scope, in case if the 
> notification went to _SB and we have rescan the whole namespace here.

Yes, I now see that the spec[3] allows the notify to go to either
the new device itself, or to some parent of the new device, such
as the bus the new device is on.  The first case seems like muddled
thinking to me, but I guess we're now stuck with having to support
it.  But I still don't like it :-)

The current scheme of attaching notify handlers only works if
every possible device is present in the namespace at the time
the driver is loaded.  Is there a requirement in the spec for
this?  I could imagine a hot-add event using LoadTable() to
add new devices to the namespace before notifying the parent
bus.  Is there code somewhere in ACPI to re-scan the bus and
attach drivers?

> [Those] drivers which support hotplug are responsible for registering
> for a notification and based on the notification they have to call
> acpi_bus_add() to add the device and from then on the acpi_bus_add()
> function takes care of doing rest of the stuff including calling
> add() function of the driver.

This is much different from the PCI philosophy, where new-style
drivers handle hot-plug seamlessly.  I think ACPI should move in
that direction.  The current style is clunky and error-prone.

> > Does ACPI
> > have to supply nodes for every possible hot-pluggable device in
> > the namespace at boot-time, just to provide places to hang these
> > handlers?
> Yes, the ACPI namespace has to list its max possible configuration
> in its namespace.

That seems broken.  Does the spec actually require this somewhere?
I can understand that some firmware might want to have the max
possible configuration at boot, but it seems like there ought to
be the option to do it dynamically.

> > [2] This match is not as completely implemented as that in the
> >     ACPI core, so it doesn't check _CID.  So this seems like a
> >     case where duplication of functionality leads to maintenance
> >     problems.  Compare is_root_bridge(), is_memory_device(), and
> >     container_walk_namespace_cb().
> Patch welcome:-)

OK, as soon as I understand better what's going on, I'll work on that :-)

[3] ACPI 3.0 spec, section 6.3.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
