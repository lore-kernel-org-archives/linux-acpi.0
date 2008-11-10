From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Spreading FUD [was: The fatal  logic error in EC write transaction(EC
 transaction is done in interrupt context)]
Date: Mon, 10 Nov 2008 21:48:50 +0300
Message-ID: <49188212.2020401@gmail.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>	 <29086e19e9149aadd17ece7112d7d2cf3a8b82f3.1226032677.git.len.brown@intel.com>	 <1226038422.3989.244.camel@yakui_zhao.sh.intel.com>	 <alpine.LFD.2.00.0811071445140.8189@localhost.localdomain>	 <9F0C1DB20AFA954FA1DA05309350433D40C7CC84@pdsmsx503.ccr.corp.intel.com>	 <4915B165.8020207@suse.de>	 <9F0C1DB20AFA954FA1DA05309350433D40C7CC97@pdsmsx503.ccr.corp.intel.com>	 <4915C296.9030903@suse.de>	 <1226236287.3989.300.camel@yakui_zhao.sh.intel.com>	 <49170156.8000504@gmail.com> <1226278911.3989.313.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:30731 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbYKJSsy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 13:48:54 -0500
Received: by ug-out-1314.google.com with SMTP id 39so483034ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2008 10:48:52 -0800 (PST)
In-Reply-To: <1226278911.3989.313.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

Zhao Yakui wrote:
> On Sun, 2008-11-09 at 23:27 +0800, Alexey Starikovskiy wrote:
>   
>> Yakui,
>>
>> Please take a look at the subject of the thread -- notice words "fatal"
>> and "(EC transaction is done in interrupt context)".
>> Looks horrible, isn't it? Now we begin to get into details, and it appears
>> that it is not fatal, introduced 3.5 years ago, and has nothing to do with
>> interrupt context transaction patch.
>> So, the whole point of your message is to spread FUD about "fast 
>> transaction" patch,
>> and show how great you are. I would guess that you've failed in 
>> achieving both goals.
>>     
> I won't argue with you about this issue. 
>   
Good.
>      In your patch the program logic states that the EC transaction is
> already finished. But in fact the EC transaction is not really finished.
> They are inconsistent. Why can't call this a fatal logic error? 
>      The more important is that the failure in EC transaction can't be
> detected in time. 
>      Why can't call this a fatal logic error?
>   
Here is Merriam-Webster' definition of "fatal", look at use case number 
4, which
is closest to your use of it:
<a href="http://www.merriam-webster.com/dictionary/fatal">fatal</a>
As we lived with the problem you decribe all these years, it can not be 
described as
"causing failure/death", thus it can not be called "fatal".

>     
> If this is not a fatal logic error, what can be called fatal? Like that
> Several commits are reverted each other as the following three commits.
>     a.7c010de7506954e973abfab5c5999c5a97f7a73e
>     b.4c611060660f0de3e9b8f02df207312bc6f5c331
>     c.f9319f903f898dd4b15dbc386499725ce6c59776
>
>   
If I had all these machines sitting on my desk side-by-side, I may have 
fixed them with one patch,
otherwise one need to make rounds. Do you know any other solution?
> If you still reply the subject so impolitely, Don't blame that I will
> forward the similar error to wider range.
>  
>   
You send false or bended statements not for the first time, do you 
expect any other treatment?
You certainly could do whatever you want, but prepare for others to 
include you in ignore/spam list.

Regards,
Alex.



