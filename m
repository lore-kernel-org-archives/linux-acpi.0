From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI fixes (2.4)
Date: Mon, 23 Jun 2003 00:08:51 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96FB4@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C33956.4C9423F3"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org
Cc: jgarzik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C33956.4C9423F3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo, please do a

	bk pull http://linux-acpi.bkbits.net/linux-2.4-acpi

This will update the following files:

 arch/i386/kernel/setup.c |    4 ++--
 drivers/acpi/Config.in   |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/22 1.997.2.2)
   ACPI: make it so acpismp=3Dforce works (reported by Andrew Morton)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/22 1.997.2.1)
   ACPI: Fix config.in (Jeff Garzik)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org


------_=_NextPart_001_01C33956.4C9423F3
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6389.0">
<TITLE>[BK PATCH] ACPI fixes (2.4)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Courier New">Hi Marcelo, please do a</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Courier New">bk pull </FONT><A =
HREF=3D"http://linux-acpi.bkbits.net/linux-2.4-acpi"><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Courier =
New">http://linux-acpi.bkbits.net/linux-2.4-acpi</FONT></U></A>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">This will update the following =
files:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;arch/i386/kernel/setup.c =
|&nbsp;&nbsp;&nbsp; 4 ++--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;drivers/acpi/Config.in&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 =
++</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;2 files changed, 4 =
insertions(+), 2 deletions(-)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">through these ChangeSets:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&lt;agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org&gt; =
(03/06/22 1.997.2.2)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; ACPI: make it so =
acpismp=3Dforce works (reported by Andrew Morton)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&lt;agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org&gt; =
(03/06/22 1.997.2.1)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; ACPI: Fix config.in =
(Jeff Garzik)</FONT>
</P>
<BR>

<P><FONT SIZE=3D1 FACE=3D"Arial">-----------------------------</FONT>

<BR><FONT SIZE=3D1 FACE=3D"Arial">Andrew Grover</FONT>

<BR><FONT SIZE=3D1 FACE=3D"Arial">Intel Labs / Mobile =
Architecture</FONT>

<BR><FONT SIZE=3D1 FACE=3D"Arial">andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C33956.4C9423F3--


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
