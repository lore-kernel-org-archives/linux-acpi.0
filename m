From: Michael Doube <m.doube-aUOafQfIvX+1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: DSDT bugs on Acer Aspire 3023 WLMi - SOLVED
Date: Thu, 06 Oct 2005 16:27:03 +1300
Message-ID: <43449987.3080001@qmul.ac.uk>
References: <433CE376.60503@qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <433CE376.60503-aUOafQfIvX+1Qrn1Bg8BZw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks to Benjamin Larsson for the tip:

1) Leave the DSDT alone - it is buggy but battery monitoring can work anyway
2) Install a recent kernel, 2.6.13 and above apparently.  I am using 
Fedora's 2.6.13-1.1526_FC4.i686 kernel
3) use kernel option ec_burst=1

Now battery monitoring works, and dmesg gives:
----------
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
------------

Sweet as.

Thanks to whoever was responsible for making this work, your effort is 
much appreciated.

Mike

Michael Doube wrote:

> Hi all
>
> I've been trying to get the smart battery system going on my Acer 
> Aspire 3023 WLMi notebook under kernel 2.6.12.2.  As far as I'm aware 
> the 3023 is a variant of (but basically very similar to) all the 3020 
> and 5020 notebooks.  It is quite different to the 3000 / 5000 series.
>
> I've tried the sbs-cm patch (took a punt, didn't work), and I've tried 
> the instructions at ACPI4Linux.
>
> I've managed to remove some of the bugs from the dsdt.dsl using the 
> error and warning messages from the iasl compiler, but still these 
> warnings remain, and I don't know how to get smart battery monitoring 
> going.  My most bug-free dsdt.dsl is posted at 
> http://acpi.sourceforge.net/dsdt/view.php?id=451.
>
> dmesg gives:
> ---------------------------
> ....
> ACPI: Embedded Controller [EC0] (gpe 3)
> ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
> ACPI-1138: *** Error: Method execution failed 
> [\_SB_.PCI0.LPC0.EC0_.BAT0._STA] (Node f7eeb6e0), AE_TIME
> ACPI-0158: *** Error: Method execution failed 
> [\_SB_.PCI0.LPC0.EC0_.BAT0._STA] (Node f7eeb6e0), AE_TIME
> ...
> ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
> ACPI-1138: *** Error: Method execution failed [\_TZ_.TZS0._TMP] (Node 
> f7ef2540), AE_TIME
> ACPI: Thermal Zone [TZS0] (60 C)
> ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
> ACPI-1138: *** Error: Method execution failed [\_TZ_.TZS1._TMP] (Node 
> f7ef2440), AE_TIME
> ACPI: Thermal Zone [TZS1] (47 C)
> ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
> ACPI-1138: *** Error: Method execution failed [\_TZ_.TZSV._TMP] (Node 
> f7ef2320), AE_TIME
> ACPI: Thermal Zone [TZSV] (51 C)
> ............
> ACPI wakeup devices:
> LID0 SLPB OHC1 OHC2 EHCI P2P MODM
> ACPI: (supports S0 S3 S4 S5)
>
> -----------------------
>
> [root@doris mdoube]# iasl -tc dsdt.dsl
>
> Intel ACPI Component Architecture
> ASL Optimizing Compiler version 20050902 [Sep 29 2005]
> Copyright (C) 2000 - 2005 Intel Corporation
> Supports ACPI Specification Revision 3.0
>
> dsdt.dsl 743: Name (_WDG, Buffer (0x3C)
> Warning 2097 - ^ Unknown reserved name (_WDG)
>
> dsdt.dsl 762: Method (_WED, 1, NotSerialized)
> Warning 2085 - ^ Not all control paths return a value (_WED)
>
> dsdt.dsl 762: Method (_WED, 1, NotSerialized)
> Warning 2097 - Unknown reserved name ^ (_WED)
>
> dsdt.dsl 3361: Release (MTIO)
> Warning 2098 - Statement is unreachable ^
>
> ASL Input: dsdt.dsl - 5692 lines, 200128 bytes, 2373 keywords
> AML Output: DSDT.aml - 22023 bytes 777 named objects 1596 executable 
> opcodes
>
> Compilation complete. 0 Errors, 4 Warnings, 0 Remarks, 824 Optimizations
> --------------------------------
>
> All suggestions are most welcome
>
> Mike
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
