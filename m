From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: CPU Performance Management
Date: Tue, 1 Apr 2003 20:27:29 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96DAA@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C2F8D0.2C4E2500"
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
To: Ryan May <rmay-GrrYUJ3DTa8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C2F8D0.2C4E2500
Content-Type: text/plain;
	charset="ISO-8859-1"

We moved the processor performance stuff to the cpufreq interface. I think
the fact that we still list it in info is a bug.
 
Regards -- Andy

-----Original Message-----
From: Ryan May [mailto:rmay-GrrYUJ3DTa8@public.gmane.org] 
Sent: Tuesday, April 01, 2003 7:34 PM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] CPU Performance Management


Hi,
 
I have a Toshiba 2415-s205 with a P4M-2.0GHz and have recently been toying
with ACPI support in the linux kernel.  So far, I have gotten two versions
running: The 2.5.66 kernel with the 20030328 ACPI patch and the 2.4.20
kernel with the 20021222 ACPI patch.  Neither of the kernels have any other
patches applied.
 
I am happy to see that (with a quick look) many features work well, except
for an issue with the 20030328 patch.  When I cat
/proc/acpi/processor/CPU0/info I get the following output:
 
processor id:                      0
acpi id:                              1
bus mastering control:        yes
power management:           yes
throttling control:                no
performance management:  no
limit interface:                    no
 
Knowing that I have a P4M, I would have expected to have the option of
performance management.  Indeed, on the 20021212 patch on a 2.4.20 kernel, I
have both performance management and limit interface enabled.  Anyone have
any clue what changed to actually disable performance management?
 
I've tried disassembling and recompiling my DSDT (using iasl 20030228);  It
gives me three identical warnings:
 
Package (0x00) {},
                    ^ Effective AML package length is zero
 
Could this be my problem?
 
Any help would be greatly appreciated.
 
Ryan May
 


------_=_NextPart_001_01C2F8D0.2C4E2500
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">


<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1126" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><SPAN class=3D194102604-02042003><FONT face=3DArial =
color=3D#0000ff size=3D2>We=20
moved the processor performance stuff to the cpufreq interface. I think =
the fact=20
that we still list it in info is a bug.</FONT></SPAN></DIV>
<DIV><SPAN class=3D194102604-02042003><FONT face=3DArial =
color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D194102604-02042003><FONT face=3DArial =
color=3D#0000ff=20
size=3D2>Regards -- Andy</FONT></SPAN></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><FONT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B> =
Ryan May=20
  [mailto:rmay-GrrYUJ3DTa8@public.gmane.org] <BR><B>Sent:</B> Tuesday, April 01, 2003 7:34=20
  PM<BR><B>To:</B> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org<BR><B>Subject:</B> =
[ACPI]=20
  CPU Performance Management<BR><BR></FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I have a Toshiba 2415-s205 with a =
P4M-2.0GHz and=20
  have recently been toying with ACPI support in the linux =
kernel.&nbsp; So far,=20
  I have gotten two versions running: The 2.5.66 kernel with the =
20030328 ACPI=20
  patch and the 2.4.20 kernel with the 20021222 ACPI patch.&nbsp; =
Neither of the=20
  kernels have any other patches applied.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I am happy to see that&nbsp;(with a =
quick look)=20
  many features work well, except for&nbsp;an issue with =
the&nbsp;20030328=20
  patch.&nbsp; When I cat /proc/acpi/processor/CPU0/info I get the =
following=20
  output:</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>processor=20
  =
id:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0</FONT><=
/DIV>
  <DIV><FONT face=3DArial size=3D2>acpi=20
  =
id:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>bus mastering =
control:&nbsp;&nbsp;&nbsp;=20
  &nbsp;&nbsp;&nbsp; yes</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>power=20
  =
management:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;yes</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>throttling =
control:&nbsp;&nbsp;&nbsp;=20
  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
no</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>performance management:&nbsp; =
no</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>limit interface:&nbsp;&nbsp;&nbsp;=20
  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;=20
  no</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>Knowing that I have a P4M, I would =
have expected=20
  to have the option of performance management.&nbsp; Indeed, on the =
20021212=20
  patch on a 2.4.20 kernel, I have both performance management and =
limit=20
  interface&nbsp;enabled.&nbsp; Anyone have any clue what changed to =
actually=20
  disable performance management?</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I've tried disassembling and =
recompiling my DSDT=20
  (using iasl 20030228);&nbsp; It gives me three identical=20
warnings:</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>Package (0x00)&nbsp;{},</FONT></DIV>
  <DIV><FONT face=3DArial=20
  =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  ^ Effective AML package length is zero</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>Could this be my =
problem?</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>Any help would be greatly=20
  appreciated.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>Ryan May</FONT></DIV>
  <DIV>&nbsp;</DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C2F8D0.2C4E2500--


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
