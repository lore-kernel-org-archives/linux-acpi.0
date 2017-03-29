From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v22 03/11] clocksource: arm_arch_timer: refactor
 arch_timer_needs_probing
Date: Wed, 29 Mar 2017 17:32:28 +0200
Message-ID: <20170329153228.GN2123@mai>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-4-fu.wei@linaro.org>
 <20170328150220.GF2123@mai>
 <20170329152408.GM23442@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36006 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753930AbdC2Pcf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2017 11:32:35 -0400
Received: by mail-wr0-f179.google.com with SMTP id w11so19704545wrc.3
        for <linux-acpi@vger.kernel.org>; Wed, 29 Mar 2017 08:32:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170329152408.GM23442@leverpostej>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org, tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com

On Wed, Mar 29, 2017 at 04:24:08PM +0100, Mark Rutland wrote:
> On Tue, Mar 28, 2017 at 05:02:20PM +0200, Daniel Lezcano wrote:
> > On Wed, Mar 22, 2017 at 12:31:14AM +0800, fu.wei@linaro.org wrote:
> > > From: Fu Wei <fu.wei@linaro.org>
> > > 
> > > When system init with device-tree, we don't know which node will be
> > > initialized first. And the code in arch_timer_common_init should wait
> > > until per-cpu timer and MMIO timer are both initialized. So we need
> > > arch_timer_needs_probing to detect the init status of system.
> > > 
> > > But currently the code is dispersed in arch_timer_needs_probing and
> > > arch_timer_common_init. And the function name doesn't specify that
> > > it's only for device-tree. This is somewhat confusing.
> > 
> > Can the following patch help you to solve nicely the situation ?
> > 
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1360007.html
> 
> This does not help.
> 
> The needs_probing logic is all there to bodge around a problem with
> registering sched_clock, when you have two sources of the same
> frequency, but one is otherwise better.
> 
> The sysreg clocksource has much lower latency than the MMIO clocksource,
> so we always want to use that as the sched_clock if we have it.
> Currently, the code ensures this by deferring registration of
> sched_clock.
> 
> Ideally, we'd figure that out dynamically, or we'd have a rating
> argument.
> 

Ok, I see. Thanks.

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
