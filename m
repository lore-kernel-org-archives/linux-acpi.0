From: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Wed, 03 Mar 2004 19:42:54 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40467B8E.7060709@verizon.net>
References: <4038F499.2060302@verizon.net> <20040225182030.GG1214@elf.ucw.cz> <40410A69.3070800@verizon.net> <20040228220435.GD10530@elf.ucw.cz> <4041136B.9000904@verizon.net> <20040228230941.GA488@elf.ucw.cz> <4043ECB4.7080203@verizon.net> <20040302101904.GA303@elf.ucw.cz> <404501D8.8090506@verizon.net> <20040302223446.GG1225@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040302223446.GG1225-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
>>As a test I suspened the machine twice; each time the machine was off 
>>for approximately 5 minutes. It resumed twice without any problems (into 
>>X with a mozilla and xmms)
>>As another test, I opned up a few apps in different workspaces: abiword 
>>with a document, mozilla browser and mail, xmms playing an internet 
>>stream. I then suspended in hopes of resuming the next day after school. 
>>After about 14hrs I tried to resume, and everything seemed fine, excpet 
>>my USB mouse was unrespnsive. I was able to brinx X down into a working 
>>console, startx again, but still no mouse.
>>
>>In debian kernel 2.6.3 I have the NIC and USB options compiled in. 
>>Should these be modules that are removed before swsusp?
>>There's aslo mention of a swsusp script, but was unable to find one in 
>>../Documentation/power or via apt-cache search; I'm assuming that I need 
>>this script, which will remove the modules before swsusp and modprobe 
>>them after resume.
>>    
>>
>
>You should not need any script; but it probably has better chance
>working with USB modules removed. Anyway that's a bug in USB support,
>ask on USB list.
>
>								Pavel
>  
>
OK, heres what works so far on plain vanilla 2.6.3 with 2.6.3 acpi patch 
applied; smp ans preemption disabled, eth0 e1000 and usb as modules.

S1 goes into standyby, after issuing /etc/init.d/acpi stop, but the fans 
stay on (as they also do in Win2k when standby is set to S1 in bios); 
seems to reliably resume, but it's too niosy for a computer that is 
essentialy in the bedroom.

S4 works , but I have to unload the USB modules buy hand ( I also unload 
eth0 e1000 to be safe) and modprobe them after resume. Resume takes a 
little longer than a normal boot up, but it saves me time insofar as 
opening the applications I comonly use.

Still no S3, which is what I'm really gunning for; either echo -n mem > 
/sys/power/state or echo 3 > /proc/acpi/sleep now results in the machine 
locking up after a series of messages,
something to the effect of: resuming from /dev/hda4
                                           Resuming from device hda4
                                           Resume Machine: This is 
normal swap
                                           ACPI: (supports S0 S1 S3 S4 S5)
                                           Stopping tasks: 
==========================|
                                           hdd: start_power_step (step.o)
 and a few more lines concerning hdd and hdc, I had to copy all this 
down on pen and paper.

A couple of things I noticed, with the Debian 2.6.3 kernel trying to S3 
resulted in a shutdown, now with ACPI patch and vanilla 2.6.3, it hangs 
and results in said messages. S4 takes takes more than couple of minutes 
longer to compete with the vanillas kernel, I thought the machine locked 
up, but decided to wait a few more minutes, and it seemed to finish the 
swsusp.
I did see a few messages relating to "Badness" but didn't get a chance 
to write them down.

So if there's anything you guys -- who have been more than helpful btw 
-- would like me to try as far as getting S3 functional, I'm all ears. 
I'm also assuming I need some kind of script for S4 to unload the USB 
and NIC modules, stop acpid, then revers all that upon resume. Is this 
something I'm going to have to write myself?

Thanks in advance.

Nick


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
