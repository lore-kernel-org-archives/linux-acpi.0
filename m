From: Duncan Gibb <duncan-h9eRTumTmmZjMu4AB9qoK9F8XQ1HzYRO@public.gmane.org>
Subject: Compaq Evo N800c - strange DSDT
Date: 08 Nov 2002 19:31:18 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036783878.10258.40.camel@carwash.duncangibb.com>
Mime-Version: 1.0
Content-Type: text/plain
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

Hi

I've come to this list for entirely selfish reasons - that I want the
power management to work on my shiney new HPaq Evo N800c laptop - but I
promise to try to be helpful while I'm here.

I have compiled a 2.4.20-rc1 kernel with the 20021101 ACPI patches. 
Out-of-the box, CPU throttling and thermal work, but AC claims always to
be on-line and /proc/acpi/battery is not created :-(

I ran /proc/acpi/dsdt ("Creator ID:  MSFT") through iasl -d and found
that all the HIDs except ACPI0003 have leading asterisks.  Maybe MSFT
didn't read section 6.1.4 of the spec ;-)

Anyway, as a quick-and-dirty, I bunged a few strategic "*"s into
acpi_devices.h and recompiled. I now have working AC status, battery
status, mostly-working battery info, fan state reporting and some
control, plus CPU throttling and thermal which worked before.  Sleep
state 5 works too, but I don't think I'll be testing that too often ;-)

The names of the devices are a bit off the planet, mind: the CPU is
"C000", the internal battery is "C11C".  And no sign of the lid switch
working.  Can't do much debugging because the machine won't boot with
debugging on (same semaphore problems as someone else posted a little
while ago, but my machine has no serial port).


So, some advice, please:

Am I right in thinking it would be smarter to try to put together a more
Linux-friendly substitute DSDT than mess up the acpi code trying to deal
with the one in this BIOS?

Is there much point trying to get low-level info out of HP/Compaq or
should I just guess what to do based on the disassembly of the MSFT one?

Do Compaq have some higher reason for messing with the HIDs or is the
MSFT BIOS designed only to work with the Microsoft OSes it seems to be
written to detect?


Cheers


Duncan




-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
