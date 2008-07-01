From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: RTC or button wakeup
Date: Tue, 01 Jul 2008 14:26:55 +0800
Message-ID: <1214893615.29463.1.camel@yakui_zhao.sh.intel.com>
References: <4867B402.2070104@tiscali.nl>
	 <1214788019.26947.2.camel@yakui_zhao.sh.intel.com>
	 <4868EC4E.8020804@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36930 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbYGAGQs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jul 2008 02:16:48 -0400
In-Reply-To: <4868EC4E.8020804@tiscali.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Enno Fennema <e.fennema@tiscali.nl>
Cc: linux-acpi@vger.kernel.org

On Mon, 2008-06-30 at 16:23 +0200, Enno Fennema wrote: 
> Zhao Yakui wrote:
> > On Sun, 2008-06-29 at 18:10 +0200, Enno Fennema wrote:
> >> Could anyone suggest a way to determine in a (shell) program whether my 
> >> computer was switched on by RTC alarm or by me pressing the power button.
> >>
> >     ACPI: Disable Fixed_RTC event when installing RTC handler
> > 
> > In fact the commit is already merged into upstream kernel. Will you
> 
> Thanks for yor reply but ... you are streets ahead of me.
> I have RTC alarm enabled in BIOS and the alarm starts my machine from 
> Soft-off and boots correctly at, in my case, 23:05 every evening, and 
> not at 00:00 or any other time. At 23:10 cron starts my daily jobs.
Your problem is how to decide whether the system is booted by RTC or
power button. Is that right? Sorry for misunderstanding what you said in
my previous email. The following commit patch is to avoid that the
system is misfired by RTC alarm even when RTC alarm is not set. It can't
solve your problem.

>commit e1094bfa26e5e94af2fea79e004614dbce42b008
>Author: Zhao Yakui <yakui.zhao@intel.com>
>Date:   Wed May 14 11:32:59 2008 +0800
>   ACPI: Disable Fixed_RTC event when installing RTC handler

RTC_sts and RTC_ENA also can't give you any help. After the system is
booted, RTC_sts will be clear and RTC_ENA will be disabled. Only when
RTC alarm is required, it will be enabled again.

Maybe you should find another method to identify whether the system is
booted by RTC_alarm.


> I think I am not interested in any further RTC alarms, which will not
> happen for 24 hours anyway.
> 
> My problem is to decide at the end of the daily jobs whether to switch
> off the machine with /sbin/halt (if RTC started my machine) or not to
> switch off (if pressing the power button had started the machine).
> 
> Are you saying that testing (after installing the patch) either RTC_STS 
> or RTC_ENA would give me my answer.
> 
> Before installing the patch I see no both bits look identical when 
> switched on by hand or by RTC. Sorry, I am an acpi-newbie and probably 
> missing something.
> 
> Regards,
> Enno
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

