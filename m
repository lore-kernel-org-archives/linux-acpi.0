From: Richard Black <richard.black-VXdhtT5mjnY@public.gmane.org>
Subject: pacpidump and iasl
Date: Wed, 03 Dec 2003 16:40:21 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FCE6655.3000309@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Han Duong <handuong-d0mtIEKrxfl4piUD7e9S/g@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

A difference in dumping the DSDT table found between
pacpidump and iasl.  When compiling the pacpidump
version produces an error whereas the dump from iasl
compiles without error.

Original email below.

Sincerely,
Richard Black
http://www.cpqlinux.com/acpi-howto.html

-------- Original Message --------
Subject: ACPI Howto (possible errata)
Date: Wed, 3 Dec 2003 15:32:03 -0600 (CST)
From: Han Duong <handuong-d0mtIEKrxfl4piUD7e9S/g@public.gmane.org>
To: <richard.black-VXdhtT5mjnY@public.gmane.org>



Hi,

I was reading the ACPI howto from

http://www.cpqlinux.com/acpi-howto.html#downloads

and noticed that the program "pacpidump" DOES NOT give the same output as
using Intel's "iasl" program with the "-d" option. I own a Sony Vaio
V505BX and was curious about whether my DSDT was broken (the
/proc/acpi/fan directory exists, but is empty; everything else seems to
work fine) To make a long story short, "pacpidump" outputs the following
snippet of code for the DSDT table:

...

Method(CKOS) {
    If(CondRefOf(_OSI, Local0)) {
        If(\_OSI) {
            "Windows 2001"
            Store(0x4, Local4)
        }
    }

...

which produces an error when compiling using "isal -tc" shown below:

dsdt.asl  2171:         If(\_OSI) {
Error    1028 -                ^ Too few arguments (\_OSI requires 1)

dsdt.asl  2172:             "Windows 2001"
Error    1037 -                          ^ parse error, unexpected
PARSEOP_STRING_LITERAL


On the other hand, using "iasl -d dsdt.dat" produces the following
corresponding code snippet:

...

    Method (CKOS, 0, NotSerialized)
    {
        If (CondRefOf (_OSI, Local0))
        {
            If (\_OSI ("Windows 2001"))
            {
                Store (0x04, Local4)
            }
        }


...

Since "iasl -tc" produces two errors (both referrincing the code block
shown above when I use the output from "pacpidump" whereas no errors are
produced using the output from "tiasl -d" I think one might conclude that
"pacpidump" might not be as reliable for non-FreeBSD systems (I am
compiling for Linux 2.4.23). Perhaps Intel's tools should be the preferred
choice for DSDT disassembly?

Oh, in case you're wondering, pacpidump was obtained from

http://people.freebsd.org/~takawata/pacpidump.tar.gz

The version for Intel's iasl is 20030918 and is available from

http://developer.intel.com/technology/iapc/acpi/downloads.htm

Best wishes,
Han Duong





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
