From: Eli Cohen <eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org>
Subject: RE: acpi data parser
Date: Mon, 14 Apr 2003 18:02:58 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <506C3D7B14CDD411A52C00025558DED60ED3BC@mtlex01.yok.mtl.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C30296.EF6046C0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'Randy.Dunlap'" <rddunlap-3NddpPZAyC0@public.gmane.org>, Eli Cohen <eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C30296.EF6046C0
Content-Type: text/plain

Intel's disassembler does a segmentation fault when trying -g option. Can
you send info on how to checkout pmtools from sourceforge?
thanks

-----Original Message-----
From: Randy.Dunlap [mailto:rddunlap-3NddpPZAyC0@public.gmane.org]
Sent: Monday, April 14, 2003 5:04 PM
To: Eli Cohen
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] acpi data parser


On Mon, 14 Apr 2003 11:14:43 +0300 Eli Cohen <eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org> wrote:

| Hi,
| is there any tool that can get the acpi data in a system and parse it in a
| convenient way. Particularly the interrupt routing information.
| thanks
| Eli

Hi,

There are several such tools.

At the acpi sf project, there are "pmtools" in CVS (only at the
moment).  See http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/acpi/ .

There is an Intel disassembler (IASL) that I haven't used.
I think it's in the Unix Build Environment tarball here:
http://developer.intel.com/technology/iapc/acpi/downloads.htm

and there could be another one soon.

HTH.
--
~Randy   ["in English any noun can be verbed."  bah!]

------_=_NextPart_001_01C30296.EF6046C0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>RE: [ACPI] acpi data parser</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Intel's disassembler does a segmentation fault when =
trying -g option. Can you send info on how to checkout pmtools from =
sourceforge?</FONT></P>

<P><FONT SIZE=3D2>thanks</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Randy.Dunlap [<A =
HREF=3D"mailto:rddunlap-3NddpPZAyC0@public.gmane.org">mailto:rddunlap@osdl.org</A>]</FONT>
<BR><FONT SIZE=3D2>Sent: Monday, April 14, 2003 5:04 PM</FONT>
<BR><FONT SIZE=3D2>To: Eli Cohen</FONT>
<BR><FONT SIZE=3D2>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [ACPI] acpi data parser</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Mon, 14 Apr 2003 11:14:43 +0300 Eli Cohen =
&lt;eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org&gt; wrote:</FONT>
</P>

<P><FONT SIZE=3D2>| Hi,</FONT>
<BR><FONT SIZE=3D2>| is there any tool that can get the acpi data in a =
system and parse it in a</FONT>
<BR><FONT SIZE=3D2>| convenient way. Particularly the interrupt routing =
information.</FONT>
<BR><FONT SIZE=3D2>| thanks</FONT>
<BR><FONT SIZE=3D2>| Eli</FONT>
</P>

<P><FONT SIZE=3D2>Hi,</FONT>
</P>

<P><FONT SIZE=3D2>There are several such tools.</FONT>
</P>

<P><FONT SIZE=3D2>At the acpi sf project, there are &quot;pmtools&quot; =
in CVS (only at the</FONT>
<BR><FONT SIZE=3D2>moment).&nbsp; See <A =
HREF=3D"http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/acpi/" =
TARGET=3D"_blank">http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/acpi/</=
A> .</FONT>
</P>

<P><FONT SIZE=3D2>There is an Intel disassembler (IASL) that I haven't =
used.</FONT>
<BR><FONT SIZE=3D2>I think it's in the Unix Build Environment tarball =
here:</FONT>
<BR><FONT SIZE=3D2><A =
HREF=3D"http://developer.intel.com/technology/iapc/acpi/downloads.htm" =
TARGET=3D"_blank">http://developer.intel.com/technology/iapc/acpi/downlo=
ads.htm</A></FONT>
</P>

<P><FONT SIZE=3D2>and there could be another one soon.</FONT>
</P>

<P><FONT SIZE=3D2>HTH.</FONT>
<BR><FONT SIZE=3D2>--</FONT>
<BR><FONT SIZE=3D2>~Randy&nbsp;&nbsp; [&quot;in English any noun can be =
verbed.&quot;&nbsp; bah!]</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C30296.EF6046C0--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
