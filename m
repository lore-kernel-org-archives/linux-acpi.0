From: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Tue, 02 Mar 2004 16:51:20 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <404501D8.8090506@verizon.net>
References: <4038F499.2060302@verizon.net> <20040225182030.GG1214@elf.ucw.cz> <40410A69.3070800@verizon.net> <20040228220435.GD10530@elf.ucw.cz> <4041136B.9000904@verizon.net> <20040228230941.GA488@elf.ucw.cz> <4043ECB4.7080203@verizon.net> <20040302101904.GA303@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040302101904.GA303-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
>>>>Should I also disable preemption?
>>>>        
>>>>
>>>Yes.
>>>      
>>>
>
>  
>
>>Pavel, I'm having some trouble understanding the swsusp.txt file. It 
>>states: " You must explicitly specify the swap partition to resume from with
>>``resume='' kernel option."
>>
>>my swap partition resides in /dev/hda4
>>
>>So I think  I need to do something like this?
>># Boot up Linux by default.
>>#
>>default=Linux
>>
>>image=/vmlinuz
>>       label=Linux
>>       read-only
>>append="hda=autotune resume=/dev/hda4"   <---- added this
>>#       restricted
>>#       alias=1
>>
>>Is this correct, or do i pass the resume option at boot time as a LILO 
>>option?
>>    
>>
>
>It is correct.
>								Pavel
>
>  
>
As a test I suspened the machine twice; each time the machine was off 
for approximately 5 minutes. It resumed twice without any problems (into 
X with a mozilla and xmms)
As another test, I opned up a few apps in different workspaces: abiword 
with a document, mozilla browser and mail, xmms playing an internet 
stream. I then suspended in hopes of resuming the next day after school. 
After about 14hrs I tried to resume, and everything seemed fine, excpet 
my USB mouse was unrespnsive. I was able to brinx X down into a working 
console, startx again, but still no mouse.

In debian kernel 2.6.3 I have the NIC and USB options compiled in. 
Should these be modules that are removed before swsusp?
There's aslo mention of a swsusp script, but was unable to find one in 
../Documentation/power or via apt-cache search; I'm assuming that I need 
this script, which will remove the modules before swsusp and modprobe 
them after resume.

Thank you for your time and patience.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
