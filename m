From: "Vesko T. Tomov" <vtomov-DPNOqEs/LNQ@public.gmane.org>
Subject: Inspiron 8100: lid + klaptop
Date: Wed, 01 Sep 2004 16:52:40 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094071960.3266.35.camel@vtomov.mgh.harvard.edu>
Reply-To: vtomov-DPNOqEs/LNQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=-w5O7p8HUV1SHHA3PvicV"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-w5O7p8HUV1SHHA3PvicV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I have a couple of basic questions re ACPI.  (I am very new to Linux!)

I have a Dell Inspiron 8100 laptop with the most recent BIOS (A15) and
Fedora Core 2 installed.  The video card is Nvidia GeForce 2 Go and I
have installed the latest nvidia driver (6106).  I do not have a DSDT
patch applied.  I have ACPI enabled and the ACPI demon installed but so
far do not have any actions or events defined in /etc/acpi, except for
the sample file that shuts down the machine when I press the power
button.

My first question has to do with the fact that whenever I close the lid
and re-open it, the screen remains blank.  I googled around and this
seems to be a common Dell issue.  I can get around it by switching to
console (Ctr-Alt-F1) and then back to X (Alt-F7) but this seems
annoying.  I downloaded some other people's lid-actions but those were
written for different Dells and versions of Linux and result in errors
in /var/log/acpid.    Can anyone provide me with a simple script that
would turn off the monitor when I close the lid and then turn it back on
when I re-open it?  I don't need the machine to go into standby or
anything like that.

My second question is about the difference between KDE's klaptop and
acpid.  Are these two alternative programs for controlling ACPI?  Do
they conflict with each other?  I was happy to find that under the KDE
control center there was a whole section to configure things such as
standby, suspend, and screen behavior.  But when I try to put the
computer in any of these states by using klaptop, everything freezes and
I have to shut it down.  Is there a way to actually use klaptop?  Where
are its configuration files written?

Thanks for everyone's help!

Vesko



 

--=-w5O7p8HUV1SHHA3PvicV
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
Hello,<BR>
<BR>
I have a couple of basic questions re ACPI.&nbsp; (I am very new to Linux!)<BR>
<BR>
I have a Dell Inspiron 8100 laptop with the most recent BIOS (A15) and Fedora Core 2 installed.&nbsp; The video card is Nvidia GeForce 2 Go and I have installed the latest nvidia driver (6106).&nbsp; I do not have a DSDT patch applied.&nbsp; I have ACPI enabled and the ACPI demon installed but so far do not have any actions or events defined in /etc/acpi, except for the sample file that shuts down the machine when I press the power button.<BR>
<BR>
My first question has to do with the fact that whenever I close the lid and re-open it, the screen remains blank.&nbsp; I googled around and this seems to be a common Dell issue.&nbsp; I can get around it by switching to console (Ctr-Alt-F1) and then back to X (Alt-F7) but this seems annoying.&nbsp; I downloaded some other people's lid-actions but those were written for different Dells and versions of Linux and result in errors in /var/log/acpid.&nbsp;&nbsp;&nbsp; Can anyone provide me with a simple script that would turn off the monitor when I close the lid and then turn it back on when I re-open it?&nbsp; I don't need the machine to go into standby or anything like that.<BR>
<BR>
My second question is about the difference between KDE's klaptop and acpid.&nbsp; Are these two alternative programs for controlling ACPI?&nbsp; Do they conflict with each other?&nbsp; I was happy to find that under the KDE control center there was a whole section to configure things such as standby, suspend, and screen behavior.&nbsp; But when I try to put the computer in any of these states by using klaptop, everything freezes and I have to shut it down.&nbsp; Is there a way to actually use klaptop?&nbsp; Where are its configuration files written?<BR>
<BR>
Thanks for everyone's help!<BR>
<BR>
Vesko<BR>
<BR>
<BR>
<BR>
 
</BODY>
</HTML>

--=-w5O7p8HUV1SHHA3PvicV--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
