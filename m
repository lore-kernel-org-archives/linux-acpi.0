From: Christian Neubauer <neu-XoJDOot2J3yELgA04lAiVw@public.gmane.org>
Subject: ACPI on Compaq Evo N800c
Date: Thu, 23 Jan 2003 18:03:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E30206B.8080201@iis.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, Christian Neubauer <neu-XoJDOot2J3yELgA04lAiVw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dear ACPI developers,

I have a Compaq N800c Laptop and need a way get the machine to standby, 
when closing the lid. I already tried:

APM:
cat /proc/apm tells me -1% for the battery status with the kernels 
2.4.19, 2.4.20, 2.5.59. ACPI was not compiled in. apm -s returns 
immediatelly without putting the machine to sleep.

ACPI:
The following holds for kernel versions 2.4.19, 2.4.20 (patched with 
latest acpi patch) and 2.5.59
- /proc/acpi exists
- however there is not /proc/acpi/battery entry
- echo 1 > /proc/acpi/sleep does nothing
- cat /proc/acpi/sleep tells S0 S3 S4 S5
- drivers battery, button, processor etc are loaded when I lsmod
- dmesg tells me that acpi is turned on

I use the latest BIOS patch for this machine. I dont knwo what to do 
next. I have seen similar posts for this machine on the net. Is anybody 
out there that help me or has a patch for that problem?

Regards
Christian



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
