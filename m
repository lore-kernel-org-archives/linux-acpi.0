From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hot-plug notification help needed
Date: Tue, 26 Jul 2005 17:05:00 -0700
Message-ID: <20050726170459.A5591@unix-os.sc.intel.com>
References: <200507251735.23394.bjorn.helgaas@hp.com> <20050725173911.A24040@unix-os.sc.intel.com> <200507261356.08152.bjorn.helgaas@hp.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200507261356.08152.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>; from bjorn.helgaas-VXdhtT5mjnY@public.gmane.org on Tue, Jul 26, 2005 at 01:56:08PM -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 26, 2005 at 01:56:08PM -0600, Bjorn Helgaas wrote:
> > During system boot the ACPI core scans for all the devices 
> > in its root namespace scope i.e by calling acpi_bus_scan() 
> > and for each device whose _STA is present calls acpi_bus_add() 
> > which stores the device in linked list. Later when ACPI driver 
> > registers its IDs the ACPI core just looks in this device list.
> > The core does not keep track of devices whose _STA became present
> > after boot.
> 
> Is this the way you think it *should* work, or just the way it
> happens to work today?  Certainly PCI doesn't work this way --
> the driver may register at boot-time, but when a new device is
> added later via hot-plug, the hot-plug infrastructure arranges
> to call the driver's probe() method.
I am _not_ saying this is how it should work, all I am saying is
this is how it is today. Yes I would love to see ACPI core
behave in the same manner as PCI for Hotplug case i.e I want
the ACPI core to handle all the hotplug notifications and just call
add() method of the corresponding driver when the device gets
added/removed, instead of current way of every driver having to
parse the namespace and having to register notifications for every
device.
> 
> > This is how the ACPI core expects us to register for all the devices
> > for which we care notifications. We want to register for all the devices
> > i.e for the devices which are present and for devices which are not present.
> > To do this we walk the entire namespace scope and check for _HID or _CID
> > match and register a notify handler for this device.
> 
> If we really have to do this, should we change things around so
> an ACPI driver can request that its add() method be called
> for non-present devices as well as present ones?  That would
> at least centralize all the _HID/_CID checking and remove the
> namespace walks from the drivers.
Having to call add() method for non-present device would be a bad idea,
instead of this I prefer to see add() getting called when new device gets
added. Again for this to happen the ACPI core should be changed to take 
care of handling the SCI notifications and checking to see is there a driver 
for this device and if it is present calling drivers add() method. This
will eliminate all the driver having to walk the namespace and register
a notification.

> 
> The current scheme of attaching notify handlers only works if
> every possible device is present in the namespace at the time
Yes you are correct.

> the driver is loaded.  Is there a requirement in the spec for
> this?  I could imagine a hot-add event using LoadTable() to
> add new devices to the namespace before notifying the parent
> bus.  Is there code somewhere in ACPI to re-scan the bus and
> attach drivers?
Very much true, hot-add event using LoadTable() can add new devices
to the namespace and I am not sure whether today's ACPI doing a
re-scan in this case.

> 
> > [Those] drivers which support hotplug are responsible for registering
> > for a notification and based on the notification they have to call
> > acpi_bus_add() to add the device and from then on the acpi_bus_add()
> > function takes care of doing rest of the stuff including calling
> > add() function of the driver.
> 
> This is much different from the PCI philosophy, where new-style
> drivers handle hot-plug seamlessly.  I think ACPI should move in
> that direction.  The current style is clunky and error-prone.
> 
> > > Does ACPI
> > > have to supply nodes for every possible hot-pluggable device in
> > > the namespace at boot-time, just to provide places to hang these
> > > handlers?
> > Yes, the ACPI namespace has to list its max possible configuration
> > in its namespace.
> 
> That seems broken.  Does the spec actually require this somewhere?
> I can understand that some firmware might want to have the max
> possible configuration at boot, but it seems like there ought to
> be the option to do it dynamically.
Sure, you can grow namespace dynamically but the current hotplug won;t work
and needs modifications in that case.
> 
> > > [2] This match is not as completely implemented as that in the
> > >     ACPI core, so it doesn't check _CID.  So this seems like a
> > >     case where duplication of functionality leads to maintenance
> > >     problems.  Compare is_root_bridge(), is_memory_device(), and
> > >     container_walk_namespace_cb().
> > Patch welcome:-)
> 
> OK, as soon as I understand better what's going on, I'll work on that :-)
Since I am busy with some other work at the moment, I can definetly help in
reviewing your code.

Thanks,
-Anil


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
