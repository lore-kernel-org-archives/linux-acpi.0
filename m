From: Andy Schofield <ajs-gB/hhe1nuPqwa9SdKMSz+Q@public.gmane.org>
Subject: ACPI on a HP TC1100 tabletpc
Date: Fri, 12 Mar 2004 15:39:11 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403121539.i2CFdBof028273@thpc30.ph.bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: ajs-gB/hhe1nuPqwa9SdKMSz+Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I am trying to get linux fully functional on my Hewlett Packard tc1100 
tabletpc.

I am using kernel 2.4.25 with the acpi patch 20040220, acpi debugging on and I 
have also compiled in the dsdt table via initrd patch

Some acpi aspects are working: cpu performance, thermal stuff.
but some things are not:

(1) Battery - I get nothing in /proc/acpi/battery

(2) There is a missing serial port. I think the serial port with the wacom pen 
device requires some sort of initialization by acpi, but at the moment my 
kernel finds nothing. The bios is able to use the pen. Under windows the pen 
is on port 03f8 and irq=4

(3) There is a radio kill switch somewhere which stops the wifi and blue tooth 
working. I don't know if this is anything to do with the acpi system.

What should I do now?

Thanks
Andy

The following can be found on my webpage:

Output of dmesg http://www.theory.bham.ac.uk/staff/schofield/linux/tc1100/dmesg
-2.4.25.txt

Output of lspci -vv
http://www.theory.bham.ac.uk/staff/schofield/linux/tc1100/lspci-2.4.25.txt

Output of acpidmp
http://www.theory.bham.ac.uk/staff/schofield/linux/tc1100/acpidmp-2.4.25.txt

Output of dmidecode
http://www.theory.bham.ac.uk/staff/schofield/linux/tc1100/dmidecode-2.4.25.txt

I have recorded my progress so far on a webpage

http://www.theory.bham.ac.uk/staff/schofield/linux/tc1100/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
