From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: LID button Event ACPI malfunction
Date: Wed, 22 Dec 2004 10:05:18 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575D251A6@pdsmsx402.ccr.corp.intel.com>
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
To: Benedek Frank <linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I guess the system invokes ACPI event when shut down. If the button
driver provides a .shutdown method, the issue could be fixed.
Actually in recent discussion, we agreed every ACPI driver should
provide .shutdown/.suspend/.resume method, but we must migrate to sysfs
interface for ACPI and use generic device model first.

Thanks,
Shaohua
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Benedek Frank
>Sent: Wednesday, December 22, 2004 8:26 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] LID button Event ACPI malfunction
>
>Hi
>
>When I shut down, my machine (Dell 700m) goes into suspend to ram
twice. I
>have to wake it
>up, and it goes further, sleeps again, wake it up, and finally shuts
down.
>I
>just had ACPI worked out (kernel 2.6.9), and since just recently I can
go
>to
>suspend to RAM
>and DISK as well. Now, why a shut down triggers a suspend-to-ram?
>
>When I look at the LID button under ACPI
>
>/proc/acpi/button/lid/LID0/state
>
>it says
>
>state: closed
>
>It is clearly not closed, as I am looking at the screen. :)
>
>I have an ACPI event that gets triggered when I REALLY close the lid,
and
>that
>works.
>
>Here is the event
>
>/etc/acpi/event/lidbtn
>
>event=3Dbutton/lid
>action=3D/etc/acpi/lidbtn.sh
>
>And here is the script
>
>/etc/acpi/lidbtn.sh
>
>#!/bin/sh
>/sbin/sleep
>
>And finally here is /sbin/sleep, that was written by me for the
machine's
>special needs (like module unloading, video_post etc.)
>
>rmmod b44
>echo "mem" > /sys/power/state
>#echo 3 > /proc/acpi/sleep
>modprobe i830
>/root/emu/video_post
>modprobe b44
>/etc/init.d/networking restart
>
>Thanks for any help
>
>Ben
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real
users.
>Discover which products truly live up to the hype. Start reading now.
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
