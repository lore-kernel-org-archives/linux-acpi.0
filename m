From: "Jeremy Mann" <jmann-hthdAawbG4PxMOqTD017tQC/G2K4zDHf@public.gmane.org>
Subject: RE: Compaq Presario 2175US
Date: Tue, 13 Jul 2004 11:43:15 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <008601c468f8$7e9a3530$3901a8c0@nurscaresvr.integracarehh.com>
References: <1089734480.24119.44.camel@rh10.fe.up.pt>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0087_01C468CE.95C42D30"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1089734480.24119.44.camel-DSl92WGJowabUe/Hp89tnA@public.gmane.org>
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

------=_NextPart_000_0087_01C468CE.95C42D30
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I still get a hard lock trying that option(and noapic which I found in =
the
kernel-booting.txt)

-----Original Message-----
From: S=E9rgio M. Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]=20
Sent: Tuesday, July 13, 2004 11:01 AM
To: Jeremy Mann
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] Compaq Presario 2175US


On Tue, 2004-07-13 at 16:20, Jeremy Mann wrote:=20

I've just spent the better part of 2 hours looking through the list =
archives

and see many posts related to the 2100 series Compaq laptops, but I =
didn't

see anything related to how I can get ACPI active enough to dump my DSDT

code.  I'm running Mandrake 10, just tried a kernel recompile using an =
IRQ9

hack, but my laptop still gets a hard lockup upon boot from a 2.6.7

kernel(and 2.6.3, and 2.4.2x).  The only way I can get the laptop to =
bootup

is using either ACPI=3Doff or ACPI=3Dht(mandrake default).  Any =
suggestions?  I

just flashed to the latest and greatest(ha!) bios from compaq and tried

again with no such luck.



try boot with ACPI=3Don nolapic



Sergio M. B. =09



------=_NextPart_000_0087_01C468CE.95C42D30
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D843464216-13072004><FONT face=3DArial color=3D#0000ff =
size=3D2>I=20
still get a hard lock trying that option(and noapic which I found in the =

kernel-booting.txt)</FONT></SPAN></DIV>
<BLOCKQUOTE dir=3Dltr style=3D"MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><FONT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B> =
S=E9rgio M. Basto=20
  [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org] <BR><B>Sent:</B> Tuesday, July 13, 2004 =
11:01=20
  AM<BR><B>To:</B> Jeremy Mann<BR><B>Cc:</B>=20
  acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org<BR><B>Subject:</B> Re: [ACPI] Compaq =
Presario=20
  2175US<BR><BR></FONT></DIV>On Tue, 2004-07-13 at 16:20, Jeremy Mann =
wrote:=20
  <BLOCKQUOTE TYPE=3D"CITE"><PRE><FONT color=3D#737373><I>I've just =
spent the better part of 2 hours looking through the list archives
and see many posts related to the 2100 series Compaq laptops, but I =
didn't
see anything related to how I can get ACPI active enough to dump my DSDT
code.  I'm running Mandrake 10, just tried a kernel recompile using an =
IRQ9
hack, but my laptop still gets a hard lockup upon boot from a 2.6.7
kernel(and 2.6.3, and 2.4.2x).  The only way I can get the laptop to =
bootup
is using either ACPI=3Doff or ACPI=3Dht(mandrake default).  Any =
suggestions?  I
just flashed to the latest and greatest(ha!) bios from compaq and tried
again with no such luck.
</I></FONT></PRE></BLOCKQUOTE><PRE><TT>try boot with ACPI=3Don no<FONT =
color=3D#a020f0><B>lapic</TT></B></FONT></PRE><BR><PRE><TABLE =
cellSpacing=3D0 cellPadding=3D0 width=3D"100%"><TBODY><TR><TD>Sergio M. =
B. </TD></TR></TBODY></TABLE>
</PRE></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0087_01C468CE.95C42D30--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
