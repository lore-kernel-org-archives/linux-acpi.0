From: Alf629 <Alf629-pWIpc5MZKA9BDgjK7y7TUQ@public.gmane.org>
Subject: ACPI locking up
Date: Tue, 30 Mar 2004 14:26:02 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <71f91779c8.779c871f91@email.bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-language: en
Content-Disposition: inline
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


Hi all,

I've just compiled kernel 2.6.4 and when I first boot it up, it hangs after this stage:

...
ACPI: Subsystem revision 20040220
tbxface-0117 [03] acpi_load_tables : ACPI Tables successfully acquired
Parsing all Control Methods:...........
Table [DSDT](id F005) - 647 Objects with 59 Devices 174 Methods 17 Regions
Parsing all Control Methods:..
Table [SSDT](id F003) - 3 Objects with 0 Devices 2 Methods 0 Regions
ACPI Namespace succesfully loaded at root c0440b5c
ACPI: IRQ9 SCI: Edge set to Level Trigger.  <- stops right here and stays there. no commands work (ctr-alt-del), only shutdown using the power button.


I've got a Toshiba TE2300 Laptop running a Pentium-M 1.3GHz. I compiled the kernel with ACPI support built-in and with Toshiba laptop extras as a module.

The initial kernels 2.6.1-1.65 and 2.6.3-2.1.253 from redhat both loaded asus_acpi instead of toshiba_acpi, and that is the main reason I've recompiled the kernel, this time without asus laptop support. Could that have any effect on the problem?

Also, I haven't patched the kernel with any of the acpi patches yet? Should I attempt to do that and compile again?

TIA for any advice,
Fred



                                                                      



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
