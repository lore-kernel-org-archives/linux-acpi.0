From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: SCI interrupt handler : spend too much time
Date: Thu, 4 Dec 2003 11:44:03 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720BF7@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3BA18.DC630A24"
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
To: roychris <roychris-GANU6spQydw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3BA18.DC630A24
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Does it mean the overhead of SCI interrupt was not the root cause of =
this issue. --Luming
=20

-----Original Message-----
From: roychris [mailto:roychris-GANU6spQydw@public.gmane.org]
Sent: 2003?12?3? 20:49
To: Pavel Machek
Cc: Yu, Luming; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] SCI interrupt handler : spend too much time


Just a precision,
synaptic driver is not like the other mouses. psmouse call a specific =
fonction for this touchpad that is in an other module.
The problem happens since 2.6, since psmouse and synaptic had been =
seperated....

Pavel Machek wrote:


Hi!



 =20

It sound like serious one, if SCI interrupt handler was blamed for

this issue.     --Luming

   =20



I investigated a bit, and interrupt latency alone is not enough to

break mouse. [Unfortunately, I do not have easy/sure way to reproduce

it.]



Is it possible that SCI interrupt handler accesses keyboard controller

(and breaks mouse?)

								Pavel







 =20



------_=_NextPart_001_01C3BA18.DC630A24
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<TITLE></TITLE>

<META content=3D"MSHTML 6.00.2722.900" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D927474203-04122003><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2>Does it=20
mean the overhead of SCI interrupt was not the root cause of this issue. =

--Luming</FONT></SPAN></DIV>
<DIV><SPAN class=3D927474203-04122003><FONT face=3D&#23435;&#20307; =
color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<BLOCKQUOTE>
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> roychris=20
  [mailto:roychris-GANU6spQydw@public.gmane.org]<BR><B>Sent:</B> =
2003&#24180;12&#26376;3&#26085; 20:49<BR><B>To:</B> Pavel=20
  Machek<BR><B>Cc:</B> Yu, Luming;=20
  acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org<BR><B>Subject:</B> Re: [ACPI] SCI =
interrupt=20
  handler : spend too much time<BR><BR></FONT></DIV>Just a=20
  precision,<BR>synaptic driver is not like the other mouses. psmouse =
call a=20
  specific fonction for this touchpad that is in an other module.<BR>The =
problem=20
  happens since 2.6, since psmouse and synaptic had been=20
  seperated....<BR><BR>Pavel Machek wrote:<BR>
  <BLOCKQUOTE cite=3Dmid20031203124720.GA11239-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org=20
  type=3D"cite"><PRE wrap=3D"">Hi!

  </PRE>
    <BLOCKQUOTE type=3D"cite"><PRE wrap=3D"">It sound like serious one, =
if SCI interrupt handler was blamed for
this issue.     --Luming
    </PRE></BLOCKQUOTE><PRE wrap=3D""><!---->
I investigated a bit, and interrupt latency alone is not enough to
break mouse. [Unfortunately, I do not have easy/sure way to reproduce
it.]

Is it possible that SCI interrupt handler accesses keyboard controller
(and breaks mouse?)
								Pavel



  </PRE></BLOCKQUOTE><BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C3BA18.DC630A24--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
