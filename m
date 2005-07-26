From: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI hot-plug notification help needed
Date: Tue, 26 Jul 2005 09:58:55 +0530
Message-ID: <FEB6C4E97F6CAF41978FB2059D5454180303C0C5@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Keshavamurthy, Anil S" <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I agree with Anil's comments.=20
See my comments below.=20

>>> Can somebody explain how the notification stuff in the ACPI
>>> memory and container drivers works?
>>Sure.
>>>
>>> The usual ACPI driver registers its IDs and add() and remove()
>>> functions with acpi_bus_register_driver(), and the ACPI core
>>> calls the add() function when it finds a device that is present
>>> (based on _STA) and whose _HID or _CID matches.
>>
>>Humm.. I would say that ACPI core calls the add() functions
>>for all the devices which it has seen during its boot( of course
>>based on _STA) and whose _HID or _CID matches.
>>
>>Here is how the current core works.
>>During system boot the ACPI core scans for all the devices
>>in its root namespace scope i.e by calling acpi_bus_scan()
>>and for each device whose _STA is present calls acpi_bus_add()
>>which stores the device in linked list. Later when ACPI driver
>>registers its IDs the ACPI core just looks in this device list.
>>The core does not keep track of devices whose _STA became present
>>after boot.
>>
>>>
>>> The memory and container drivers (acpi_memhotplug.c[1] and
container.c)
>>> also do this.  But in addition, they traverse the entire ACPI
namespace
>>> and attach notify handlers to any devices that match the IDs[2],
even
>>> if the _STA indicates "not present".
>>
>>This is how the ACPI core expects us to register for all the devices
>>for which we care notifications. We want to register for all the
devices
>>i.e for the devices which are present and for devices which are not
>>present.
>>To do this we walk the entire namespace scope and check for _HID or
_CID
>>match and register a notify handler for this device.
>>
>>>
>>> It seems strange to attach notify handlers to devices that are
>>> not present.  Maybe ACPI allows events to be sent to devices that
>>> don't exist, but it just seems weird.  I'd expect a hotplug add to
>>
>>When we were implementing this even for us it looked strange that
>>we have to attach a notify handlers for each and every device. Believe
>>me this is how we had to do.
>>
>>> cause events to some previously-present *parent* of the new device.
>>> The parent's driver could then re-scan its children and add any
>>> that are newly-added or newly-marked "present".
>>
>>This might not alway be true. Some f/w might not want to send
>>notification on the parent as the re-scan might be a costly operation
>>as the parent might contain a large number of children. Imaging a case
>>where we want to attach a device under _SB scope, in case if the
>>notification went to _SB and we have rescan the whole namespace here.
>>
>>>
>>> But these drivers seem to expect hot-add events on the new device
>>> itself, and then they go through the motions of acpi_bus_add()
>>> directly.  This seems like it belongs somewhere in the ACPI core.
>>
>>The core functionality still recides inside ACPI core, it just that
>>these drivers which support hotplug are responsible for registering
>>for a notification and based on the notification they have to call
>>acpi_bus_add() to add the device and from then on the acpi_bus_add()
>>function takes care of doing rest of the stuff including calling
>>add() function of the driver.
>>
>>>
>>> I just noticed that the processor_core and acpiphp_glue drivers
>>> do the same thing.  Does this mean that other ACPI drivers that
>>> want to handle hot-plug will also have to go through this dance
>>> of attaching notify handlers to non-present devices?  Does ACPI
>>Don't you think even acpiphp drivers which support slot hotplug
>>also does the same thing?
>>> have to supply nodes for every possible hot-pluggable device in
>>> the namespace at boot-time, just to provide places to hang these
>>> handlers?
>>Yes, the ACPI namespace has to list its max possible configuration
>>in its namespace.
>>
>>>
>>> Please enlighten me.
>>>
>>> [1] "acpi_memhotplug.c" seems redundant.  Wouldn't "memory.c"
>>>      be just as descriptive?  It's in the ACPI directory, so
>>>      we don't need "acpi_", and ACPI drivers in general can
>>>      support hotplug, so it doesn't seem like we need that either.
>>Naveen, any thoughts on this one?
This was renamed to acpi_memhotplug.c, which is more descriptive, based
on the feedback. We might not need "acpi_" though. This driver is very
much required mainly to field hot plug notifications on memory devices
and to interface with Kernel VM subsystem, which ACPI drivers in general
cannot support.
>>>
>>> [2] This match is not as completely implemented as that in the
>>>     ACPI core, so it doesn't check _CID.  So this seems like a
>>>     case where duplication of functionality leads to maintenance
>>>     problems.  Compare is_root_bridge(), is_memory_device(), and
>>>     container_walk_namespace_cb().
>>Patch welcome:-)
>>
>>-Anil


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
