From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Spreading FUD [was: The fatal  logic error in EC write transaction(EC
 transaction is done in interrupt context)]
Date: Sun, 09 Nov 2008 18:27:18 +0300
Message-ID: <49170156.8000504@gmail.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>	 <29086e19e9149aadd17ece7112d7d2cf3a8b82f3.1226032677.git.len.brown@intel.com>	 <1226038422.3989.244.camel@yakui_zhao.sh.intel.com>	 <alpine.LFD.2.00.0811071445140.8189@localhost.localdomain>	 <9F0C1DB20AFA954FA1DA05309350433D40C7CC84@pdsmsx503.ccr.corp.intel.com>	 <4915B165.8020207@suse.de>	 <9F0C1DB20AFA954FA1DA05309350433D40C7CC97@pdsmsx503.ccr.corp.intel.com>	 <4915C296.9030903@suse.de> <1226236287.3989.300.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:36791 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912AbYKIP1W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Nov 2008 10:27:22 -0500
Received: by ug-out-1314.google.com with SMTP id 39so199588ugf.37
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2008 07:27:20 -0800 (PST)
In-Reply-To: <1226236287.3989.300.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

Yakui,

Please take a look at the subject of the thread -- notice words "fatal"
and "(EC transaction is done in interrupt context)".
Looks horrible, isn't it? Now we begin to get into details, and it appears
that it is not fatal, introduced 3.5 years ago, and has nothing to do with
interrupt context transaction patch.
So, the whole point of your message is to spread FUD about "fast 
transaction" patch,
and show how great you are. I would guess that you've failed in 
achieving both goals.

If you cry "wolf!" too often, you'll get ignored, when the real wolf 
appears.

Now, for a positive example, the same message without exclamation marks...
---------------------------------------------------------------------------------------------------------------------------------
Subject: difference in EC transaction protocol
Hi Alex,
I've noticed difference in EC transaction protocol for write and 
burst-disable commands,
namely all that end with writing byte to EC -- they don't wait for last 
confirmation interrupt and
next transaction might start before current one completes.
May be this is the "root cause" we are looking for.
Regards,
Yakui
---------------------------------------------------------------------------------------------------------------------------------
Note that this message is shorter, and is not offensive.
Smile, and people may start to like you...

Regards,
Alex.

P.S. And I don't agree with your analysis as you still believe that 
before the fast transaction mutex was
not released at the same time as it is now.

Zhao Yakui wrote:
> On Sun, 2008-11-09 at 00:47 +0800, Alexey Starikovskiy wrote:
>   
>> Yakui,
>> This is not about my patch, this is about your ego...
>>     
> Thanks for the reply. I know that this is not introduced by your patch.
> In the previous kernel the EC transaction is explicitly divided into
> several phases. Only when EC transaction is really finished, the EC
> mutex lock is released.  In such case the previous EC transaction is
> already  finished when OS begins another EC transaction. So the issue
> about "1 microsecond" won't appear.
No. No matter how many phases, transaction is done and EC mutex is released
as soon as last write happens. EC driver never waited for confirmation 
for last written byte.
>  But in your patch(EC transaction is
> done in interrupt context) when EC mutex is released , maybe the
> previous EC transaction is not really finished. In such case the  issue
> of "1 microsecond"  will appear.
> Is what I said right?
No. my patch has same "optimization" as appeared in EC driver since 
introduction of interrupt mode.
May be it is more visible now, and you managed to notice it, while still 
failing to see it in earlier EC driver versions?
I agree that there are some benefits in not doing this optimization, 
thus I made the patch to drop it.
>  
>   
>> My patch did not introduce this behaviour, it was there since "burst mode" was introduced, and may be even earlier. You may ask Luming Yu, why he was so optimistic about 1 microsecond (is he still around? you did not include him into CC yet...).
>>     
Actually, I gave too much credit to Shanghai office... Interrupt mode patch was written by Dmitry Torokhov, not Luming Yu.

> In my email what I said is only to point out the logic error. Maybe
>   
No, see above.
> there is no problem that the EC mutex is released before EC transaction
> is really finished. IMO this is still a logic error. The program  logic
> states that EC transaction is already finished but the EC transaction is
> not really finished. They are inconsistent..
>    The more important is that the failure in EC transaction can't be
> detected in time.
>   
>    Do you agree with my analysis?
>   
>   
No, see above.

