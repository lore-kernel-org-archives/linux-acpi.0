From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: vaio 505fx: GPE9: AE_NOT_FOUND
Date: Wed, 23 Oct 2002 15:13:25 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B891@orsmsx107.jf.intel.com>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'jeff' <jeff-bThHCuZ0d8s@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I disassembled your dsdt and recompiled it, here are the problems, very bad:


Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20021022 [Oct 22 2002]
Copyright (C) 2000 - 2002 Intel Corporation
Supports ACPI Specification Revision 2.0a

dsdt_orig.dsl   652:  \_SB.PCI0.MOON.SMIH ()
Error    1022 -   Object does not exist ^ (\_SB.PCI0.MOON.SMIH)

dsdt_orig.dsl   680:  \_SB.PCI0.MOON.SMIH ()
Error    1022 -   Object does not exist ^  (\_SB.PCI0.MOON.SMIH)

dsdt_orig.dsl   688:  Notify (\_SB.PCI0.MOON, 0x01)
Error    1022 -      Object does not exist ^  (\_SB.PCI0.MOON)

dsdt_orig.dsl   700:  Notify (\_TZ.ATF0, 0x80)
Error    1022 - Object does not exist ^  (\_TZ.ATF0)

dsdt_orig.dsl   706:  Notify (\_TZ.ATF0, 0x81)
Error    1022 - Object does not exist ^  (\_TZ.ATF0)

dsdt_orig.dsl   712:  Notify (\_TZ.ATF0, 0x80)
Error    1022 - Object does not exist ^  (\_TZ.ATF0)

dsdt_orig.dsl   718:  Notify (\_TZ.ATF1, 0x80)
Error    1022 - Object does not exist ^  (\_TZ.ATF1)

dsdt_orig.dsl   724:  Notify (\_TZ.ATF0, 0x81)
Error    1022 - Object does not exist ^  (\_TZ.ATF0)

dsdt_orig.dsl   730:  Notify (\_TZ.ATF1, 0x81)
Error    1022 - Object does not exist ^  (\_TZ.ATF1)

dsdt_orig.dsl  1925:       Return (NULL)
Error    1022 - Object does not exist ^  (NULL)

dsdt_orig.dsl  1972: Method (_SRS, 1, NotSerialized)
Warning  2019 -                 ^ Not all control paths return a value
(_SRS)

ASL Input:  dsdt_orig.dsl - 2850 lines, 107820 bytes, 1235 keywords
AML Output: DSDT.aml - 11407 bytes 413 named objects 822 executable opcodes

Compilation complete. 10 Errors, 1 Warnings, 0 Remarks, 237 Optimizations


 -----Original Message-----
From: jeff [mailto:jeff-bThHCuZ0d8s@public.gmane.org] 
Sent: Wednesday, October 23, 2002 2:08 PM
To: Moore, Robert
Subject: Re: [ACPI] vaio 505fx: GPE9: AE_NOT_FOUND

hi bob- attached is /proc/acpi/dsdt from the affected machine. thanks
for taking a look.

jeff


On Wed, Oct 23, 2002 at 10:54:53AM -0700, Moore, Robert wrote:
> 
> Please send me the binary DSDT from this machine, I'll take a look at the
> problem.
> 
> Thanks,
> Bob
> 
> 
> -----Original Message-----
> From: jeff [mailto:jeff-sf-bThHCuZ0d8s@public.gmane.org] 
> Sent: Tuesday, October 22, 2002 9:16 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] vaio 505fx: GPE9: AE_NOT_FOUND
> 
> hi folks-
> 
> i tried out 2.5.44 on an old Sony Vaio 505fx (p-mmx 266mhz), and i'm
> getting this message on console every couple seconds:
> 
> [ACPI Debug] String: SCI generated
> [ACPI Debug] Integer: 0000000000000082
>  psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
> Method pathname: \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
>  psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND 
> Method pathname:  \_GPE._E09 (Node c3fa3b14)
>  evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
