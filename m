From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: controlling ACPI IRQ routing
Date: Sat, 29 Dec 2007 10:40:20 -0800
Message-ID: <47769494.3080503@howardsilvan.com>
References: <47742083.5060903@howardsilvan.com> <477489B8.20700@howardsilvan.com> <1198821979.20548.9.camel@sli10-desk.sh.intel.com> <200712290339.48354.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from frodo.howardsilvan.com ([66.119.206.113]:60577 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbXL2SkX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Dec 2007 13:40:23 -0500
In-Reply-To: <200712290339.48354.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Len Brown wrote:
> 1000 interrupts/second isn't a lot on modern hardware.
> Indeed, many linux distros run with 1000 clock ticks/second today.
>
> I don't understand why interrupt priority has anything to do
> with what you are seeing.  To notice such a thing, you'd have
> to have a lot of competing interrupts firing at the same time
> and the messages queued up inside the LAPIC and the processor
> spending a large % of its time in interrupt context.
> (does top(1) say that you're running a large %sys?)
>   

No, top says nothing unusual to me...

top - 13:36:50 up 12 days,  4:00,  1 user,  load average: 0.01, 0.05, 0.05
Tasks: 189 total,   1 running, 185 sleeping,   0 stopped,   3 zombie
Cpu(s):  0.7% us,  1.3% sy,  0.0% ni, 97.7% id,  0.0% wa,  0.0% hi,  
0.3% si,  0.0% st
Mem:   2054796k total,  2018560k used,    36236k free,   239084k buffers
Swap:  2007992k total,      520k used,  2007472k free,  1266672k cached

> What is the total interrupt rate on the system when this
> device is doing 1000/second?
>   

I don't understand the question, really... and I'm not sure how to 
determine the answer, either.  Here's what /proc/interrupts says:

# cat /proc/interrupts
           CPU0      
  0: 1051464247   IO-APIC-edge      timer
  1:          8   IO-APIC-edge      i8042
  8:          0   IO-APIC-edge      rtc
  9:          0   IO-APIC-fasteoi   acpi
 12:        104   IO-APIC-edge      i8042
 14:    9414304   IO-APIC-edge      ide0
 16: 1051172722   IO-APIC-fasteoi   wct4xxp
 19:          1   IO-APIC-fasteoi   eth1
 21:  158008518   IO-APIC-fasteoi   eth0
 22:    6974044   IO-APIC-fasteoi   libata
 23:    7071112   IO-APIC-fasteoi   libata
NMI:          0
LOC: 1051371544
ERR:          0


> Are there multiple cores on the system?

No, otherwise it appears that I could use IRQ affinity to dedicate a 
processor to handling the wct4xxp (zaptel) interrupt.

> If so,
> are the interrupts bound to certain cores or is
> irqbalance running?

irqbalance is available and running, but I don't think that it does 
anything on a single-core system.

Thanks,

Lee.
