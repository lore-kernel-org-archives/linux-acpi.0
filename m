From: =?iso-8859-1?Q?BERNARD_S=E9bastien?= <sebastien.bernard-3IMRC7uD7uXQT0dZR+AlfA@public.gmane.org>
Subject: RE : N800v is fixed by patch-1690
Date: Wed, 31 Mar 2004 12:47:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3220CFEF35C7D61180EC0002A5438BB005B761E3@achille>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4170D.97CAA3B0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4170D.97CAA3B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I reply to myself since noone answered the underlying question :
Is there any reason not to include the patch mentioned in my first mail =
into
the mainline.
This patch is helping a lot in my case.

-----Message d'origine-----
De=A0: BERNARD S=E9bastien [mailto:sebastien.bernard-3IMRC7uD7uXQT0dZR+AlfA@public.gmane.org]=20
Envoy=E9=A0: mardi 30 mars 2004 16:47
=C0=A0: 'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'
Objet=A0: [ACPI] N800v is fixed by patch-1690

Hi,
When trying to fix the new BIOS F18F provided by COMPAQ, I found some
problem when executing the DSDT on boot which prevents the batteries =
from
showing up.
When googling, I found this patch
http://bugzilla.kernel.org/attachment.cgi?id=3D1690&action=3Dview to =
fix the
ECDT problem and It worked.
=A0
Could this patch be incorporated to the main line since it fixed all =
EVO
nxxx=A0 laptop (I think the BIOS is quite the same in those laptops).
=A0

------_=_NextPart_001_01C4170D.97CAA3B0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>RE : [ACPI] N800v is fixed by patch-1690</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>I reply to myself since noone answered the underlying =
question :</FONT>
<BR><FONT SIZE=3D2>Is there any reason not to include the patch =
mentioned in my first mail into the mainline.</FONT>
<BR><FONT SIZE=3D2>This patch is helping a lot in my case.</FONT>
</P>

<P><FONT SIZE=3D2>-----Message d'origine-----</FONT>
<BR><FONT SIZE=3D2>De=A0: BERNARD S=E9bastien [<A =
HREF=3D"mailto:sebastien.bernard-3IMRC7uD7uXQT0dZR+AlfA@public.gmane.org">mailto:sebastien.bernard@fr=
.sfr.com</A>] </FONT>
<BR><FONT SIZE=3D2>Envoy=E9=A0: mardi 30 mars 2004 16:47</FONT>
<BR><FONT SIZE=3D2>=C0=A0: 'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'</FONT>
<BR><FONT SIZE=3D2>Objet=A0: [ACPI] N800v is fixed by patch-1690</FONT>
</P>

<P><FONT SIZE=3D2>Hi,</FONT>
<BR><FONT SIZE=3D2>When trying to fix the new BIOS F18F provided by =
COMPAQ, I found some problem when executing the DSDT on boot which =
prevents the batteries from showing up.</FONT></P>

<P><FONT SIZE=3D2>When googling, I found this patch <A =
HREF=3D"http://bugzilla.kernel.org/attachment.cgi?id=3D1690&action=3Dvie=
w" =
TARGET=3D"_blank">http://bugzilla.kernel.org/attachment.cgi?id=3D1690&ac=
tion=3Dview</A> to fix the ECDT problem and It worked.</FONT></P>

<P><FONT SIZE=3D2>=A0</FONT>
<BR><FONT SIZE=3D2>Could this patch be incorporated to the main line =
since it fixed all EVO nxxx=A0 laptop (I think the BIOS is quite the =
same in those laptops).</FONT></P>

<P><FONT SIZE=3D2>=A0</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4170D.97CAA3B0--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
