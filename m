From: Joachim Herb <herb-VLtlJOsZqxw@public.gmane.org>
Subject: ACPI with Elitegroup L7VMM3 motherboard
Date: Tue, 09 Mar 2004 00:35:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <404D034C.8040100@leo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello!

I have a few questions about using ACPI on the L7VMM3 motherboard (VIA
KM 266 chip set) (with 1600MHz AMD mobile AMD Athlon(tm) XP-M 1900+
Processor, 223M RAM)

The bios is:
# biosinfo
Following DMI entries found:
 - Mainboard vendor:   "ECS"
 - Mainboard type:     "L7VMM3"
 - Mainboard revision: "3.1"
 - BIOS vendor:        "American Megatrends Inc."
 - BIOS version:       "07.00T"
 - BIOS release:       "04/02/01"

The kernel is 2.4.25 plus acpi-20040220-2.4.25.diff.bz2 plus software
suspend.

When I load the thermal, processor and fan modules, I get the following
directory struction in /proc/acpi:
# tree
.
|-- alarm
|-- dsdt
|-- embedded_controller
|-- event
|-- fadt
|-- fan
|-- info
|-- power_resource
|   |-- FDDP
|   |   `-- state
|   |-- LPTP
|   |   `-- state
|   |-- URP1
|   |   `-- state
|   `-- URP2
|       `-- state
|-- processor
|   `-- CPU1
|       |-- info
|       |-- limit
|       |-- performance
|       |-- power
|       `-- throttling
|-- sleep
`-- thermal_zone

10 directories, 15 files

The are no files in the fan and the thermal_zone directory.

Is this correct?

I would be interested in controlling the fan by measuring the cpu
temperature. Is this possible with this board?

Thank you for your help.

Best regards,
Joachim


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
