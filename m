From: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Mon, 01 Mar 2004 21:08:52 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4043ECB4.7080203@verizon.net>
References: <4038F499.2060302@verizon.net> <20040225182030.GG1214@elf.ucw.cz> <40410A69.3070800@verizon.net> <20040228220435.GD10530@elf.ucw.cz> <4041136B.9000904@verizon.net> <20040228230941.GA488@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040228230941.GA488-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>>>I tried playing with suspend to disk in kernel 2.6.3. It was a no go. I 
>>>>have highmem enabled on this machine which has 1 gig of RAM.
>>>>Going to try pmdisk.
>>>>  
>>>>
>>>>        
>>>>
>>>Forget pmdisk, that will not work anyway. Try running without highmem
>>>(at least for a test).
>>>      
>>>
>
>  
>
>>Should I also disable preemption?
>>    
>>
>
>Yes.
>								Pavel
>
>  
>
Pavel, I'm having some trouble understanding the swsusp.txt file. It 
states: " You must explicitly specify the swap partition to resume from with
``resume='' kernel option."

my swap partition resides in /dev/hda4

So I think  I need to do something like this?
# Boot up Linux by default.
#
default=Linux

image=/vmlinuz
        label=Linux
        read-only
append="hda=autotune resume=/dev/hda4"   <---- added this
#       restricted
#       alias=1

image=/vmlinuz.old
        label=LinuxOld
        read-only
append="ide0=ata100 hda=autotune"      
        optional
#       restricted
#       alias=2


image=/2.4.23
        label=2.4.23
        read-only
        optional


Is this correct, or do i pass the resume option at boot time as a LILO 
option?

Nick




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
