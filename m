From: Phil Short <justswitch-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: Problem with Toshiba 1005-S157 DSDT
Date: Thu, 15 Aug 2002 00:00:31 -0500 (CDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020814235326.H49229-100000@Grayswandir.cygnet_hq>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

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
Warning 2026 -                        ^ Reserved method must return a value (_DOD)

dsdt.asl   848:                 SRST,   1,
Error   1051 -                     ^ Access width of Field Unit extends beyond region limit

dsdt.asl   851:                 ACPW,   1
Error   1051 -                     ^ Access width of Field Unit extends beyond region limit

dsdt.asl  2256:                 Field(ERAM, AnyAcc, Lock, Preserve) {
Error   1048 -                           ^ Host Operation Region requires ByteAcc access

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
