From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: RE: ASL help with latest acpi and compaq presario 2800t
Date: Mon, 12 May 2003 11:15:14 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030512171515.56E29F7F42@voldemort.scrye.com>
References: <3ACA40606221794F80A5670F0AF15F842722C5@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F842722C5-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Sorry it took me so long to get back to you on this... 

>>>>> "Luming" == Luming Yu <Yu> writes:

Luming> I have made a patch for fixing compiling time error of
Luming> http://www.scrye.com/~kevin/dsdt.dsl-20030409 Would you please
Luming> apply it and see what's unusual and send boot log to me.

Well, I applied the patch and when I try and compile to a .hex file
with iasl I get: 


Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030228 [Feb 28 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.dsl-20030409    44: External (C1AF)
Error    1037 -                 ^ parse error, unexpected PARSEOP_EXTERNAL, expecting '}'

dsdt.dsl-20030409    52:                 Register (SystemIO, 0x08, 0x00, 0x0000000000001014)
Error    1037 -                                 ^ parse error, unexpected PARSEOP_REGISTER

ASL Input:  dsdt.dsl-20030409 - 4956 lines, 162783 bytes, 8 keywords
Compilation complete. 2 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

It doesn't seem to like the "External" keyword?

Any ideas?

kevin
--
Luming> 42,51d41 < { < < External (C1AF) < External (C1BA) < External
Luming> (C1BB) < External (C1B0) < External (C1B1) < External (C1B2) <
Luming> External (C1B3) < 52a43
>> {
Luming> 177,178c168,169 < If(\_OSI("Windows 2001")) < { ---
>> If(\_OSI) { "Windows 2001"
Luming> 2297c2288 < Name(_HID, "SYN0100") ---
>> Name(_HID, "*SYN0100")


Luming> Thanks, Luming


Luming> -----Original Message----- From: Kevin Fenzi
Luming> [mailto:kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org] Sent: 2003?4?10? 1:30 To: Yu,
Luming> Luming Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org Subject: RE:
Luming> [ACPI] ASL help with latest acpi and compaq presario 2800t


Luming> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1

>>>>> "Luming" == Luming Yu <Yu> writes:

Luming> Is dsdt.asl modified version. I compiled it, and my error
Luming> message is slightly different with yours.  Would you please
Luming> send the original dsdt.asl to me?

Luming> You can get the dsdt.dat and dsdt.dsl from:

Luming> http://www.scrye.com/~kevin/dsdt.dat-20030409
Luming> http://www.scrye.com/~kevin/dsdt.dsl-20030409

Luming> Those are from my laptop today using the iasl-20030228

Luming> Let me know if you need any more info.

Luming> Thanks, Luming

Luming> kevin -----BEGIN PGP SIGNATURE----- Version: GnuPG v1.2.1
Luming> (GNU/Linux) Comment: Processed by Mailcrypt 3.5.8
Luming> <http://mailcrypt.sourceforge.net/>

Luming> iD8DBQE+lFil3imCezTjY0ERAiNVAJ0RbLT1+K532UBaz31tLeIODB6tAwCdF/OF
Luming> 37iSC0J5jiZDJiEmC8G3QT8= =5jP8 -----END PGP SIGNATURE-----




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
