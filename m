From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Wed, 17 Mar 2010 14:47:55 -0400
Message-ID: <4BA123DB.5050807@redhat.com>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com> <1268294876.3632.5.camel@localhost.localdomain> <4B98AA89.4060609@linux.intel.com> <201003121418.14204.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42179 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755496Ab0CQSsB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Mar 2010 14:48:01 -0400
In-Reply-To: <201003121418.14204.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: chen gong <gong.chen@linux.intel.com>, ykzhao <yakui.zhao@intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, trenn@novell.com



Thomas Renninger wrote:
> On Thursday 11 March 2010 09:32:09 chen gong wrote:
>   
>> On 2010-3-11 16:07, ykzhao wrote:
>>     
> ... 
>   
>> BTW, how about using UDEV rules to do this operation. It looks more smooth. I know some
>> Novell guy is working on it.
>>     
> I also know this guy :)
>
> These would be the udev rules to automatically add memory/cpus:
> SUBSYSTEM=="cpu", ACTION=="add", TEST=="online", ATTR{online}=="0", ATTR{online}="1", RUN+="/bin/logger onlining cpu: $env{DEVPATH}"
> SUBSYSTEM=="memory", ACTION=="add", TEST=="state", ATTR{state}=="offline", ATTR{state}="online", RUN+="/bin/logger onlining memory: $env{DEVPATH}"
>
> But this should be the same as you suggest (at least the memory rule)
> to do in the kernel:
> automatically online the memory, once hotadded.
>
> I would not add any udev rules before this does not work
> reliably and currently it is totally broken, mainly because:
>   - not being able to alloc memory on foreign nodes (at least with slab)
>   - C-state, throttling and cpufreq set up is done without valid
>     cpu_data(new_cpu) resulting in wrong C-state (and other) info
>
>   

Thomas, forgive my ignorance of udev rules ... but can one udev rule 
block another?  ... That's not the best way to explain it ... here's an 
example:

CPU hot add on Nehalem-EX.  Memory is brought online.  Memory udev 
events are generated.  CPU udev events are generated.

Can the memory udev events block the cpu udev events?  ie) can I be 
assured that memory will come online before the cpus?

P.

>    Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
