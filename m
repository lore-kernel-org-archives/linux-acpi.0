From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Mon, 20 Nov 2006 22:31:57 +0300
Message-ID: <456202AD.9040204@linux.intel.com>
References: <B41635854730A14CA71C92B36EC22AAC5AD485@mssmsx411> <Pine.LNX.4.64.0611181104030.3692@woody.osdl.org> <455FB44C.8050103@linux.intel.com> <Pine.LNX.4.64.0611182048560.3692@woody.osdl.org> <456043F7.1030105@linux.intel.com> <Pine.LNX.4.64.0611201003540.3692@woody.osdl.org> <Pine.LNX.4.64.0611201020320.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:28802 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S966521AbWKTTdz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Nov 2006 14:33:55 -0500
In-Reply-To: <Pine.LNX.4.64.0611201020320.3692@woody.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org


Linus Torvalds wrote:
> [ Digression from testing Alexey's patch that makes the Evo work again 
>   with two separate threads ]
>
> On Mon, 20 Nov 2006, Linus Torvalds wrote:
>   
>> Ok, this one works for me too, and looks much simpler.
>>     
>
> Hmm. Some more testing shows that fan behaviour after a suspend-to-ram 
> event seems broken, but I suspect the breakage isn't new.
>
> It seems that ACPI remembers fan state from before the suspend, and then 
> (incorrectly) uses that to decide whether it should turn fans on or off. 
> So for example, it seems to remember that the fan was already on, so it 
> won't ever turn it on again - even though the suspend will obviously have 
> turned off all fans too.
>
>   
We have patches in #7122 for similar issue in suspend-to-disk, it may 
fix suspend-to-ram too?
It's related to order of ACPI devices resume and _WAK method execution.

Thanks,
    Alex.
