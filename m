From: Frans Pop <elendil@planet.nl>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Fri, 15 Feb 2008 11:19:20 +0100
Message-ID: <200802151119.23325.elendil@planet.nl>
References: <200802111623.38478.elendil@planet.nl> <86802c440802141538m44d64b6as827426174874979d@mail.gmail.com> <20080215065746.GA8916@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml11.kpnxchange.com ([213.75.38.111]:44541 "EHLO
	hpsmtp-eml11.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753609AbYBOKT1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 05:19:27 -0500
In-Reply-To: <20080215065746.GA8916@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Friday 15 February 2008, Greg KH wrote:
> I swear someone sent this patch in before.  Can you try this one below,
> there seems to be an imbalance with kobject_get and _put.

I did remember seeing this patch before [1] and can confirm that it does 
indeed fix the issue: with this patch applied to 2.6.25 git head my system 
powers off correctly.

[1] See http://lkml.org/lkml/2008/2/8/342; also added to #9960.

> ---
>  drivers/cpufreq/cpufreq.c |    8 --------
>  1 file changed, 8 deletions(-)
>
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1006,14 +1006,6 @@ static int __cpufreq_remove_dev (struct
>  	}
>  #endif
>
> -
> -	if (!kobject_get(&data->kobj)) {
> -		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -		cpufreq_debug_enable_ratelimit();
> -		unlock_policy_rwsem_write(cpu);
> -		return -EFAULT;
> -	}
> -
>  #ifdef CONFIG_SMP
>
>  #ifdef CONFIG_HOTPLUG_CPU

