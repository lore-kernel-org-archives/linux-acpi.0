From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi data parser
Date: Mon, 14 Apr 2003 09:16:11 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BC8A@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C302A1.2A1D2850"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Eli Cohen' <eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org>, "'Randy.Dunlap'" <rddunlap-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C302A1.2A1D2850
Content-Type: text/plain

Apparently, the Linux version of the iASL disassembler has a problem.  The
Windows version is known to work OK.  We are looking at this problem.

 

Bob

 

 

-----Original Message-----
From: Eli Cohen [mailto:eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org] 
Sent: Monday, April 14, 2003 8:03 AM
To: 'Randy.Dunlap'; Eli Cohen
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: RE: [ACPI] acpi data parser

 

Intel's disassembler does a segmentation fault when trying -g option. Can
you send info on how to checkout pmtools from sourceforge?

thanks 

-----Original Message----- 
From: Randy.Dunlap [mailto:rddunlap-3NddpPZAyC0@public.gmane.org <mailto:rddunlap@osdl.org> ] 
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
moment).  See http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/acpi/
<http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/acpi/>  . 

There is an Intel disassembler (IASL) that I haven't used. 
I think it's in the Unix Build Environment tarball here: 
http://developer.intel.com/technology/iapc/acpi/downloads.htm
<http://developer.intel.com/technology/iapc/acpi/downloads.htm>  

and there could be another one soon. 

HTH. 
-- 
~Randy   ["in English any noun can be verbed."  bah!] 


------_=_NextPart_001_01C302A1.2A1D2850
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>

<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">


<meta name=Generator content="Microsoft Word 10 (filtered)">
<title>RE: [ACPI] acpi data parser</title>

<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
p
	{margin-right:0in;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle18
	{font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=EN-US link=blue vlink=blue>

<div class=Section1>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'>Apparently, the Linux version of the iASL
disassembler has a problem.&nbsp; The Windows version is known to work OK.&nbsp; We are
looking at this problem.</span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'>Bob</span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'>&nbsp;</span></font></p>

<div style='border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt'>

<p class=MsoNormal><font size=2 face=Tahoma><span style='font-size:10.0pt;
font-family:Tahoma'>-----Original Message-----<br>
<b><span style='font-weight:bold'>From:</span></b> Eli Cohen
[mailto:eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org] <br>
<b><span style='font-weight:bold'>Sent:</span></b> Monday, April 14, 2003 8:03
AM<br>
<b><span style='font-weight:bold'>To:</span></b> 'Randy.Dunlap'; Eli Cohen<br>
<b><span style='font-weight:bold'>Cc:</span></b>
acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org<br>
<b><span style='font-weight:bold'>Subject:</span></b> RE: [ACPI] acpi data
parser</span></font></p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>&nbsp;</span></font></p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>Intel's
disassembler does a segmentation fault when trying -g option. Can you send info
on how to checkout pmtools from sourceforge?</span></font></p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>thanks</span></font>
</p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>-----Original
Message-----</span></font> <br>
<font size=2><span style='font-size:10.0pt'>From: Randy.Dunlap [<a
href="mailto:rddunlap-3NddpPZAyC0@public.gmane.org">mailto:rddunlap@osdl.org</a>]</span></font> <br>
<font size=2><span style='font-size:10.0pt'>Sent: Monday, April 14, 2003 5:04
PM</span></font> <br>
<font size=2><span style='font-size:10.0pt'>To: Eli Cohen</span></font> <br>
<font size=2><span style='font-size:10.0pt'>Cc:
acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</span></font> <br>
<font size=2><span style='font-size:10.0pt'>Subject: Re: [ACPI] acpi data
parser</span></font> </p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>&nbsp;</span></font></p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>On Mon,
14 Apr 2003 11:14:43 +0300 Eli Cohen &lt;eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org&gt; wrote:</span></font>
</p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>| Hi,</span></font>
<br>
<font size=2><span style='font-size:10.0pt'>| is there any tool that can get
the acpi data in a system and parse it in a</span></font> <br>
<font size=2><span style='font-size:10.0pt'>| convenient way. Particularly the
interrupt routing information.</span></font> <br>
<font size=2><span style='font-size:10.0pt'>| thanks</span></font> <br>
<font size=2><span style='font-size:10.0pt'>| Eli</span></font> </p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>Hi,</span></font>
</p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>There are
several such tools.</span></font> </p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>At the
acpi sf project, there are &quot;pmtools&quot; in CVS (only at the</span></font>
<br>
<font size=2><span style='font-size:10.0pt'>moment).&nbsp; See <a
href="http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/acpi/" target="_blank">http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/acpi/</a>
.</span></font> </p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>There is
an Intel disassembler (IASL) that I haven't used.</span></font> <br>
<font size=2><span style='font-size:10.0pt'>I think it's in the Unix Build
Environment tarball here:</span></font> <br>
<font size=2><span style='font-size:10.0pt'><a
href="http://developer.intel.com/technology/iapc/acpi/downloads.htm"
target="_blank">http://developer.intel.com/technology/iapc/acpi/downloads.htm</a></span></font>
</p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>and there
could be another one soon.</span></font> </p>

<p><font size=2 face="Times New Roman"><span style='font-size:10.0pt'>HTH.</span></font>
<br>
<font size=2><span style='font-size:10.0pt'>--</span></font> <br>
<font size=2><span style='font-size:10.0pt'>~Randy&nbsp;&nbsp; [&quot;in
English any noun can be verbed.&quot;&nbsp; bah!]</span></font> </p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01C302A1.2A1D2850--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
