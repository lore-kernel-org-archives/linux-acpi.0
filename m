From: Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Subject: Re: Changing IRQ`s at DSDT
Date: Tue, 30 Sep 2003 10:30:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F793F28.9040406@paceblade.com>
References: <3F780D1A.20908@paceblade.com> <200309291937.53825.adq_dvb@lidskialf.net> <3F793B88.60104@paceblade.com> <200309301215.13202.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200309301215.13202.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Andrew de Quincey schrieb:

>>hmm .. this patch doenst change too much ... .it only let run that code
>>in the else {} ?? right ?
>>    
>>
>
>yeah
>
>  
>
>>i used it but didnt found any difference ... all the IRQ`s which are
>>active stay active and i cannot change them
>>with my DSDT ...
>>
>>is there a way to not mark them as active and then be able to change
>>them like i want ???
>>    
>>
>
>Hmm, which bit of the DSDT are you changing them in? The _PRT? Try checking 
>out the _CRS method as well.. sometimes it is hardcoded to always return the 
>same value.
>
>_CRS is also how you mark an IRQ as active... if it returns nonzero, the code 
>assumes the BIOS allocated it (and that patch makes it not mess with it).
>  
>

this is a example piece of my DSDT ...
all the other LNK`s look the same beside the IRQ ( some use 10 ) and
the PIRX where X is the Number of the LNK

so what makes it hardcoded here ???
what exactly does this _CRS make it active .. and how can i change it ?
or am i suffering of an hardwired IRQ ?



Device (LNK8)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {5}
                    })
                    Name (RSRC, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Store ("LNK8_DIS", Debug)
                        Store (0x00, PIR8)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store ("LNK8_CRS", Debug)
                        CreateWordField (RSRC, 0x01, IRQ0)
                        Store (PIR8, Local0)
                        Store (DerefOf (Index (PIRI, Local0)), Local1)
                        If (Local1)
                        {
                            ShiftLeft (0x01, Local1, IRQ0)
                        }

                        Return (RSRC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        Store ("LNK8_SRS", Debug)
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (DerefOf (Index (PIIR, Local0)), PIR8)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        Store ("LNK8_STA", Debug)
                        If (PIR8)
                        {
                            Return (0x0B)
                        }

                        Return (0x09)
                    }
                }

>
>  
>

-- 
_____________________________________
*Robert Woerle
Linux & Customer Support*
*PaceBlade Technology Europe SA*
phone: 	+49 89 552 99935
fax: 	+49 89 552 99910
mobile: 	+49 179 474 45 27
email: 	robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org <mailto:robert@paceblade.com>
web: 	http://www.paceblade.com
_____________________________________






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
