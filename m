From: Faye Pearson <faye-h3p4nEmjOm7by3iVrkZq2A@public.gmane.org>
Subject: P State manipulation on Compaq Evo N610c
Date: Sat, 20 Mar 2004 18:47:23 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403201847.23668.faye@zippysoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

In Oct. of last year, I was attempting to get speedstep working on the Compaq 
Evo N610c.

John Cagle said that there were 3 ways to control speedstep on the computer:

Intel Speedstep applet, ACPI 2.0 PPC objects, BIOS.

I tried a couple of things and then gave up.

Linux's P-states and cpufreq on unpatched Kernel 2.6.4:
acpi_processor_perf-0121 [320] acpi_processor_set_per: Transitioning from P0 
to P1
acpi_processor_perf-0141 [320] acpi_processor_set_per: Writing 0x00000084 to 
port 0x00b2
acpi_processor_perf-0162 [320] acpi_processor_set_per: Looking for 0x00000001 
from port 0x00b3
acpi_processor_perf-0185 [320] acpi_processor_set_per: Transition failed

As an aside, I tried speedstep-detect but it doesn't recognise the chipset:

marmite speedstep-detect-0.01 # ./speedstep-detect
dmi_scan: return:
DMI 2.3 present.
31 structures occupying 1210 bytes.
DMI table at 0x000FD8F0.
BIOS Vendor: Compaq
BIOS Version: 68P4F Ver. F.18
BIOS Release: 12/09/2003
System Vendor: Compaq
Product Name: Evo N610c (DJ121A#ABU)
Version:
Board Vendor: Compaq
Board Name: 07F4
Board Version: KBC Version   .
Trying Intel's int15 GSIC:
BIOS support GSIC call:
        signature: GSIC
        command port = 0x00b2
        command =      0x0082
        event port =   0x000100b3
        flags =        0x07d00000
probing chipsets: No supported chipset found.

lspci says that it is an 82845 Brookdale chipset.
The southbridge appears to be an 82801CAM (ICH3)

Has anyone had any success with this yet?  I did scour the archive since that 
time but couldn't find anything pertinent.

Thanks


Faye


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
