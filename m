From: Craig Maloney <cmaloney-JAjqph6Yjy+QYNIH+9O3iA@public.gmane.org>
Subject: wakeup_devices for s3 on dell x200 and bug #1415
Date: Mon, 15 Mar 2004 13:38:33 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40562259.7010102@physics.ucsb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi all.

I posted a bug report on the bugzilla page a while back (bug #2250) (I'm 
not sure if I was supposed to also send a message to the group), but 
I've got some general questions.

With the "wakeup_devices" patch:
http://bugzilla.kernel.org/attachment.cgi?id=1692&action=view

What devices am I *supposed* to see in /proc/acpi/wakeup_devices ?

The devices listed there are not the same as in dmesg.  In particular I 
would have expected "PWRF", "LID0" and "SLPB" to appear as wakeup 
devices.  The device which I attempt to enable as a wakeup device is 
"PWRB" ("back" power button?).

Thanks -- Cheers,
Craig
----------------------------
 From dmesg:
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (on)
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THRM] (39 C)
--------------------------------
in /proc/acpi/wakeup_devices:
Device  Speep state     Status
PWRB       5             disabled
LANC       5            disabled
 CDB       3            disabled
OHCI       3            disabled
MODM       3            disabled




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
