From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: linux-next Regression: Unable to locate IOAPIC
Date: Sat, 14 Jun 2008 11:07:39 +0400
Message-ID: <48536E3B.4000703@gmail.com>
References: <200806051100.12885.dex@dragonslave.de> <200806102229.10512.dex@dragonslave.de> <4851AA24.7060906@gmail.com> <200806131307.39807.dex@dragonslave.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200806131307.39807.dex@dragonslave.de>
Sender: linux-next-owner@vger.kernel.org
To: webmaster@dragonslave.de
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi Ingo, Yinghai,

It looks like the code introduced by 
2944e16b25e7fb8b5ee0dd9dc7197a0f9e523cfd
is causing this problem. At least it is new between -rc5 (working) and 
linux-next (not working).

Regards,
Alex.


Daniel Exner wrote:
> Hi all,
>
> Alexey Starikovskiy wrote:
>   
>> Hi Daniel,
>>
>> Could you please provide full dmesg and acpidump outputs?
>>     
> I attached dmesg and config , both from working 2.6.26-rc5 with git-acpi patch 
> below and from linux-next snapshot 20080604.
> I also attached acpidump that was done while using stock 2.6.25-fw5 from my 
> distro. (But I think that doesnt matter, at least it shouldn't ;)
>
>   
>> Daniel Exner wrote:
>>     
>>> Andrew Morton wrote:
>>>       
>>>> On Fri, 6 Jun 2008 19:30:28 +0200 Daniel Exner <dex@dragonslave.de> 
>>>>         
> wrote:
>   
>>>>> Andrew Morton wrote:
>>>>>           
>>>>>> (cc linux-acpi)
>>>>>>
>>>>>> On Thu, 5 Jun 2008 11:00:12 +0200 Daniel Exner <dex@dragonslave.de>
>>>>>>             
>>> wrote:
>>>       
>>>>>>> Hi!
>>>>>>>
>>>>>>> (Added myself to CC, because I'm not subscribed)
>>>>>>>
>>>>>>> with linux-next snapshot 20080604 my Laptop morphes into sitting duck
>>>>>>> and I think this is due to this:
>>>>>>>               
>>>>>> I assume 2.6.26-rc5 is OK?
>>>>>>             
>>>>> Indeed.. just tried it with (nearly) the same config: no unable to
>>>>> locate IOAPIC
>>>>>
>>>>> Will try todays next snapshot above -rc5 now.
>>>>>           
>>>> OK, thanks.
>>>>
>>>> It would be great if you could test 2.6.26-rc5 plus
>>>> http://userweb.kernel.org/~akpm/git-acpi.patch.  That'll allow us to
>>>> confirm that the regression is due to changes in the acpi tree.
>>>>         
>>> Sorry for the delay.. real-life you know ;)
>>>
>>> I guess you'd expect me to confirm the behavior on rc5 with this patch
>>> aplied, but .. well this Kernel works!
>>>       
> To clarify myself:
> 2.6.25.5:  --> relatively fast no IOAPIC Errors in dmesg
> 2.6.26-rc5:   --> relatively  no IOAPIC Errors in dmesg
> 2.6.26-rc5 + git-acpi Patch:   --> relatively  no IOAPIC Errors in dmesg
> 2.6.26-rc5 +  linux-next snapshot 20080604 --> even slower than before my ide 
> Patch many "unable to locate IOAPIC" Errors
>
>
> So I think the problem lies not in the acpi tree but somewhre else.
>
> Is it possible to tell git to explicitly _exclude_ a specific tree while 
> bisecting?
>
> --
> Greetings
> Daniel Exner
>   

