From: "Wayne Wylupski" <wayne-/9RTSe/R4cJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Handling \_GPE._L03
Date: Tue, 29 Jun 2004 08:58:24 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000801c45dd8$c3b19210$700d0a0a@clam.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01C45DB7.3C62C200"
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

------=_NextPart_000_0005_01C45DB7.3C62C200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset="iso-8859-1"

>  My laptop is a Fujitsu Lifebook P2110.  I get ACPI events for the =
function keys for video
> (switch to other video adapter. or S-output, or shrink the screen).  =
The Method that gets
> called is \_GPE._L03.  I know that the ACPI portion of the kernel is =
handling the method,
> but how do I register my own handler so I may generate acpid events?  =
It"s not obvious to me
> there"s a device (_HID) associated with this method, and I don"t see a =
precedent for this
> within the other drivers in drivers/acpi.

 =20
Would the acpi_install_gpe_handler() function be appropriate for trying =
to handle the above?

Wayne


------=_NextPart_000_0005_01C45DB7.3C62C200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2><FONT size=3D3>&gt;&nbsp;&nbsp;My =
laptop is a Fujitsu=20
Lifebook P2110.&nbsp; I get ACPI events for the function keys for =
video<BR>&gt;=20
(switch to other video adapter. or S-output, or shrink the =
screen).&nbsp; The=20
Method that gets<BR>&gt; called is \_GPE._L03.&nbsp; I know that the =
ACPI=20
portion of the kernel is handling the method,<BR>&gt; but how do I =
register my=20
own handler so I may generate acpid events?&nbsp; It"s not obvious to =
me<BR>&gt;=20
there"s a device (_HID) associated with this method, and I don"t see a =
precedent=20
for this<BR>&gt; within the other drivers in=20
drivers/acpi.<BR></FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT size=3D3>&nbsp; <BR>Would the=20
acpi_install_gpe_handler() function be appropriate for trying to handle =
the=20
above?</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT =
size=3D3></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><FONT size=3D3>Wayne</FONT></DIV>
<DIV><BR></DIV></FONT></BODY></HTML>

------=_NextPart_000_0005_01C45DB7.3C62C200--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
