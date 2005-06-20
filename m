From: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Subject: Sometimes system hangs at ACPI wakeup devices:
Date: Mon, 20 Jun 2005 10:06:07 -0500
Message-ID: <200506201006.08015.gkanis@cems.umn.edu>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a Centrino laptop. I had a minor problem with the BIOS and I have 
fixed/compiled the DSDT, loading from a intrafms image. Also, some people 
here told me that because of the BIOS (is ACPI 2,0 compliant)  in grub.conf I 
have acpi=noirq.
As the subject suggests sometimes during boot the system hangs at 
ACPI wakeup devices:
 LID AZAL USB1 USB2 USB3 USB4 USB7 LANC CRDB MODM

and I have to manually poweroff the system, and boot it again.
When it boots the next two messages are

ACPI wakeup devices:
 LID AZAL USB1 USB2 USB3 USB4 USB7 LANC CRDB MODM
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found

Also, several lines above, I read

ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Thermal Zone [THRM] (61 C)

Do you have any idea why the system hangs at ACPI wakeup devices?

Finally, since I have a PCIExpress card, in dmesg I read the following 
message:
PCI: No IRQ known for interrupt pin A of device 0000:00:01.0. Please try using 
pci=biosirq.
PCI: Setting latency timer of device 0000:00:01.0 to 64
pcie_portdrv_probe->Dev[2591:8086] has invalid IRQ. Check vendor BIOS

does this mean that the pcie device is malfunctioning?

Thank you,
Vasilis


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
