From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Problem with Compaq Evo N110
Date: Thu, 22 Aug 2002 11:22:59 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B707@orsmsx107.jf.intel.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "'Black, Richard (Hou)'" <Richard.Black-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: SLIVER` <sliver-qqXEv8jiLWqhPH1hqNUYSQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


With this return statement:

                Return(TPTM)

                Store("Current Temperature C is ----------- ", Debug)
                Store(Local0, Debug)
                If(LGreater(Local0, 0x56)) {
                    Store(0x56, Local0)
                }
You will never get to execute the uninitialized Local0 code anyway, so you
may as well just comment it all out.

Bob


-----Original Message-----
From: Black, Richard (Hou) [mailto:Richard.Black-VXdhtT5mjnY@public.gmane.org] 
Sent: Thursday, August 22, 2002 10:59 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: SLIVER`
Subject: RE: [ACPI] Problem with Compaq Evo N110

We need help with the following error (this is for Luca Memini<SLIVER>):

Error   1013 -    Method local variable is not initialized (Local0)

It appears that Local0 isn't being loaded with a proper 
value.  Now the question is what value to load Local0 with???

Here's the output:

dreams@norad:~/acpi/iasl-linux-20020725$ ./iasl -tc /tmp/acpi/dsdt.asl.new

Intel ACPI Component Architecture
ASL Compiler / AML Disassembler version 20020725 [Jul 25 2002]
Copyright (C) 2000 - 2002 Intel Corporation
Supports ACPI Specification Revision 2.0a

/tmp/acpi/dsdt.asl   257:                 Store(Local0, Debug)
Error   1013 -                                       ^ Method local 
variable is not initialized (Local0)

/tmp/acpi/dsdt.asl   258:                 If(LGreater(Local0, 0x56)) {
Error   1013 -    Method local variable is not initialized ^  (Local0)

ASL Input: /tmp/acpi/dsdt.asl - 2357 lines, 84721 bytes, 1702 keywords
Compilation complete. 2 Errors 0 Warnings

Files are located at http://nirvana.cuore.org/acpi/ (dsdt.asl 
dsdt.asl.new dsdt.dat)

Also when reviewing the dsdt.asl.new that is posted, if you 
search for "Store(Local0, Debug)" it will be the first one
you come to.  Here is the relative section taken from dsdt.asl.new:

        Method(_TMP) {
            If(\_SB_.OKEC) {
                If(LEqual(INBT, 0x0)) {
                    Store(0x1, INBT)
                    \_SB_.BAT1.SEBI()
                    Notify(\_SB_.ACAD, 0x0)
                    Notify(\_SB_.BAT1, 0x81)
                    Notify(\_SB_.BAT1, 0x80)
                }
                Return(TPTM)
                Store("Current Temperature C is ----------- ", Debug)
                Store(Local0, Debug)
                If(LGreater(Local0, 0x56)) {
                    Store(0x56, Local0)
                }
                Store(Local0, Local2)
                Multiply(Local0, 0xa, Local1)
                Add(Local1, TBSE, Local0)
                Store("Current Temperature K is ----------- ", Debug)
                Store(Local0, Debug)
                CHTR(Local2)
                Return(Local0)
            }
            Else {
                Return(TPTM)
            }
        }
Thanks in Advance,
Richard Black


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
