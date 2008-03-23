From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.25 regression: powertop says 120K wakeups/sec
Date: Sun, 23 Mar 2008 21:04:35 +0300
Message-ID: <47E69BB3.3050508@gmail.com>
References: <20080322202454.9D69DCC0EF@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20080322173500.7b8b6751.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:53197 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbYCWSEm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Mar 2008 14:04:42 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1964356ugc.16
        for <linux-acpi@vger.kernel.org>; Sun, 23 Mar 2008 11:04:39 -0700 (PDT)
In-Reply-To: <20080322173500.7b8b6751.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

Andrew Morton wrote:
> On Sat, 22 Mar 2008 13:24:54 -0700 David Brownell <david-b@pacbell.net> wrote:
>
>   
>> I noticed this with 2.6.25-rc2 (if not before), and the problem
>> is still there with 2.6.25-rc6-git (as of this AM).
>>
>> System is an Athlon64 single CPU laptop, and instead of reading a
>> few dozen wakeups per second, it says a many tens of thousands...
>> clearly wrong.  In previous kernels it gave more plausible counts;
>> unfortunately high because of various un-evolved desktop tools in
>> this Ubuntu system (Feisty).
>>
>> Possibly more truthful, it says that the system never enters
>> C1 or C2, and spends all its time in C0.  Though if I look at
>> /sys/devices/system/cpu/cpu0/cpuidle/state[01]/usage, that
>> seems to tell a different story ... it's C0 that's never used.
>> In previous kernels it reported time in both C0 and C2.  ISTR
>> some patch to avoid C2, which would explain part of this.
>>
>> Comments or fixes, anyone?
>>     
There are patches in #9998, which fix irq storm in ACPI EC GPE.
It looks like this storm was already present at least in .22 kernel.
I was able to trace it down to HW failure to clear status bit of
corresponding GPE, so as soon as we return from serving one interrupt,
we get another. It would be great if we find why we can't clear this bit.
It does not seem to be IO access issue, as enable bit is in adjacent 8-bit
register and write to it succeeds. I've seen patch for calling _PSW for all
possible wake devices, as it might be constantly waking us even in runtime,
but it seems to not help.
>
> This is likely to be an acpi regression, isn't it?
>
> A git-bisect would be nice, please.
>   
Might be long too, if it was present in .22...
It would be nice if you can at least tell the latest good point.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

