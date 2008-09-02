From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Tue, 02 Sep 2008 10:19:10 +0100
Message-ID: <48BD050E.1060804@tuffmail.co.uk>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>	 <48BC57C9.2040409@suse.de>	 <1220317387.4039.83.camel@yakui_zhao.sh.intel.com>	 <20080902020302.GA12080@khazad-dum.debian.net> <1220326776.4039.153.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:60041 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbYIBJTQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2008 05:19:16 -0400
Received: by an-out-0708.google.com with SMTP id d40so369577and.103
        for <linux-acpi@vger.kernel.org>; Tue, 02 Sep 2008 02:19:15 -0700 (PDT)
In-Reply-To: <1220326776.4039.153.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
> On Mon, 2008-09-01 at 23:03 -0300, Henrique de Moraes Holschuh wrote:
>   
>> On Tue, 02 Sep 2008, Zhao Yakui wrote:
>>     
>>> On Tue, 2008-09-02 at 00:59 +0400, Alexey Starikovskiy wrote:
>>>       
>>>> Alexey Starikovskiy wrote:
>>>>         
>>> In this patch when timeout happens, EC will try the GPE interrupt mode
>>> after 5 seconds.Of course EC will be in polling mode before switching to
>>> GPE interrupt mode. It seems reasonable. 
>>>       
>> Yeah, the patch looks good.
>>
>> But we probably want to limit the number of times it will try to re-enable
>> interrupt mode, otherwise it will keep firing on ECs that are permanently
>> broken re. GPE interrupt mode.  I think trying 5 times should be enough,
>> that gives a 25s window for the EC to get its act together.
>>
>> And we should probably reset the "attempted tries to switch to GPE interrupt
>> mode" counter (so that the code will retry interrupt mode again) after
>> events that are likely to have done a lot of internal churning to the EC.
>> Currently, those would be when resuming from S3 or S4, I think.
>>
>>     
>>> In fact there also exists the mode switch from polling mode to interrupt
>>> mode after EC is initialized. Is it more appropriate that ec->gpe_retry
>>> is initialized?
>>>       
>> We could use the same code to do the initial switch, indeed.
>>
>> The two other things that we probably want to make sure we are doing are:
>>
>> 1. Drain the entire EC queue at every poll cycle (this is a must, really).
>>     
> It is difficult to drain the entire EC queue.

Why?  What was wrong with my proposed patch to do this :-P?

At least in GPE polling mode, we ought to query in a loop until the
query returns 0 (no event).

There was a problem which might have been caused by my patch, but that
was probably an excessive GPE problem.  That can't happen if we've
disabled the GPE altogether so we have to poll them.  I think Alex is
right that this is a must.

Though I am making an assumption here.  The other possibility is a buggy
EC that returns non-zero when there are no more events.  I hope not
though :-(.

>  In fact OS can't know the
> length of EC entire queue. In fact there is no concept about the EC
> queue.
>   

There is certainly the implication that more than one event could be
pending.  And there is the concept "queue is empty now", indicated by
query returning zero.

>   
>> 2. Try to drain the entire EC queue also in interrupt mode, but be careful
>> about dumb ECs that will sign 10 interrupts if there are 10 bytes to read in
>> the queue, even when we have drained the queue when servicing the very first
>> interrupt.   I bet there are ECs which will give you just one interrupt and
>> expect the queue to be drained, ECs which will give you interrupts until you
>> drain the queue (but no more than necessary), and ECs which will give you
>> interrupts for as many bytes as it stored in the queue, regardless of when
>> they were read... and we mustn't think there is an interrupt storm happening
>> because of this.
>>     
> Maybe what you said is right. There are too many kinds of EC controllers
> available. And they come from the different OEMs. Maybe when one EC
> internal event is detected, the EC GPE interrupts will always be
> triggered before the notification event is processed on some ECs. But
> who knows.
>   

