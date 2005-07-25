From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: ACPI hot-plug notification help needed
Date: Mon, 25 Jul 2005 17:35:23 -0600
Message-ID: <200507251735.23394.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Can somebody explain how the notification stuff in the ACPI
memory and container drivers works?

The usual ACPI driver registers its IDs and add() and remove()
functions with acpi_bus_register_driver(), and the ACPI core
calls the add() function when it finds a device that is present
(based on _STA) and whose _HID or _CID matches.

The memory and container drivers (acpi_memhotplug.c[1] and container.c)
also do this.  But in addition, they traverse the entire ACPI namespace
and attach notify handlers to any devices that match the IDs[2], even
if the _STA indicates "not present".

It seems strange to attach notify handlers to devices that are
not present.  Maybe ACPI allows events to be sent to devices that
don't exist, but it just seems weird.  I'd expect a hotplug add to
cause events to some previously-present *parent* of the new device.
The parent's driver could then re-scan its children and add any
that are newly-added or newly-marked "present".

But these drivers seem to expect hot-add events on the new device
itself, and then they go through the motions of acpi_bus_add()
directly.  This seems like it belongs somewhere in the ACPI core.

I just noticed that the processor_core and acpiphp_glue drivers
do the same thing.  Does this mean that other ACPI drivers that
want to handle hot-plug will also have to go through this dance
of attaching notify handlers to non-present devices?  Does ACPI
have to supply nodes for every possible hot-pluggable device in
the namespace at boot-time, just to provide places to hang these
handlers?

Please enlighten me.

[1] "acpi_memhotplug.c" seems redundant.  Wouldn't "memory.c"
     be just as descriptive?  It's in the ACPI directory, so
     we don't need "acpi_", and ACPI drivers in general can
     support hotplug, so it doesn't seem like we need that either.

[2] This match is not as completely implemented as that in the
    ACPI core, so it doesn't check _CID.  So this seems like a
    case where duplication of functionality leads to maintenance
    problems.  Compare is_root_bridge(), is_memory_device(), and
    container_walk_namespace_cb().


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
