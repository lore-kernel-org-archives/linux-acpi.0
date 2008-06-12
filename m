From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: linux-next Regression: Unable to locate IOAPIC
Date: Fri, 13 Jun 2008 02:58:44 +0400
Message-ID: <4851AA24.7060906@gmail.com>
References: <200806051100.12885.dex@dragonslave.de> <200806061930.29046.dex@dragonslave.de> <20080606115024.387b5f80.akpm@linux-foundation.org> <200806102229.10512.dex@dragonslave.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:19145 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760563AbYFLW6h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 18:58:37 -0400
Received: by ug-out-1314.google.com with SMTP id h2so251ugf.16
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2008 15:58:35 -0700 (PDT)
In-Reply-To: <200806102229.10512.dex@dragonslave.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: webmaster@dragonslave.de
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Daniel,

Could you please provide full dmesg and acpidump outputs?

Thanks,
Alex.

Daniel Exner wrote:
> Andrew Morton wrote:
>   
>> On Fri, 6 Jun 2008 19:30:28 +0200 Daniel Exner <dex@dragonslave.de> wrote:
>>     
>>> Andrew Morton wrote:
>>>       
>>>> (cc linux-acpi)
>>>>
>>>> On Thu, 5 Jun 2008 11:00:12 +0200 Daniel Exner <dex@dragonslave.de> 
>>>>         
> wrote:
>   
>>>>> Hi!
>>>>>
>>>>> (Added myself to CC, because I'm not subscribed)
>>>>>
>>>>> with linux-next snapshot 20080604 my Laptop morphes into sitting duck
>>>>> and I think this is due to this:
>>>>>           
>>>> I assume 2.6.26-rc5 is OK?
>>>>         
>>> Indeed.. just tried it with (nearly) the same config: no unable to locate
>>> IOAPIC
>>>
>>> Will try todays next snapshot above -rc5 now.
>>>       
>> OK, thanks.
>>
>> It would be great if you could test 2.6.26-rc5 plus
>> http://userweb.kernel.org/~akpm/git-acpi.patch.  That'll allow us to
>> confirm that the regression is due to changes in the acpi tree.
>>     
> Sorry for the delay.. real-life you know ;)
>
> I guess you'd expect me to confirm the behavior on rc5 with this patch aplied, 
> but .. well this Kernel works!
>
> So I think the regression is NOT in the acpi tree. Perhaps pci subsystem?
> If I find time I'll try bisecting it..
>
> Greetings
> Daniel Exner
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

