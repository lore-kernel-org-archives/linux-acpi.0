From: "Rockefeller, Harry" <harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org>
Subject: RE: Time restoration when waking from sleep
Date: Wed, 31 Mar 2004 15:40:52 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7105F2BD9451D7479B4B3A99A2B72FAC0634986C@exchange1.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C41768.D7021BB6"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jeff Downs <heydowns-HzVxVrDXSgs@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C41768.D7021BB6
Content-Type: text/plain

I use acpid with perl scripts to perform sleep/suspend functions.
When the wake event happens the perl script continues with waking events
right where it left off (at the sleep/suspend command ;-)), i.e.,
system ('hwclock --hctosys ; date'); # Restore system time

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Jeff Downs
Sent: Wednesday, March 31, 2004 3:10 PM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Time restoration when waking from sleep

Hello,

Using the S1 sleep state provided by ACPI (echo 1 >
/proc/acpi/sleep) works well, overall, on my Dell Inspiron 8600 with Kernel
2.4.25.

However, I've noticed that the system clock is not updated when the system
is restored. It simply contains the time at which the system was put into
the S1 state.

I checked archives (except for this list, the sourceforge archive appears to
be broken) and whatnot for people haveing similar problems and found no
references on the topic of system time restoration.  Is this something that
should be done in user-land, or is it something that will be added to the
kernel in the future?

Please CC: me on any responses, as I am not a member of this list. Thanks,

	-Jeff




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux tutorial
presented by Daniel Robbins, President and CEO of GenToo technologies. Learn
everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel

------_=_NextPart_001_01C41768.D7021BB6
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2657.73">
<TITLE>RE: [ACPI] Time restoration when waking from sleep</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>I use acpid with perl scripts to perform =
sleep/suspend functions.</FONT>
<BR><FONT SIZE=3D2>When the wake event happens the perl script =
continues with waking events</FONT>
<BR><FONT SIZE=3D2>right where it left off (at the sleep/suspend =
command ;-)), i.e.,</FONT>
<BR><FONT SIZE=3D2>system ('hwclock --hctosys ; date'); # Restore =
system time</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [<A =
HREF=3D"mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">mailto:acpi-devel=
-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</A>] On Behalf Of Jeff Downs</FONT>
<BR><FONT SIZE=3D2>Sent: Wednesday, March 31, 2004 3:10 PM</FONT>
<BR><FONT SIZE=3D2>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2>Subject: [ACPI] Time restoration when waking from =
sleep</FONT>
</P>

<P><FONT SIZE=3D2>Hello,</FONT>
</P>

<P><FONT SIZE=3D2>Using the S1 sleep state provided by ACPI (echo 1 =
&gt;</FONT>
<BR><FONT SIZE=3D2>/proc/acpi/sleep) works well, overall, on my Dell =
Inspiron 8600 with Kernel 2.4.25.</FONT>
</P>

<P><FONT SIZE=3D2>However, I've noticed that the system clock is not =
updated when the system is restored. It simply contains the time at =
which the system was put into the S1 state.</FONT></P>

<P><FONT SIZE=3D2>I checked archives (except for this list, the =
sourceforge archive appears to be broken) and whatnot for people =
haveing similar problems and found no references on the topic of system =
time restoration.&nbsp; Is this something that should be done in =
user-land, or is it something that will be added to the kernel in the =
future?</FONT></P>

<P><FONT SIZE=3D2>Please CC: me on any responses, as I am not a member =
of this list. Thanks,</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
SIZE=3D2>-Jeff</FONT>
</P>
<BR>
<BR>
<BR>

<P><FONT =
SIZE=3D2>-------------------------------------------------------</FONT>
<BR><FONT SIZE=3D2>This SF.Net email is sponsored by: IBM Linux =
Tutorials Free Linux tutorial presented by Daniel Robbins, President =
and CEO of GenToo technologies. Learn everything from fundamentals to =
system administration.<A =
HREF=3D"http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick" =
TARGET=3D"_blank">http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3D=
click</A></FONT></P>

<P><FONT =
SIZE=3D2>_______________________________________________</FONT>
<BR><FONT SIZE=3D2>Acpi-devel mailing list</FONT>
<BR><FONT SIZE=3D2>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2><A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/acpi-devel" =
TARGET=3D"_blank">https://lists.sourceforge.net/lists/listinfo/acpi-deve=
l</A></FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C41768.D7021BB6--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
