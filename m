From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI-Errors with battery, ac_adapter, thermal
Date: Thu, 23 Jan 2003 10:53:26 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BA50@orsmsx107.jf.intel.com>
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
To: 'Faye Pearson' <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>, Stefan Behnel <behnel-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This one looks suspiciously like a problem in the AML interpreter: 

>     ACPI-1102: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node
c12fba80), AE_AML_UNINITIALIZED_LOCAL

I am looking into it.
Bob


-----Original Message-----
From: Faye Pearson [mailto:faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org] 
Sent: Thursday, January 23, 2003 10:48 AM
To: Stefan Behnel
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] ACPI-Errors with battery, ac_adapter, thermal

Stefan Behnel [behnel-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org] wrote:
> I'm actually perfectly willing to invest some time into getting this 
> working if anyone could point me in the right direction.
> 
> I found the FAQ including the stuff about overriding the DSTD, but I 
> don't know how to fix such a table (the current one looks perfectly fine 
> to me...). Any more hints on that?

>     ACPI-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
>     ACPI-1102: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node
c12fba80), AE_AML_UNINITIALIZED_LOCAL
>     ACPI-0090: *** Error: No object was returned from
[\_SB_.PCI0.LPCB.SIOD.COMA._STA] (Node c12f2580), AE_NOT_EXIST
>     ACPI-1102: *** Error: Method execution failed [\_SB_.ADP1._STA] (Node
c12fb340), AE_AML_NO_RETURN_VALUE
>     ACPI-1102: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node
c12fb700), AE_AML_NO_RETURN_VALUE
>     ACPI-0322: *** Error: Handler for [embedded_control] returned
AE_BAD_PARAMETER
>     ACPI-1102: *** Error: Method execution failed [\_TZ_.THRM._TMP] (Node
c12fd7c0), AE_BAD_PARAMETER

These don't look fine.

You need iasl - google for intel iasl download

Disassembling your dsdt gives:

dsdt.dsl   178:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value
(_WAK)

Can be as simple as adding Return (Zero) to the end of the method but
check the function to see if that looks right.

dsdt.dsl  2322:                     Field (ECR, DWordAcc, Lock,
Preserve)
Error    1048 -                              ^ Host Operation Region
requires ByteAcc access

Use ByteAcc access!

dsdt.dsl  2887:                         Method (_STA, 0, NotSerialized)
Warning  2019 -                                    ^ Not all control
paths return a value (_STA)

dsdt.dsl  2887:                         Method (_STA, 0, NotSerialized)
Warning  2026 -                                    ^ Reserved method
must return a value (_STA)

Same issue as for _WAK.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

Keep your boss's boss off your boss's back.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
