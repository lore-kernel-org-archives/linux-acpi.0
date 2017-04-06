From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v23 06/11] clocksource: arm_arch_timer: refactor MMIO
 timer probing.
Date: Thu, 6 Apr 2017 18:45:06 +0800
Message-ID: <CADyBb7tjLRYHsrB3V579RGxGS0jM51x628AqKomV_VFm+0b0ZQ@mail.gmail.com>
References: <20170331175105.8370-1-fu.wei@linaro.org> <20170331175105.8370-7-fu.wei@linaro.org>
 <20170405184229.GA29338@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:35102 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754970AbdDFKpH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Apr 2017 06:45:07 -0400
Received: by mail-it0-f51.google.com with SMTP id y18so98490073itc.0
        for <linux-acpi@vger.kernel.org>; Thu, 06 Apr 2017 03:45:07 -0700 (PDT)
In-Reply-To: <20170405184229.GA29338@leverpostej>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>

Hi Mark,

On 6 April 2017 at 02:42, Mark Rutland <mark.rutland@arm.com> wrote:
> On Sat, Apr 01, 2017 at 01:51:00AM +0800, fu.wei@linaro.org wrote:
>> +     arch_timer_mem_freq = arch_timer_mem_get_cntfrq(base);
>> +     if (!arch_timer_rate && arch_timer_mem_freq) {
>> +             arch_timer_rate = arch_timer_mem_freq;
>> +     } else if (!arch_timer_rate || arch_timer_rate != arch_timer_mem_freq) {
>> +             pr_err(FW_BUG "invalid MMIO frequency.\n");
>> +             iounmap(base);
>> +             return -EINVAL;
>> +     }
>
> I thought I had previously mentioned that this last check has the
> potential to break DT systems, which may be inadvertently relying on the
> probe order.
>
> I agree we must do this check for ACPI, but I think that for DT it needs
> to be relaxed.
>
> I'm happy to rework that locally, if you can address my comments on
> patch 9.

yes, you suggested that we keep the current frequency probing approach for DT,
and use the new approach for ACPI.

Because we try to merge the common code for MMIO timer. this become a little
problem, sorry for that.

I thinks for this code, maybe we can do :

arch_timer_mem_freq = arch_timer_mem_get_cntfrq(base);
if (!arch_timer_rate && arch_timer_mem_freq) {
arch_timer_rate = arch_timer_mem_freq;
} else if (!acpi_disabled && arch_timer_rate != arch_timer_mem_freq) {
pr_err(FW_BUG "invalid MMIO frequency.\n");
iounmap(base);
return -EINVAL;
}

Please correct me, if I miss something.

Thanks :-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
