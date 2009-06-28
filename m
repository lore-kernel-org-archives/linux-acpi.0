From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH] acpi processor: simplify needlessly complex printk
Date: Sun, 28 Jun 2009 15:51:33 -0700
Message-ID: <4A47F3F5.4020405@gmail.com>
References: <200906282203.55643.elendil@planet.nl> <4A47E85D.3020202@gmail.com> <200906290028.33285.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:21553 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbZF1Wu1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Jun 2009 18:50:27 -0400
In-Reply-To: <200906290028.33285.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

Frans Pop wrote:
> On Monday 29 June 2009, Justin P. Mattock wrote:
>    
>> Would it be better to capitalize the S and add a period at the
>> end, or does it not matter?
>>      
>
> Kernel messages are in general not sentences.
>
> I thought of removing the parenteses, but if you look at the context of
> the message then that only makes sense if other messages are modified at
> the same time. The messages below appear together for my system and their
> consistency could definitely be improved, but IMO that's better done in a
> separate patch.
>
> ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> processor LNXCPU:00: registered as cooling_device7
> ACPI: Processor [CPU0] (supports 8 throttling states)
>
>    
Cool, thanks for the info.
I found Documentation/CodingStyle
Chapter 13: Printing kernel messages
Kernel messages do not have to be terminated with a period.
(Sh^t I was going to submit some patches that made proper
some messages, and comments)
I guess I have to learn to change code, instead of messages!

Justin P. Mattock
