From: Alexander Sirotkin <demiurg-l0cyMroinI0@public.gmane.org>
Subject: Re: current ACPI status in 2.6.7 kernel
Date: Wed, 11 Aug 2004 10:48:58 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4119CF6A.8020807@ti.com>
References: <411881B1.9000903@ti.com> <1092132146.2666.3.camel@laptop.cunninghams> <4118D40D.5030404@ti.com> <4118F918.7070909@optonline.net> <4119024B.5060602@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4119024B.5060602-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



Nathan Bryant wrote:

> Nathan Bryant wrote:
>
>> Alexander Sirotkin wrote:
>>
>>>>> I could not find this information in neither mailing list archive 
>>>>> nor the web site.
>>>>> What is the current status of ACPI ? I'm mainly interested in one 
>>>>> simple question -
>>>>> does suspend work ? If so, how stable it is.
>>>>
>>
>>
>> Don't try it if you use any SCSI disks. IDE should be OK.
>
>
> Oh, and add many SATA adapters to that list. I think SATA is based on 
> the SCSI midlayer.

Thanks for the tip, fortunately I don't have any SCSI or SATA disks. 
Unfortunately, I still don't
know how to do this. Is there an utility to put PC into sleep/suspend ? 
I know I can switch
to various S modes using /proc entry, but what about all the peripherals 
and user mode apps ?
I would venture that there has to be some kind of subsystem in user mode 
to take care of
all this. I probably did not phrase my question right, but when I Asked 
if ACPI suspend/sleep
status is stable enough I was actually referring to the whole subsystem, 
not just kernel
support.

Thanks a lot.

-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
