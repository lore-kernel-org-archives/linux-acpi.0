From: Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Subject: Using INITRDDSDT:  was Re: Changing IRQ`s at DSDT
Date: Wed, 01 Oct 2003 06:27:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F7A57B0.6040906@paceblade.com>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi

so now i managed it ( i think )

as i said i was suffering from a hard lock on my unit when using 2 out 
of the 3 devices which use IRQ 5 ( eth0 , sound , usb ) at the same time .
I now changed my DSDT and provided eth0 to IRQ 7 ( which is not obviosly 
used before ) and it looks good ...
a stress test with 2 GB traffic on eth0 , while playing the whole 
Metallica -St. Anger album and using contiounsly my USB-keyboard ..
gave me no lock at all ....

i am now convinced that this will be the way to go and  i will do 
further more testing .

Of course ( like always ) i already discovered a new flaw with my new 
configuration .
Since i want to use swsusp i get now a hard lock after i resume and 
bring the eht0 up again ...

I am blaming swsusp for that ( i will contact their devel-list today) . 
Maybe they do not act
probably to restore a selfmade DSDT IRQ context .....

we will see ..

Suggestion :  Why dont you guys put the "Read DSDT from initrd " into 
the core ACPI source .. so that it gets
merged to the vanilla kernel at one point .
I really like idea to be able to load fixed DSDT`s . This can also be 
extended by the big distributions then to implement a routine
in their hardware scan so if a known Mainboard with  a buggy BIOS 
version ( is there a tool to check the version string of a BIOS ?? ) is
found they can load a fixed DSDT ....
This would be a great thing which ACPI enable`s us and so make Linux run 
even better on more units ...

Cheers Rob

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
>
>
>-------------------------------------------------------
>This sf.net email is sponsored by:ThinkGeek
>Welcome to geek heaven.
>http://thinkgeek.com/sf
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
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
