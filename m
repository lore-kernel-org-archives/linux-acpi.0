From: kylin <fierykylin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Date: Sun, 31 Jul 2005 00:20:30 +0800
Message-ID: <87ab37ab0507300920570b0ea6@mail.gmail.com>
Reply-To: kylin <fierykylin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-newbie-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-hotplug-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dkumar-QByN7dn/BetQWC9lL0RKGQC/G2K4zDHf@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

n the latest update of the Intel's E7520 MCH,the very NOTFIX entry
caught my eye:
//////////////////////
PCI Express Hot-Plug MSI interrupt issue
////////////////////
Problem:
During a link down state, the MCH will not send MSI interrupts to the
front side bus. In general
MSI messages need not be delivered when the link is down, but in the
event that MSI interrupt routing is used on Hot-Plug events, the
processor will wait indefinitely for this interrupt. Waiting for
command complete interrupts is a normal part of the steps in the
orderly removal process, and link down will occur at the point that
power is removed from the slot. Subsequent accesses to the slot
control register to update indicators and power control will not
generate the expected MSI interrupts from the MCH until slot power is
restored, and the link is back up.
Implication:
Hot-Plug software written to wait for command complete interrupts will
hang in MSI interrupt mode.
Workaround:
Run in either of the other two interrupt modes (the "legacy" method
using the MCHGPE# to signal
hot-plug interrupts to the ICH or "native" interrupt mode using PCI
interrupts (INTA#)).
Alternatively in MSI mode, software may poll for command complete
rather than wait for MSI, or implement the command complete timeout to
continue to the next slot control update rather than repeat the
current slot control update
I wonder if i can workaround the MSI using the polling way on the
server geared by E7520 and the firmware with no OSC implemented


--=20
we who r about to die,salute u!


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
