From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: unable to set alam using echo to /proc/acpi/alarm
Date: Mon, 12 Dec 2005 11:40:11 +0300
Message-ID: <6694B22B6436BC43B429958787E45498F49EC4@mssmsx402nb>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5FEF7.ABAF4DDB"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ronald Wielink <ronald.mythtv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5FEF7.ABAF4DDB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Do you have RTC driver compiled and loaded? CONFIG_RTC in kernel
.config?
=20
Regards,
    Alex


________________________________

	From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Ronald
Wielink
	Sent: Monday, December 12, 2005 12:30 AM
	To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
	Subject: [ACPI] unable to set alam using echo to
/proc/acpi/alarm
=09
=09
	Dear all,
	when I try setting the alarm to wake up my pc I get the
following result:
=09
	[root@mithrandir acpi]# pwd
	/proc/acpi
	[root@mithrandir acpi]# cat alarm
	2005-12-00 00:00:00
	[root@mithrandir acpi]# echo 2005-12-15 17:18:19 > alarm
	[root@mithrandir acpi]# cat alarm
	2005-12-00 17:18:19
	[root@mithrandir acpi]#
=09
	BTW, nothing happens at the echo'd date/time. Could someone
please give me a clue where to start looking?  I'm running fedora core
4, my mobo is an ASUS P5S800-VM, the documentation on the motherboard
states that ACPI is supported. There is an option to turn acpi 2.0 on,
but no difference...
=09
	Any help is greatly appreciated!
=09
	Regards,
=09
	Ronald
=09


------_=_NextPart_001_01C5FEF7.ABAF4DDB
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2769" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D118043908-12122005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Do you have RTC driver compiled and loaded? =
CONFIG_RTC in=20
kernel .config?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D118043908-12122005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D118043908-12122005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Regards,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN =
class=3D118043908-12122005>&nbsp;&nbsp;&nbsp; <FONT=20
face=3DArial color=3D#0000ff size=3D2>Alex</FONT></SPAN></DIV><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> =
acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
  [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] <B>On Behalf Of =
</B>Ronald=20
  Wielink<BR><B>Sent:</B> Monday, December 12, 2005 12:30 =
AM<BR><B>To:</B>=20
  acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org<BR><B>Subject:</B> [ACPI] unable to =
set alam=20
  using echo to /proc/acpi/alarm<BR></FONT><BR></DIV>
  <DIV></DIV>Dear all,<BR>when I try setting the alarm to wake up my pc =
I get=20
  the following result:<BR><BR>[root@mithrandir acpi]#=20
  pwd<BR>/proc/acpi<BR>[root@mithrandir acpi]# cat alarm<BR>2005-12-00=20
  00:00:00<BR>[root@mithrandir acpi]# echo 2005-12-15 17:18:19 &gt;=20
  alarm<BR>[root@mithrandir acpi]# cat alarm<BR>2005-12-00=20
  17:18:19<BR>[root@mithrandir acpi]#<BR><BR>BTW, nothing happens at the =
echo'd=20
  date/time. Could someone please give me a clue where to start =
looking?&nbsp;=20
  I'm running fedora core 4, my mobo is an ASUS P5S800-VM, the =
documentation on=20
  the motherboard states that ACPI is supported. There is an option to =
turn acpi=20
  2.0 on, but no difference...<BR><BR>Any help is greatly=20
  =
appreciated!<BR><BR>Regards,<BR><BR>Ronald<BR></BLOCKQUOTE></BODY></HTML>=


------_=_NextPart_001_01C5FEF7.ABAF4DDB--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
