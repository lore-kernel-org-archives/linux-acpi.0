From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC 0/2]convert ACPI driver model to Linux driver model
Date: Mon, 12 Sep 2005 13:22:22 +0800
Message-ID: <1126502542.5153.17.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
I'm sending the patches out not for merging but for comments. The
patches try to convert ACPI driver model to Linux driver model. There
are still many things unsettled. If you have any
comment/suggestion/requirement, please let me know.

1. in my mind, acpi should export two sets of info in sysfs. One is
current namespace subsystem, it should just export the firmware info.
All acpi device/drivers related info don't export here. The other is
ACPI bus. It's similar with other buses like PCI bus.

2. I regard all devices which don't belong to physical buses in the DSDT
as ACPI bus devices. Ideally, PCI devices, PNP devices & other devices
should bind them to their physical buses. Since many devices listed in
DSDT aren't in ACPI bus, this makes it impossible to convert current
acpi driver model into Linux style. You might look at my patch, many
routines required by Linux driver model are empty. Though we can't
completely utilize the advantage of Linux driver model, the partial
convert still benefits us many such as sysfs support and suspend/resume
support.

3. The acpi namespace hotplug interface looks strange. After we
introduce ACPI bus (CPU is in the bus), we can send hotplug event
through it. So I'd like to remove the namespace hotplug interface later.

There are something to prevent us from completely converting ACPI driver
model to Linux style:
1. Current ACPI driver model can register drivers for all devices listed
in DSDT. ACPI bus can't handle this.
2. Current ACPI hotplug (CPU/IO) relays on separate .add/.start
callbacks, but Linux driver can only provide a .probe. We might split
ACPI hotplug support to separate drivers.
Since these, my patch just adds fake Linux driver model support, but it
still is very useful.

Thanks,
Shaohua



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
