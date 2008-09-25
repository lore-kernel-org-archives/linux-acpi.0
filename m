From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [RFC] [Patch 0/4]  ACPI : several patches for EC
Date: Thu, 25 Sep 2008 15:22:11 +0400
Message-ID: <48DB7463.3030600@gmail.com>
References: <1222314812.4023.31.camel@yakui_zhao.sh.intel.com>	 <48DB20DB.4080802@gmail.com>	 <1222324860.4023.62.camel@yakui_zhao.sh.intel.com>	 <48DB4C75.5090403@gmail.com> <1222337155.4023.112.camel@yakui_zhao.sh.intel.com> <48DB705C.2020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:57594 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbYIYLWO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 07:22:14 -0400
Received: by fk-out-0910.google.com with SMTP id 18so370928fkq.5
        for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 04:22:11 -0700 (PDT)
In-Reply-To: <48DB705C.2020609@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
>> But I think that the spin_lock is overkill in the updated patch.
>> Assuming that 1000 EC transactions are done per second, the CPU
>> interrupt is disabled for 1ms. It is important that the normal laptops
>> will be affected by this.
>>   
> How do you arrive with these numbers? Where do you get this 1ms?
> Spinlock is around single inb/outb instruction plus several even simpler
> instructions. Do you claim it is going to take 1us? Do you claim that 
> it will
> add anything to interrupts-disabled time of ACPI SCI interrupt handler
> itself?
>>       At the same time the following source code looks so ugly.
>>   
> It is a matter of taste and, probably, experience.
>
>
>
>> Please look at the following source to see whether the bogus timeout
>> happens.
>>    >spin_unlock_irqrestore(&ec->spinlock, tmp);
>>    >    /* if we selected poll mode or failed in GPE-mode do a poll 
>> loop */     >    if (force_poll ||
>>    >        !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
>>    >        acpi_ec_wait(ec))
>>    >        ret = ec_poll(ec);
>>        
>>     When EC GPE storm happens, EC driver will work in polling mode. 
>> And it will
>> call the function of ec_poll after issuing the EC command.
>>    static int ec_poll(struct acpi_ec *ec)
>> {
>>     unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
>>         //If preempt schedule happens here, the timeout happens after 
>> it is rescheduled.
>>         // In such case how to issue the following EC command sequence?
>>       while (time_before(jiffies, delay)) {
>>         gpe_transaction(ec, acpi_ec_read_status(ec));
>>         /* do a shortest sleep */
>>         msleep(1);
>>         if (ec_transaction_done(ec))
>>              return 0;
>>             //If the preempt schedule happens here, maybe the timeout 
>> happens when it is rescheduled.                 // And the EC 
>> transaction is not finished. How to explain it?
>>      }
>> -    pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = 
>> %s\n",
>> -        acpi_ec_read_status(ec),
>> -        (event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
>>      return -ETIME;
>>  }
>>        I don't care whether the above bogus timeout often happens.  
>> What I cared is
>> how to explain it or process it.        Regarded it as Timeout or 
>> ignore it? Unreasonable.      
>>   
> You seem to agree, that with working scheduler it is not possible that 
> this code will not be
> executed for half a second, right? Then, with broken scheduler (the 
> one with 120s sleeps),
> you arrive at this code 120 seconds late and still want to continue 
> transaction?
> 500msec here is _cut off_ after which we don't care about this 
> transaction. In normal
> conditions transaction should not _ever_ come close to 1/10th of this 
> value.
>>>>    b. How to deal with the laptop with "incorrect EC status before EC
>>>> GPE arrives". For example: bug 11309 (GPE storm happens and OS will
>>>> report the incorrect temperature while EC GPE is disabled.)
>>>>       
>>> This is _your guess_. None of your patches was reported to fix a 
>>> situation,
>>> and submitter is not able to compile kernel.
>>>     
>> The bug reporter doesn't give response. But please pay attention to this
>> is a regression.
>>     The detect of EC GPE storm is not shipped in 2.6.24.x kernel.
>>     The detect of EC GPE storm is shipped in 2.6.26.x kernel.
>>     On the 2.6.24.x kernel there is no detection of EC GPE storm and EC
>> GPE is enabled. In such case the temperature is reported correctly.   
>>     And after EC GPE storm happens , sometimes it will report the
>> incorrect thermal zone temperature, which causes that the system will be
>> shutdown. (In such case EC GPE is disabled and EC will work in polling
>> mode).
>>     How to explain it? The possible cause is that EC status is incorrect
>> before EC GPE arrives.
>>
>>   
> It is easy to add same msleep(1) before the while() loop to overcome
> this, right? So, as soon as the submitter will be able to test patches,
> and if he finds his hardware still not working correctly, we could
> easily fix it with 1-liner patch.
>> The laptop of bug 8110 is fixed by the following commit.
>>     >commit 9e197219605513c14d3eae41039ecf1b82d1920d
>>      > Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
>>      > Date:   Wed Mar 7 18:29:35 2007 -0500
>>         >ACPI: ec: fix race in status register access
>>       If the EC GPE storm happens on this laptop, I believe that this
>> laptop will be broken by your proposed patch again.
>>  
Actually, this patch suggests, that there is _no_ storm. If storm was were,
simply waiting for an interrupt (which come in tens) does not help.
> Do you want me to insert the above msleep(1) now, or do you want
> me to drop my patch and instead go with yours?
>

