From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: /proc/acpi/
Date: Sun, 7 Mar 2004 22:45:11 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0029EEDA9@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mike Partyka <mpartyka-EySxSuIQeMUAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

SuSE 9.0 has ACPI enabled and you should see stuff under /proc/acpi with
that before you build a custom 2.6.3 kernel.

We don't publish ACPI patches from sourceforge.net, and have not done so
for over 6 months, they're published from kernel.org.  Though if you're
not a developer, it I is probably better to use what is in the mainline
kernel.org tree since it is more widely tested than the latest ACPI
patch.

The output from dmesg -s40000 will probably tell all.

Cheers,
-Len


>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Mike Partyka
>Sent: Wednesday, May 05, 2004 11:08 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] /proc/acpi/
>
>Hello all,
>
>This is my first post to this group.=20
>
>I just got a new laptop from work, a Gateway 200x, which i=20
>thought woudl
>be perfect to make the transition to Linux dekstop for system
>management.
>
>I have read through many documents on the net about making ACPI work on
>Linux. I have downloaded the latest kernel stable kernel source 2.6.3
>and have patched that source with the latest acpi from
>http://acpi.sourceforge.net and then compiled the kernel.
>
>The compile using (make xconfig) doesn't look any different=20
>when looking
>at the options.=20
>
>But in any case after booting into it and looking in /proc/acpi and
>looking into the battery and ac_adapter etc there are no=20
>scripts/events.
>Is this normal? I just picked up the magazine Linux User and they had a
>nice article about ACPI under Linux but the article says there=20
>should be
>files under the directories battery, and ac_adapter etc but i=20
>have none.
>
>This is a stock install of SuSE 9 Pro but it doesn't seem to have any
>ACPI features enabled by default. How can i do this?
>
>TIA
>Mikey
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IBM Linux Tutorials
>Free Linux tutorial presented by Daniel Robbins, President and CEO of
>GenToo technologies. Learn everything from fundamentals to system
>administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcl=
ick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
