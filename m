From: Constantinos Antoniou <costas-DPNOqEs/LNQ@public.gmane.org>
Subject: Compaq 1700T dsdt
Date: 04 Feb 2003 20:37:19 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1044409039.1642.17.camel@nefeli>
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

Hello,

Please excuse the very long message... I wanted to ask about three
somewhat related issues, but did not know whether I should split them
into more messages.

I have a Compaq 1700T and I can say that overall it has proved extremely
linux friendly. ACPI of course is a different story. I am currently
running 2.4.20+acpi-20021212, and finally I see some things under
/proc/acpi. However, I have not been able to go far beyond that.

[Just as a statement I would like to ultimately have to capabilities:
1. see the battery status, so -while on battery- I can know when it is
about to drain and have the option to shutdown gracefully, (this should
be doable)
2. be able to somehow sleep/suspend/hibernate the machine (avoid having
to boot/shutdown every time I need to use it). This is probably
trickier, and I would appreciate suggestions on what could be done at
this point (under basic assumptions like: I would rather not run
unstable kernels, etc).

I disassembled my dsdt (you can have a look at it at:
http://mit.edu/costas/www/CAdsdt.dsl)

./iasl -d /proc/acpi/dsdt  (had to do this as root, as dsdt was read
only for the root only)

then

./iasl -tc ./dsdt.dsl


The good news is that I only got warnings:

==================
[costas@localhost iasl-linux-20030123]$ ./iasl -tc ./dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030122 [Jan 23
2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

./dsdt.dsl   845:                         Name (PSIZ, 0x00)
Warning  2079 -           Statement is unreachable ^

./dsdt.dsl  2923:                         Method (_GLK, 1,
NotSerialized)
Warning  2024 -                                      ^ Reserved method
has too many arguments ( _GLK requires 0)

./dsdt.dsl  4516:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                  ^ Reserved method must return a value
(_WAK)

ASL Input:  ./dsdt.dsl - 4890 lines, 176234 bytes, 2364 keywords
AML Output: DSDT.aml - 21722 bytes 645 named objects 1719 executable
opcodes

Compilation complete. 0 Errors, 3 Warnings, 0 Remarks, 625 Optimizations
[costas@localhost iasl-linux-20030123]$
===========================

I have found hints on how to fix warning 2026
(http://www.cpqlinux.com/acpi-howto.html#fix_broken_dsdt), but nothing
on the other two. Is it critical that they are fixed?







Also, under /proc/acpi/battery, I have a directory CMB0. Shouldn't this
be BAT0 or sth? 


[costas@localhost CMB0]$ more state
present:                 yes
capacity state:          ok
charging state:          unknown             <=== shouldn't it know it
is charging?
present rate:            0 mW
remaining capacity:      3474 mWh
present voltage:         16742 mV
[costas@localhost CMB0]$ more info
present:                 yes
design capacity:         unknown
last full capacity:      unknown
battery technology:      rechargeable
design voltage:          unknown
design capacity warning: 800 mWh
design capacity low:     16 mWh
capacity granularity 1:  100 mWh
capacity granularity 2:  100 mWh
model number:            BAT1
serial number:           0000
battery type:            LION
OEM info:                COMPAQ
[costas@localhost CMB0]$






If I understand correctly, to make the machine sleep, I need to send a
number to the /proc/acpi/sleep?

[Where could I find a description of what each step is supposed to do?
My machine for example claims it supports S0, S1, S4, and S5...]

Also, a possibly naive/stupid question: Assuming I suspend/put to sleep
the machine, how would  I bring it back? Press the power button? 

Thanks in advance for any help (and for reading thus far, anyway! ;)

Costas



-- 
Constantinos Antoniou
Ph.D. Candidate
Massachusetts Institute of Technology
Intelligent Transportation Systems Program
77 Massachusetts Ave., NE20-208, Cambridge, MA 02139
(T) 617-252-1113 * (F) 617-252-1130 * (email) costas-3s7WtUTddSA@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
