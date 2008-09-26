From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [RFC] [Patch 0/4]  ACPI : several patches for EC
Date: Fri, 26 Sep 2008 10:27:25 +0400
Message-ID: <48DC80CD.3000008@gmail.com>
References: <1222314812.4023.31.camel@yakui_zhao.sh.intel.com>	 <48DB20DB.4080802@gmail.com>	 <1222324860.4023.62.camel@yakui_zhao.sh.intel.com>	 <48DB4C75.5090403@gmail.com>	 <1222337155.4023.112.camel@yakui_zhao.sh.intel.com>	 <48DB705C.2020609@gmail.com> <1222393629.4023.157.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:7657 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbYIZG1Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 02:27:24 -0400
Received: by mu-out-0910.google.com with SMTP id g7so648981muf.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 23:27:21 -0700 (PDT)
In-Reply-To: <1222393629.4023.157.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
> On Thu, 2008-09-25 at 15:05 +0400, Alexey Starikovskiy wrote:
>   
>> Zhao Yakui wrote:
>>     
>>> But I think that the spin_lock is overkill in the updated patch.
>>> Assuming that 1000 EC transactions are done per second, the CPU
>>> interrupt is disabled for 1ms. It is important that the normal laptops
>>> will be affected by this.
>>>   
>>>       
>> How do you arrive with these numbers? Where do you get this 1ms?
>> Spinlock is around single inb/outb instruction plus several even simpler
>> instructions. Do you claim it is going to take 1us? Do you claim that it 
>> will
>>     
> It is noted that inb/outb instruction is not memory read/write
> operation. It will take some time to read/write the external peripheral
> device.
> For example: 
> On intel platform : The EC is connected with ICH device through LPC bus.
> For every LCP I/O read/write operation, it will take almost 0.7us.
>
> When OS reads the SBS battery info, there will a lot of SCI interrupts,
> most of which are related with EC transaction. 
>   
You seem to forget, that SBS driver is also written by me... Don't
explain to me how it works. Thanks.
>> add anything to interrupts-disabled time of ACPI SCI interrupt handler
>> itself?
>>     
> Not included.
>
> Why not explain the following ? The local function variable resides on
> the process stack space. If the process that is doing EC transaction is
> killed before it is finished, what will happen? Maybe the system will be
> kernel panic.
Ever tried to kill process, which entered syscall (e.g. in kernel)?
Please read some books first.
> I only want to know why you raise the following commit?
>     >commit 9e197219605513c14d3eae41039ecf1b82d1920d
>     >Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
>     > Date:   Wed Mar 7 18:29:35 2007 -0500
>       >ACPI: ec: fix race in status register access
>    
>    If your understanding is correct, why push it?
>    Why give two different explanations about the same issue?
> At the same time please confirm whether the laptop of bug 8110 is broken
> again by your patch if the GPE storm happens ?
>   
I just explained everything in the above mail. If you don't understand --
this is not my problem, but _yours_. I am not going to explain same things
to you several times.

My patch does not break machine in bug report 8110.

