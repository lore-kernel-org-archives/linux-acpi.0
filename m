From: "JLac" <jlacvdr-6bugY6I12JBBDgjK7y7TUQ@public.gmane.org>
Subject: ACPI does''t work on my Pundit asus !
Date: Sun, 21 Mar 2004 21:03:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <NEBBJBIJELCOLFMEMIIIIEJPFBAA.jlacvdr@ifrance.com>
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

Hello,

I would like shuting down my computer when I press the power button (through
the shutdown script).
I install the acpi but nothing happens when I press the button

I read different web page about it, and the how-to, but it's not enough for
my problem...

My configuration is :
Hardware :
	Asus Pundit (http://www.asus.com/products/desktop/pundit/overview.htm)

Software :
	Linux distrib. Debian with kernel source 2.4.24
	Patch ACPI : acpi-20040311-2.4.24

I compile and install the kernel with this configuration :
	in General Setup
	 [*] Power Management support
	 < > APM
	 [*] ACPI Support
	   <M> Button


In fact, I can see the directory /proc/acpi
and after loading the button module, a new directory /proc/acpi/button and a
sub-directory power
I execute a 'cat /proc/acpi/event' nothing is displayed when I press the
power button.

I also try with the acpid daemon but it doesn't work neither. (and also with
2.4.25 kernel)

What is my mistake ?
What have I forgotten ?

Thanks,

Best Regards,




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
