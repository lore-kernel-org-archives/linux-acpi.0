From: "Alan Yang" <Alan_Yang-KjnUIgV0B0ZBDgjK7y7TUQ@public.gmane.org>
Subject: about s5 implement?
Date: Wed, 25 Sep 2002 10:17:04 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6D874824CDFBD411A32700508BDE9C77156D7F@njg-exch.phoenix.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C26439.A42614F6"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C26439.A42614F6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear all,

My kernel version is 2.5.35. I want to know how to implement s5, but I
can't understand. If sleep state is s5, acpi_suspend(5) call
acpi_enter_sleep_state_prep(5) to get SLP_TYP and call
acpi_system_save_state(5) to power down devices, but function
acpi_system_suspend(5) does nothing, I can't find where os writes
SLP_TYP and SLP_EN to PM1_CNT registers. I think acpi_system_suspend(5)
should call acpi_enter_sleep_state (5) to write SLP_TYP and SLP_EN to
PM1_CNT registers.=20

Any comment will be appreciated.

Alan

------_=_NextPart_001_01C26439.A42614F6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.5762.3">
<TITLE>about s5 implement?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Verdana">Dear all,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">My kernel version is 2.5.35. I want =
to know how to implement s5, but I can't understand. If sleep state is =
s5, acpi_suspend(5) call acpi_enter_sleep_state_prep(5) to get SLP_TYP =
and call acpi_system_save_state(5) to power down devices, but function =
acpi_system_suspend(5) does nothing, I can't find where os writes =
SLP_TYP and SLP_EN to PM1_CNT registers. I think acpi_system_suspend(5) =
should call acpi_enter_sleep_state (5) to write SLP_TYP and SLP_EN to =
PM1_CNT registers. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">Any comment will be =
appreciated.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Verdana">Alan</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C26439.A42614F6--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
