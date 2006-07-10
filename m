From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: acpi stopped working for me sometime after 2.6.11
Date: Mon, 10 Jul 2006 12:59:32 +0400
Message-ID: <44B216F4.50500@linux.intel.com>
References: <44B00222.2080700@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:202 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751376AbWGJI7j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jul 2006 04:59:39 -0400
In-Reply-To: <44B00222.2080700@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Philip Walden <pwaldenlinux@pacbell.net>
Cc: linux-acpi@vger.kernel.org

Please open bug in bugzilla.kernel.org and attach full dmesg to it.

Regards,
	Alex.
Philip Walden wrote:
> I just upgraded from RH9 to FC4. The the distribution CDs I used 
> provided 2.6.11-1.1369_FC4.
> 
> The upgrade was successful and I was happy to see ACPI actually power 
> off my machine when I did a shut down. Something I had missed when I 
> went from XP to RH9.
> 
> My next step was to upgrade using yum. This jumped me to 
> 2.6.17-1.2139_FC4. ACPI was now disabled in boot up.
> 
> After several days of poking araound doing before and after compares I 
> found something that works.
> 
> I added an acpi=force kernel parameter. ACPI loaded and shutdown now 
> powers off the box.
> 
> Yeah!
> 
> I spotted the work-around in another thread where it is used to get 
> around the ACPI BIOS age cutoff.
> 
> Not sure what happen after 2.6.11, though.
> 
> Does anyone care what happened? Should this be reported as a bug?
> 
> The motherboard, I am not sure what it is. The box is a HP Pavilion 
> 9695C. The closest I can get to a specification for the motherboard is: 
> http://h10025.www1.hp.com/ewfrf/wc/genericDocument?cc=us&docname=bph05885&lc=en&jumpid=reg_R1002_USEN  
> Generically described as "Motherboard and Jumper Settings for Systems 
> with AMD Athlon Processor and an AMD Irongate (AMD-751) Chipset".
> 
> Here is a dmesg excerpt showing the dissabling message.
> 
> Jul  3 09:15:43 walden4 kernel: klogd 1.4.1, log source = /proc/kmsg 
> started.
> Jul  3 09:15:43 walden4 kernel: Linux version 2.6.17-1.2139_FC4 
> (bhcompile@hs20-bc1-5.build.redhat.com) (gcc version 4.0.2 20051125 (Red 
> Hat 4.0.2-8)) #1 Fri Jun 23 20:56:41 EDT 2006
> Jul  3 09:15:43 walden4 kernel: BIOS-provided physical RAM map:
> Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 0000000000000000 - 
> 000000000009f800 (usable)
> Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 000000000009f800 - 
> 00000000000a0000 (reserved)
> Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 00000000000e9400 - 
> 0000000000100000 (reserved)
> Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 0000000000100000 - 
> 000000000fff0000 (usable)
> Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 000000000fff0000 - 
> 000000000ffffc00 (ACPI data)
> Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 000000000ffffc00 - 
> 0000000010000000 (ACPI NVS)
> Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 00000000fffc0000 - 
> 0000000100000000 (reserved)
> Jul  3 09:15:43 walden4 kernel: 0MB HIGHMEM available.
> Jul  3 09:15:43 walden4 kernel: 255MB LOWMEM available.
> Jul  3 09:15:43 walden4 kernel: Using x86 segment limits to approximate 
> NX protection
> Jul  3 09:15:43 walden4 kernel: DMI not present or invalid.
> Jul  3 09:15:43 walden4 kernel: ACPI: Disabling ACPI support
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

