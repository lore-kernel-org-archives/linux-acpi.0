From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Thu, 31 Jan 2008 10:51:04 -0800
Message-ID: <87tzkt96cn.fsf@paris.hilman.org>
References: <200801301116.44902.rjw@sisk.pl>
	<924EFEDD5F540B4284297C4DC59F3DEE7202A0@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:3261 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757649AbYAaSvH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 13:51:07 -0500
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE7202A0@orsmsx423.amr.corp.intel.com> (Venkatesh Pallipadi's message of "Thu\, 31 Jan 2008 10\:44\:48 -0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> writes:

>> Wrap cpu_idle_wait() in an x86 #ifdef since it's x86 only.
>> Signed-off-by: Kevin Hilman <khilman@mvista.com>
>> 
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index d2fabe7..4d0f9b0 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -82,7 +82,9 @@ void cpuidle_uninstall_idle_handler(void)
>>  {
>>  	if (enabled_devices && (pm_idle != pm_idle_old)) {
>>  		pm_idle = pm_idle_old;
>> +#ifdef CONFIG_X86
>>  		cpu_idle_wait();
>> +#endif
>> 
>
> The archs that do not have cpu_idle_wait() and has more than one CPU
> will need something equivalent to cpu_idle_wait() to kick all other CPUs
> out of idle loop.
> The reason being we do not want another CPU to be in idle loop that is
> being uninstalled here.
>
> Do you have more than one logical CPU on your platform?

No, I'm testing on a UP ARM-based platform (TI OMAP.)

Maybe #ifdef CONFIG_SMP is the right thing instead of #ifdef
CONFIG_X86? 

Kevin
