From: Enno Fennema <e.fennema@tiscali.nl>
Subject: Re: RTC or button wakeup
Date: Mon, 30 Jun 2008 16:23:10 +0200
Message-ID: <4868EC4E.8020804@tiscali.nl>
References: <4867B402.2070104@tiscali.nl> <1214788019.26947.2.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:41557 "EHLO
	smtp-out0.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbYF3OWN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jun 2008 10:22:13 -0400
Received: from [212.182.149.132] (helo=[192.168.1.34])
	by smtp-out0.tiscali.nl with esmtp
	id 1KDKGh-0000jW-JJ
	for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2008 16:22:11 +0200
In-Reply-To: <1214788019.26947.2.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Zhao Yakui wrote:
> On Sun, 2008-06-29 at 18:10 +0200, Enno Fennema wrote:
>> Could anyone suggest a way to determine in a (shell) program whether my 
>> computer was switched on by RTC alarm or by me pressing the power button.
>>
>     ACPI: Disable Fixed_RTC event when installing RTC handler
> 
> In fact the commit is already merged into upstream kernel. Will you

Thanks for yor reply but ... you are streets ahead of me.

I have RTC alarm enabled in BIOS and the alarm starts my machine from 
Soft-off and boots correctly at, in my case, 23:05 every evening, and 
not at 00:00 or any other time. At 23:10 cron starts my daily jobs.

I think I am not interested in any further RTC alarms, which will not
happen for 24 hours anyway.

My problem is to decide at the end of the daily jobs whether to switch
off the machine with /sbin/halt (if RTC started my machine) or not to
switch off (if pressing the power button had started the machine).

Are you saying that testing (after installing the patch) either RTC_STS 
or RTC_ENA would give me my answer.

Before installing the patch I see no both bits look identical when 
switched on by hand or by RTC. Sorry, I am an acpi-newbie and probably 
missing something.

Regards,
Enno


