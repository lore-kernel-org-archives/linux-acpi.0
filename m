From: Brannon Klopfer <bklopfer@stanford.edu>
Subject: Re: hp dv8000t dead on resume from RAM
Date: Wed, 09 Aug 2006 11:01:58 -0700
Message-ID: <44DA2316.1060006@stanford.edu>
References: <1155057311.44d8c69f3f2fc@webmail.stanford.edu> <200608082230.54788.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:46220 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S1751291AbWHISCj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Aug 2006 14:02:39 -0400
In-Reply-To: <200608082230.54788.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, acpi@linux.intel.com, pavel@suse.cz

Rafael J. Wysocki wrote:
> On Tuesday 08 August 2006 19:15, Brannon Barrett Klopfer wrote:
>   
>> Howdy,
>>
>> My hp dv8000t (core duo) is completely dead on resume from RAM (no caps
>> lock, sysrq, netconsole,
>> nothing). I've tried a recent (2.6.18-rc4) kernel running almost entirely
>> naked, so to speak (~990K) -- no support for:
>>
>> SMP
>> preempt
>> modules
>> networking (+ enet drivers, unless running netconsole)
>> USB and SATA (not at same time; rootfs is either usb drive or SATA [ext2/3])
>> FireWire
>> cpufreq
>> framebuffer (vga=0)
>> audio
>> PCMCIA
>> IDE (for cdrom)
>>
>> I've tried both native SATA (ahci) and legacy (ata_piix), but same result
>> w/both -- completely dead on resume from RAM. Blindly entering commands
>> does nothing, and running "$suspend ; $shutdown" does nothing either. I've
>> also tried with and without noapic, and a number of other kernel
>> paramaters, but nothing seems to work.
>>
>> Be more than happy to try out patches, etc. to get this thing working.
>> Additionally, if someone could point me to that "beep on resume" patch,
>> that'd be great.
>>     
>
> First, please apply the appended patch and try the following:
>
> (1)
> # echo testproc > /sys/power/disk
> # echo disk > /sys/power/state
>
> This should turn off the non-boot CPU, freeze all processes, wait for 5
> seconds and then thaw the processes and the CPU.
>   
Works fine. FWIW, after applying the patchs (so as to have 
2.6.18-rc3-mm2), my internal keyboard didn't work, so I used a USB one. 
It could be my simple .config'ing error, didn't spend much time with it, 
but know that I did use a USB keyboard, hence USB support in the kernel.
> (2)
> # echo test > /sys/power/disk
> # echo disk > /sys/power/state
>
> This should turn off the non-boot CPU, freeze all processes, shrink
> memory, suspend all devices, wait for 5 seconds, resume the devices etc.
> IOW it does everything that's needed for a suspend except for actually
> suspending.
>   
With *legacy* ata_piix, it works fine, as does a "real" suspend-to-disk. 
It still *will not* resume properly from suspend-to-RAM, with and 
without noapic. FWIW, somehow the built-in keyboard managed to get its 
caps lock light on (I couldn't get it off again), and it *did* come back 
on when the machine resumed from RAM, though nothing else (network, usb, 
etc.) worked.

Using native ahci and the "test" suspend-to-disk, the system hangs. I 
did this from init=/bin/bash with vga=794 (so I could see all output), 
however, at least the last few lines match w/vga=0 (i.e., fb didn't 
affect problem). The hand-copied (pardon any typos) output is:
---
Disabling non-boot CPUs ...
CPU 1 is now offline
SMP alternatives: switching to UP code
CPU1 is down
Stopping tasks: =======|
Shrinking memory... done (0 pages freed)
Suspending device usbdev4.5
Suspending device usbdev4p5_ep82
Suspending device 4-2.1:1.1
Suspending device usbdev4.5_ep81
Suspending device 4-2.1:1.0
Suspending device usbdev4.5_ep00
Suspending device 4-2.1
Suspending device usbdev4.4
Suspending device usbdev4.4_ep81
Suspending device 4-2:1.0
Suspending device usbdev4.4_ep00
Suspending device 4-2
Suspending device vcsa1
Suspending device vcs1
Suspending device eisa.0
Suspending device i2c-0
Suspending device i2c-0
Suspending device psaux
Suspending device serio4
Suspending device serio3
Suspending device serio2
Suspending device serio1
Suspending device serio0
Suspending device i8042
# Short pause here...
atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying 
access hardware directly.
Suspending device usbdev5.1
Suspending device usbdev5.1_ep81
Suspending device 5-0:1.0
Suspending device usbdev5.1_ep00
Suspending device usb5
Suspending device usbdev4.1
Suspending device usbdev4.1_ep81
Suspending device 4-0:1.0
Suspending device usbdev4.1_ep00
Suspending device usb4
Suspending device usbdev3.1
Suspending device usbdev3.1_ep81
Suspending device 3-0:1.0
Suspending device usbdev3.1_ep00
Suspending device usb3
Suspending device usbdev2.1
Suspending device usbdev2.1_ep81
Suspending device 2-0:1.0
Suspending device usbdev2.1_ep00
Suspending device usb2
Suspending device usbdev1.1
Suspending device usbdev1.1_ep81
Suspending device 1-0:1.0
Suspending device usbdev1.1_ep00
Suspending device usb1
Suspending device 0:0:0:0
Suspending device target0:0:0
Suspending device host3
Suspending device host2
Suspending device host1
Suspending device host0
Suspending device 0.0
# Hangs here. Screen blanks in maybe 5-10min, won't turn back on; I 
assume this is the hardware doing something. Again, this is only with ahci.
---

I'll try to get that beep patch, to further diagnose things...

Thanks,
Brannon
> Greetings,
> Rafael
>
> ---
>  include/linux/pm.h  |    4 +++-
>  kernel/power/disk.c |   37 ++++++++++++++++++++++++++++---------
>  2 files changed, 31 insertions(+), 10 deletions(-)
<snip...patch applied cleanly>

