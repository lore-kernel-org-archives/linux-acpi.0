From: "Rockefeller, Harry" <harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org>
Subject: exfldio-0178 warning ACPI AML errors
Date: Fri, 13 Feb 2004 11:14:20 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7105F2BD9451D7479B4B3A99A2B72FAC0566B43B@exchange1.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3F254.D164CD7C"
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

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3F254.D164CD7C
Content-Type: text/plain

My notebook computer: Uniwill N351S1.
kernel 2.6.2 on top of a RH 9 install.

Problem: I get the subject-line warning about broken ACPI AML
nag manufacturer to correct it.
I do have CONFIG_ACPI_DEBUG and CONFIG_ACPI_RELAXED_AML set.
So, I get this and a couple other lines about three times 
separated by several seconds over a total time span of
about 20 seconds.

A_solution: I interrupt boot up at the Grub splash screen.
Wait 30 seconds or longer then continue to boot.  I don't get
the above messages.

Fix: My one voice (emails to Uniwill) fall on dead ears.

Questions:
Is this information useful to any on this list?

Is Uniwill simply ignoring my email?  In other words
can Uniwill really "fix" this with a new BIOS release?

Does this mean kernel params such as apm=on and acpi=off
are useless since obviously ACPI is already doing something
even before the kernel is selected on the grub splash screen?

------_=_NextPart_001_01C3F254.D164CD7C
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=US-ASCII">
<META NAME="Generator" CONTENT="MS Exchange Server version 5.5.2657.73">
<TITLE>exfldio-0178 warning ACPI AML errors</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=2>My notebook computer: Uniwill N351S1.</FONT>
<BR><FONT SIZE=2>kernel 2.6.2 on top of a RH 9 install.</FONT>
</P>

<P><FONT SIZE=2>Problem: I get the subject-line warning about broken ACPI AML</FONT>
<BR><FONT SIZE=2>nag manufacturer to correct it.</FONT>
<BR><FONT SIZE=2>I do have CONFIG_ACPI_DEBUG and CONFIG_ACPI_RELAXED_AML set.</FONT>
<BR><FONT SIZE=2>So, I get this and a couple other lines about three times </FONT>
<BR><FONT SIZE=2>separated by several seconds over a total time span of</FONT>
<BR><FONT SIZE=2>about 20 seconds.</FONT>
</P>

<P><FONT SIZE=2>A_solution: I interrupt boot up at the Grub splash screen.</FONT>
<BR><FONT SIZE=2>Wait 30 seconds or longer then continue to boot.&nbsp; I don't get</FONT>
<BR><FONT SIZE=2>the above messages.</FONT>
</P>

<P><FONT SIZE=2>Fix: My one voice (emails to Uniwill) fall on dead ears.</FONT>
</P>

<P><FONT SIZE=2>Questions:</FONT>
<BR><FONT SIZE=2>Is this information useful to any on this list?</FONT>
</P>

<P><FONT SIZE=2>Is Uniwill simply ignoring my email?&nbsp; In other words</FONT>
<BR><FONT SIZE=2>can Uniwill really &quot;fix&quot; this with a new BIOS release?</FONT>
</P>

<P><FONT SIZE=2>Does this mean kernel params such as apm=on and acpi=off</FONT>
<BR><FONT SIZE=2>are useless since obviously ACPI is already doing something</FONT>
<BR><FONT SIZE=2>even before the kernel is selected on the grub splash screen?</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C3F254.D164CD7C--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
