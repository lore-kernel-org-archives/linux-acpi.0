From: =?iso-8859-1?Q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Subject: thermal zone causing insta-reboot on bootup of 2.6.3
Date: Thu, 11 Mar 2004 00:37:43 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <002c01c40701$11116190$7ce9fea9@SHERKA>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0029_01C40701.10FC04D0"
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

This is a multi-part message in MIME format.

------=_NextPart_000_0029_01C40701.10FC04D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

After installing the 2.6.3 kernel on Mandrake 9.2 on an Acer Aspire =
1705SMi laptop, my machine repeatedly prints "Critical temperature =
reached (255 C), shutting down." and reboots.
Installing the 20040220 patch to it seems to have made no difference =
(and added no options that I could see to "make menuconfig" - in fact it =
removed the options for relaxed something under the ACPI options page, =
which wasn't doing anything anyway)...

Can anyone advise? I'm quite inexperienced with linux, so I might be =
doing something stupid (also, I'm having trouble finding which boot =
messages are kept in which logfiles...).
I'm too scared by the "might damage your CPU" message to remove thermal =
zone from the kernel ACPI settings.

Ois=EDn
------=_NextPart_000_0029_01C40701.10FC04D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>After installing the 2.6.3 kernel on =
Mandrake 9.2=20
on an Acer Aspire 1705SMi laptop, my machine repeatedly prints "Critical =

temperature reached (255 C), shutting down." and reboots.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Installing </FONT><FONT face=3DArial =
size=3D2>the=20
20040220 patch to it seems to have made no difference (and added no =
options that=20
I could see to "make menuconfig" - in fact it removed the options for =
relaxed=20
something under the ACPI options page, which wasn't doing anything=20
anyway)...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Can anyone advise? I'm quite =
inexperienced with=20
linux, so I might be doing something stupid (also, I'm having trouble =
finding=20
which boot messages are kept in which logfiles...).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I'm too scared by the "might damage =
your CPU"=20
message to remove thermal zone from the kernel ACPI =
settings.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Ois=EDn</FONT></DIV></BODY></HTML>

------=_NextPart_000_0029_01C40701.10FC04D0--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
