From: Nikolaus Filus <NFilus-hi6Y0CQ0nG0@public.gmane.org>
Subject: battery errors
Date: Tue, 11 Feb 2003 22:23:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030211222306.C398@wsc-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I just saw the following error on my console - for the first time. What does
it mean?

mobile kernel: evregion-0322: *** Error: Handler for [embedded_control] returned AE_TIME
mobile kernel:  psparse-1102: *** Error: Method execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node c15a21e8), AE_TIME

/proc/acpi/battery/BAT1/*
alarm:                   unsupported
present:                 yes
design capacity:         3900 mAh
last full capacity:      3427 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 420 mAh
design capacity low:     156 mAh
capacity granularity 1:  264 mAh
capacity granularity 2:  3780 mAh
model number:            PA3098U
serial number:           3658Q
battery type:            Li-Ion
OEM info:                TOSHIBA
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            0 mA
remaining capacity:      1404 mAh
present voltage:         14644 mV

BTW: How to keep the capacity as high as possible? The notebook is 8 months
old and I lost around 500 mAh.

Thanks,

Nikolaus


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
