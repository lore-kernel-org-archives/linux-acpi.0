From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 10:03:44 +0100
Message-ID: <48DCA570.2070707@tuffmail.co.uk>
References: <20080925170030.15311.27823.stgit@thinkpad>	 <48DBCFE0.8050905@yahoo.com> <1222391199.4023.125.camel@yakui_zhao.sh.intel.com> <48DC763B.7080203@yahoo.com> <48DC7AA0.8030204@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:9908 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbYIZJDt (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 05:03:49 -0400
Received: by nf-out-0910.google.com with SMTP id d3so320483nfc.21
        for <Linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 02:03:47 -0700 (PDT)
In-Reply-To: <48DC7AA0.8030204@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Sitsofe Wheeler <sitsofe@yahoo.com>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> Sitsofe Wheeler wrote:
>> Zhao Yakui wrote:
>>>     I think that the problem on the asus-EEEPC can't be resolved really
>>> by the Alexey's patch. IMO it is only lucky.
>>
>> How lucky? It really does go from excruciatingly slow to quite fast
>> on that laptop. What will happen should my luck fail? What are the
>> odds of my luck failing?
>>
>>>    In fact the main problem on Asus-EEEPC is related with the broken
>>> EC.
>>> Before an EC notification event is processed, another EC notification
>>> event arrives again.
>>>    If EC driver check whether the SCI_EVT bit is set after processing
>>> one EC notification event, the problem will be resolved.    
>>> http://bugzilla.kernel.org/show_bug.cgi?id=11089
>>>     Alan Jenkins already sent a patch about how to fix the issue on the
>>> Asus-EEEPC.

I submitted alternative patches in the past, but they were not up to
scratch.  The first patch stopped the EeePC dropping events, but left
them arriving in bursts every 0.5 seconds - which is still a UI
regression; it looks even more weird when you hold down a brightness
key.  My other patches fixed the EeePC, but caused severe regressions on
other hardware.

So I have stopped pushing any patches of my own.  In the interest of
removing this regression as soon as reasonably possible, I will not
object to changes that actually work.

>> I'll cc Alan and see what he makes of this patch.
>>

> Alan already tested my patch and it works for him.

Yup.  I agree with Zhao, in that it is not crystal clear why this new
patch helps.

The new patch includes a fallback which requires polling-driven
transactions.  That's a different type of polling fallback to the
previous one.  However, from the experience of testing a range of
patches, I believe the new polling fallback would also drop events.  At
face value, the trigger for the polling fallback is the same - 20
"false" (surplus to requirements) interrupts, so it shouldn't work :-).

I can think of two possibilities

1. Doing more in the interrupt handler leaves the interrupt disabled for
longer, hiding some of the false interrupts (which arrive in bursts).

2. Maybe when the device is serviced (e.g. a data byte is read), it
stops the current burst of false interrupts.

>>>    But if the above patch is merged , maybe it will break some laptops.
>>
>> Fair enough but can those people with such laptops test the patch too
>> and report back? Can you say in what form the breakages will take?
>> From what you are saying it sounds like this patch shouldn't have had
>> any affect for me but it does. What happens when they try it? What
>> happens when you try it?
>>
>

Alan
