From: "Erik van Pienbroek" <admin-0LxUhLuGNoZIf6P1QZMOBw@public.gmane.org>
Subject: System hang when trying to enter sleep/standby state
Date: Sat, 8 Feb 2003 16:41:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <026401c2cf88$9b26d330$0a0110ac@erik>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

Since a few days I've got an new notebook, an Acer Aspire 1406LC (specs
can be found at
http://www.acer.nl/vi/page0.jsp-page78,,79,3,,,104,,,1623,,,,,,,,,,,,,,,,,10
4,3,,3,3,,,,3,,,,3,,,,3,,,,,,,,,,,3,,,0,0,3,,298126721.htm ).
Under Windows 2000 the sleep state works good (this has nothing to do with
ACPI if I'm right).
The standby state works also good.

Now I tried to use the ACPI functions under Linux.
I've installed Redhat 8.0 and compiled the latest 2.4 kernel with the latest
pre-patch (2.4.21-pre4) and the latest ACPI patch(20030125).
Because there isn't much documentation available about the acpi functions I
experimented a bit with the files in the /proc/acpi directory.

With my previous notebook I could issue the command 'apmsleep 12:00' to the
notebook which would let it suspend till 12:00.
Now with my notebook, I can't issue this command anymore (cause my new
notebook doesn't support APM, only ACPI).
Does anybody know if there is an tool/command to let the notebook suspend
till an specified time ?

I've seen there is a file named /proc/acpi/alarm there with an date+time in
it.
I tried to echo an date+time in it, but as soon as the command executed, my
notebook would hang.
Now I tried to install the 2.5.59 kernel with ACPI patch 20030125, but as
soon as the machine booted it would hang.
Now I tried the newest 2.5.59-bk2 patch and my notebook now normally boots.
The hang with the /proc/acpi/alarm is now solved, but as soon as the
date+time is set the
notebook continues to work normally and when the time is reached the
notebook would hang.
The /proc/acpi/sleep same story..if I echo '4' in it the notebook would
continue to work..if I echo '3' the
notebook would hang...with echo '5' the notebook would also hang...
Is this because the ACPI support isn't complete yet or am I doing something
wrong ?

Thanks in advance,

Erik van Pienbroek



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
