From: Cam <camilo-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org>
Subject: Re: Fixing broken DSDT - code suggestions for comment	please!
Date: Tue, 18 May 2004 01:54:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40A95EB3.5070206@mesias.co.uk>
References: <40A73460.2070407@mesias.co.uk> <1084822558.12353.365.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1084822558.12353.365.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Len

thanks for the feedback and comments,

Len Brown wrote:
> Please verify that you still have this problem
> when running the latest iasl:
> 
> http://www.intel.com/technology/IAPC/acpi/downloads.htm

I was working with iasl-linux-20030918 which I think is the latest. Do 
you think the Store(Local0, Local0) is an iasl bug? I can send the dsdt 
binary if you are interested.

>>Later there are two other errors not mentioned in the FAQ:
>>
>>dsdt.dsl  2390:                     Return (WQS (0x0E, Arg0))
>>Error    1029 -                               ^ Called method returns no 
>>value
>> 
>>
>>dsdt.dsl  2395:                     Return (WQSB (0x0E, Arg0))
>>Error    1029 - Called method returns no value ^
>> 

[... my bad fix snipped ...]

> no. the problem is that WQS and WQSB need to have Return() statements.

OK from another look at the code I see the declarations for the WQS and 
WQSB methods. I am struggling what to return from these. Zero? Arg0? 
Arg1? Some success/fail code? Any ideas? There are lots of calls to WQS 
and WQSB that mostly seem to discard the (not yet) returned value.


                 Method (WQSB, 2, NotSerialized)
                 {
                     If (LNot (LOr (\_SB.PCI0.ISA.EC0.FBAT, 
\_SB.PCI0.ISA.EC0.FTMP)))
                     {
                         Store (0x01, \_SB.PCI0.ISA.EC0.FQSB)
                         And (Arg1, 0xFF, Local0)
                         ShiftRight (Arg1, 0x08, Local1)
                         And (Local1, 0xFF, Local1)
                         Acquire (\_SB.PCI0.ISA.EC0.BNKM, 0xFFFF)
                         Store (Local1, \_SB.PCI0.ISA.EC0.CMD3)
                         Store (Local0, \_SB.PCI0.ISA.EC0.CMD2)
                         Store (Arg0, \_SB.PCI0.ISA.EC0.CMD1)
                         Store (0xE9, \_SB.PCI0.ISA.EC0.CMCM)
                         Release (\_SB.PCI0.ISA.EC0.BNKM)
                         Store (0x00, \_SB.PCI0.ISA.EC0.FQSB)
                     }
                 }
 

                 Method (WQS, 2, NotSerialized)
                 {
                     While (LOr (\_SB.PCI0.ISA.EC0.FBAT, 
\_SB.PCI0.ISA.EC0.FTMP))                    {
                         Noop
                     }
 

                     Store (0x01, \_SB.PCI0.ISA.EC0.FQSB)
                     And (Arg1, 0xFF, Local0)
                     ShiftRight (Arg1, 0x08, Local1)
                     And (Local1, 0xFF, Local1)
                     Acquire (\_SB.PCI0.ISA.EC0.BNKM, 0xFFFF)
                     Store (Local1, \_SB.PCI0.ISA.EC0.CMD3)
                     Store (Local0, \_SB.PCI0.ISA.EC0.CMD2)
                     Store (Arg0, \_SB.PCI0.ISA.EC0.CMD1)
                     Store (0xE9, \_SB.PCI0.ISA.EC0.CMCM)
                     Release (\_SB.PCI0.ISA.EC0.BNKM)
                     Store (0x00, \_SB.PCI0.ISA.EC0.FQSB)
                 }


-Cam


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
