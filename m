From: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Mon, 01 Mar 2004 22:17:59 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4043FCE7.5040703@verizon.net>
References: <C386328088ED7F4E9F81AFBABDDF60DA045C6E87@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA045C6E87-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ow Mun Heng wrote:

>  
>
>>-----Original Message-----
>>From: Nick Lidakis [mailto:nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org]
>>Sent: Tuesday, March 02, 2004 10:57 AM
>>To: Ow Mun Heng
>>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: Re: [ACPI] Desktop and S3 suspend the Holy Grail of ACPI?
>>
>>
>>Ow Mun Heng wrote:
>>
>>    
>>
>>> 
>>>
>>>      
>>>
>>>>-----Original Message-----
>>>>From: Nick Lidakis [mailto:nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org]
>>>>        
>>>>
>>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>    
>>
>>>>Subject: Re: [ACPI] Desktop and S3 suspend the Holy Grail of ACPI?
>>>>
>>>>
>>>>Pavel Machek wrote:
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>>>Hi!
>>>>>
>>>>>
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>>>>>I tried playing with suspend to disk in kernel 2.6.3. It 
>>>>>>>>           
>>>>>>>>
>>>>>>>>                
>>>>>>>>
>>>>was a no go. I 
>>>>   
>>>>
>>>>        
>>>>
>>>>>>>>have highmem enabled on this machine which has 1 gig of RAM.
>>>>>>>>Going to try pmdisk.
>>>>>>>>
>>>>>>>>
>>>>>>>>      
>>>>>>>>
>>>>>>>>           
>>>>>>>>
>>>>>>>>                
>>>>>>>>
>>>>>>>Forget pmdisk, that will not work anyway. Try running 
>>>>>>>         
>>>>>>>
>>>>>>>              
>>>>>>>
>>>>without highmem
>>>>   
>>>>
>>>>        
>>>>
>>>>>>>(at least for a test).
>>>>>>>    
>>>>>>>
>>>>>>>         
>>>>>>>
>>>>>>>              
>>>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>>>Should I also disable preemption?
>>>>>>  
>>>>>>
>>>>>>       
>>>>>>
>>>>>>            
>>>>>>
>>>>>Yes.
>>>>>								Pavel
>>>>>
>>>>>
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>Pavel, I'm having some trouble understanding the swsusp.txt 
>>>>        
>>>>
>>file. It 
>>    
>>
>>>>states: " You must explicitly specify the swap partition to 
>>>>resume from with
>>>>``resume='' kernel option."
>>>>
>>>>my swap partition resides in /dev/hda4
>>>>
>>>>So I think  I need to do something like this?
>>>># Boot up Linux by default.
>>>>#
>>>>default=Linux
>>>>
>>>>image=/vmlinuz
>>>>       label=Linux
>>>>       read-only
>>>>append="hda=autotune resume=/dev/hda4"   <---- added this
>>>>   
>>>>
>>>>        
>>>>
>>>That's the way I'm doing it on Grub 
>>>
>>> 
>>>
>>>      
>>>
>>Then it should automatically resume next time the power button is 
>>pressed, no other options need to be passed at the LILO prompt?
>>    
>>
>
>
>Yep.. Er.. I'm using Grub.. but that should be not-related.
>
>
>-------------------------------------------------------
>SF.Net is sponsored by: Speed Start Your Linux Apps Now.
>Build and deploy apps & Web services for Linux with
>a free DVD software kit from IBM. Click Now!
>http://ads.osdn.com/?ad_id56&alloc_id438&op=click
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>  
>
Ok, it seems to work with a 2.6.3 kernel; highmem and preemtion disabled.
Can I ask you how you have USB enabled? Compiled into the kernel or as 
modules?
I could have sworn I erad something about ACPI swsusp and USB conflicts.

Do you use swsusp constantly, and do you find reliable so far?





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
