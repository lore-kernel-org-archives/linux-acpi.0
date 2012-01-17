From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2/3] intel_idle: disable auto_demotion for hotplugged
 CPUs
Date: Tue, 17 Jan 2012 14:22:03 -0500
Message-ID: <4F15CA5B.5050407@kernel.org>
References: <20120110234820.B14B8100270@wpzn3.hot.corp.google.com> <201201171156.38490.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62351 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514Ab2AQTWG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 14:22:06 -0500
Received: by vcbfo1 with SMTP id fo1so2085318vcb.19
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 11:22:06 -0800 (PST)
In-Reply-To: <201201171156.38490.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, shaohua.li@intel.com

Andrew,
Per reasoning from Thomas below, please drop this one.

thanks,
-Len

On 01/17/2012 05:56 AM, Thomas Renninger wrote:

> On Wednesday, January 11, 2012 12:48:20 AM akpm@linux-foundation.org wrote:
>> From: Shaohua Li <shaohua.li@intel.com>
>> Subject: intel_idle: disable auto_demotion for hotplugged CPUs
> 
> This one should not be necessary anymore with my intel_idle
> patch series I have to rebase and resend (will do that after lunch).
> 
> It provides a per cpu intel_idle init function which is called
> from processor.ko in physical cpu hotplug case.
> 
> From what I can see this patch does not change anything/much, because:
>   - CPUs onlined at bootup are initialized correctly already
>   - Soft offlining/onlining shouldn't matter in auto_demotion_disable
>     case as it's a HW MSR write and the CPU should still be in the
>     same state after off- and onlined again.
>   - Physically hotplugged/added CPUs are not registered with cpuidle
>     at all (this is what my patch series fixes), because intel_idle
>     does not offer any per cpu init() entry function.
>     With this patch they might be set into auto_demotion_disable now,
>     but no idle driver gets active for them.
> 
> I'll pick up patch 1/3 and 3/3, base my patches on top and resend
> everything, that should be easiest for everybody?
> 
>    Thomas
> 


