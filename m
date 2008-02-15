From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Fri, 15 Feb 2008 11:38:59 -0800
Message-ID: <86802c440802151138i303c58a2m2eca9e97566c3@mail.gmail.com>
References: <200802111623.38478.elendil@planet.nl>
	 <86802c440802141538m44d64b6as827426174874979d@mail.gmail.com>
	 <20080215065746.GA8916@suse.de> <200802151119.23325.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:34541 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757977AbYBOTjB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Feb 2008 14:39:01 -0500
Received: by wx-out-0506.google.com with SMTP id h31so761111wxd.4
        for <linux-acpi@vger.kernel.org>; Fri, 15 Feb 2008 11:39:00 -0800 (PST)
In-Reply-To: <200802151119.23325.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Greg KH <gregkh@suse.de>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Feb 15, 2008 at 2:19 AM, Frans Pop <elendil@planet.nl> wrote:
> On Friday 15 February 2008, Greg KH wrote:
>  > I swear someone sent this patch in before.  Can you try this one below,
>  > there seems to be an imbalance with kobject_get and _put.
>
>  I did remember seeing this patch before [1] and can confirm that it does
>  indeed fix the issue: with this patch applied to 2.6.25 git head my system
>  powers off correctly.
>
>  [1] See http://lkml.org/lkml/2008/2/8/342; also added to #9960.
>
>
>
>  > ---
>  >  drivers/cpufreq/cpufreq.c |    8 --------
>  >  1 file changed, 8 deletions(-)
>  >
>  > --- a/drivers/cpufreq/cpufreq.c
>  > +++ b/drivers/cpufreq/cpufreq.c
>  > @@ -1006,14 +1006,6 @@ static int __cpufreq_remove_dev (struct
>  >       }
>  >  #endif
>  >
>  > -
>  > -     if (!kobject_get(&data->kobj)) {
>  > -             spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  > -             cpufreq_debug_enable_ratelimit();
>  > -             unlock_policy_rwsem_write(cpu);
>  > -             return -EFAULT;
>  > -     }
>  > -
>  >  #ifdef CONFIG_SMP
>  >
>  >  #ifdef CONFIG_HOTPLUG_CPU
>
>

confirmed, with this patch, i still need disable CONFIG_DETECT_SOFTLOCKUP

assume watchdog thread for the dead cpu can not be stopped. hang somewhere.

YH
