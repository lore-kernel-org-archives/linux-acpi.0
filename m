From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Problem with Toshiba 1005-S157 DSDT
Date: Thu, 15 Aug 2002 10:02:51 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B6E3@orsmsx107.jf.intel.com>
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
To: "'Black, Richard (Hou)'" <Richard.Black-VXdhtT5mjnY@public.gmane.org>, Phil Short <justswitch-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> dsdt.asl   281:                 If(\_OSI) {
>> Error   1022 -   Object does not exist ^  (\_OSI)


Add "External (\_OSI)".  The next version of the compiler understands that
_OSI is a reserved method name and the External won't be required.


dsdt.asl   848:                 SRST,   1,
Error   1051 -                     ^ Access width of Field Unit extends
beyond region limit


Increase the length of the parent operation region

dsdt.asl  2256:                 Field(ERAM, AnyAcc, Lock, Preserve) {
Error   1048 -                           ^ Host Operation Region requires
ByteAcc access

Any operation region in EC space must use ByteAcc, change the region
declaration

Bob

-----Original Message-----
From: Black, Richard (Hou) [mailto:Richard.Black-VXdhtT5mjnY@public.gmane.org] 
Sent: Thursday, August 15, 2002 8:53 AM
To: Phil Short; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: RE: [ACPI] Problem with Toshiba 1005-S157 DSDT

1) When you get the following errors:

>> dsdt.asl   134: Method(_WAK, 1) {
>> Warning 2026 -            ^ Reserved method must return a value (_WAK)

You should probably add a "Return(0x0)" on a new 
line just before the closing curly brace like so:

Method(_WAK, 1) {
... ... ...
Return(0x0)
}

2) When you get the following errors:

>> dsdt.asl   281:                 If(\_OSI) {
>> Error   1022 -   Object does not exist ^  (\_OSI)

You should probably look for any "Scope" lines and add the leading "\" there
that is missing:

Change from:
Scope(_SB_) {
to:
Scope(\_SB_) {

Also ignore any "name" lines that do not have the leading slash.  I do not
believe that the name lines would have to be modified in this manner.  I
believe that it is written in such a way that the "\" among other stuff is
prepended to the beginning of these "name" lines.

3) When you get the following errors:

>> dsdt.asl   848:                 SRST,   1,
>> Error   1051 -                     ^ Access width of Field Unit extends
beyond region limit

I don't know what to do with this.  I too am stuck with the "Access width of
Field Unit extends beyond region limit" error and don't know what to do with
it.

4) Fix the errors and the warnings may go away (warnings might be caused by
the errors).

Let's see what's left after making these corrections.

Sincerely,
Richard Black
http://www.cpqlinux.com
http://www.geocities.com/rlcomp_1999
http://www.compaq.com/linux


-----Original Message-----
From: Phil Short [mailto:justswitch-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org]
Sent: Thursday, August 15, 2002 12:01 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Problem with Toshiba 1005-S157 DSDT


Hello,

I'm having problems with acpi on this laptop.  Following the procedure
outlined by Richard Black a week or so ago, I obtained the dsdt.dat file
(may be viewed at http://home.earthlink.net/~justswitch) and used this
file as input to the iasl compiler (without making any changes),
generating the following error message:


Intel ACPI Component Architecture
ASL Compiler / AML Disassembler version 20020725 [Jul 25 2002]
Copyright (C) 2000 - 2002 Intel Corporation
Supports ACPI Specification Revision 2.0a

dsdt.asl   134: Method(_WAK, 1) {
Warning 2026 -            ^ Reserved method must return a value (_WAK)

dsdt.asl   280:             If(CondRefOf(_OSI, Local0)) {
Error   1022 -        Object does not exist ^  (_OSI)

dsdt.asl   281:                 If(\_OSI) {
Error   1022 -   Object does not exist ^  (\_OSI)

dsdt.asl   282:                     "Windows 2001"
Error   1037 -                       parse error ^

dsdt.asl   566:             Method(_DOD) {
Warning 2019 -                        ^ Mixed return types in method (_DOD)

dsdt.asl   566:             Method(_DOD) {
Warning 2026 -                        ^ Reserved method must return a value
(_DOD)

dsdt.asl   848:                 SRST,   1,
Error   1051 -                     ^ Access width of Field Unit extends
beyond region limit

dsdt.asl   851:                 ACPW,   1
Error   1051 -                     ^ Access width of Field Unit extends
beyond region limit

dsdt.asl  2256:                 Field(ERAM, AnyAcc, Lock, Preserve) {
Error   1048 -                           ^ Host Operation Region requires
ByteAcc access

ASL Input: dsdt.asl - 3250 lines, 135282 bytes, 2300 keywords
Compilation complete. 6 Errors 3 Warnings


Could someone please give me a hint on where to procede from here to
create an error-free dsdt file?

Thanks,

Phil




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
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
