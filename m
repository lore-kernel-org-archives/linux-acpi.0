From: "Gary L. Grebus" <glg-146jrH3mAPHQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI on Compaq Evo N800c
Date: Fri, 24 Jan 2003 01:14:19 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E30D9BB.1020202@grebus.com>
References: <3E30206B.8080201@iis.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E30206B.8080201-XoJDOot2J3yELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Neubauer <neu-XoJDOot2J3yELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 >I have a Compaq N800c Laptop and need a way get the machine to 
standby, >when closing the lid. I already tried:
...
 >ACPI:
 >The following holds for kernel versions 2.4.19, 2.4.20 (patched with 
 >latest acpi patch) and 2.5.59
 >- /proc/acpi exists
 >- however there is not /proc/acpi/battery entry

You need to use a patched DSDT to get the battery and button /proc/acpi 
entries to work.  Take a look at:
	http://www.scrye.com/~kevin/presario-2800.html
for a useful starting point (a Presario 2800 is the consumer version of 
the N800c.)  That said, I haven't been able to get standby to work on my 
2800.

Does anyone know what mechanism causes the lid button to turn off the 
display on these machines?  I'd like to control this by monitoring 
/proc/acpi/events, but something else seems to be picking up the button 
action and turning off the display (and doing so in a way that it 
doesn't turn on correctly).

	/gary



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
