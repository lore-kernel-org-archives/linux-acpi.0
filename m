From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: CALL FOR TESTING
Date: Tue, 24 Sep 2002 13:20:19 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B7A1@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "'tundras=SmH/eyArkOtWk0Htik3J/w@public.gmane.org'" <tundras-SmH/eyArkOtWk0Htik3J/w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This is the machine that has executable AML code at the root (not within a
control method.) 

I was able to fix the AE_STACK_UNDERFLOW issue, but the parser/interpreter
still does not have the ability to execute random AML code that is not
within a control method.

We are still investigating what is the proper course of action here and
whether we can execute such code without major architectural changes to the
AML interpreter.

Bob Moore


-----Original Message-----
From: tundras-SmH/eyArkOtWk0Htik3J/w@public.gmane.org [mailto:tundras@draconis.com] 
Sent: Monday, September 23, 2002 12:47 PM
To: Grover, Andrew
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Subject: Re: [ACPI] CALL FOR TESTING

Quoting Grover, Andrew <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:
> I wanted to make a special request for testing of the 2.4 patch (or should
I
> say, MEGA-patch).
> 
> Marcelo has asked for widespread testing of it, in anticipation of likely
> 2.4 mainline inclusion. I will be posting a call for testing to
linux-kernel
> soon, but am posting this here first to hopefully weed out any really bad
> bugs that may have crept in.
> 
> The main issues of importance are:
> 
> - DOES IT BOOT?

Yes, the machine boots.

Machine: HP Pavilion 501n
OS: Kernel 2.4.20-pre7 w/ ACPI 20020918. No other patches.

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

No. My earlier report on this machine was with AE_STACK_UNDERFLOW. Now it
reports Error: Acpi_load_tables: Could not load namespace: AE_AML_INTERNAL

/proc/acpi doesn't exist.

> 
> Failure to do so either indicates a bug that we need to fix (fast) or a
> system that should go on the blacklist. dmesg now includes the DSDT
> signature to aid blacklisting.

Is this the DSDT sig information you need?

ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6670
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x07cf7082
ACPI: FADT (v001 INTEL  Whitney  01540.00000) @ 0x07cfbf0a
ACPI: MADT (v001 PTLTD           APIC   01540.00000) @ 0x07cfbf7e
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x07cfbfd8
ACPI: DSDT (v001  INTEL  Whitney 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
