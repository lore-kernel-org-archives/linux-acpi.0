From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v18 03/15] clocksource/drivers/arm_arch_timer: Improve
 printk relevant code
Date: Fri, 9 Dec 2016 16:24:54 +0800
Message-ID: <CADyBb7uW6rsKVRRy_CJDmsDxK7qm=Trgae46NdbAKtmQd_DD8Q@mail.gmail.com>
References: <20161208173319.6618-1-fu.wei@linaro.org> <20161208173319.6618-4-fu.wei@linaro.org>
 <1481231430.5946.34.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481231430.5946.34.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@lin>
List-Id: linux-acpi@vger.kernel.org

Hi Joe,

On 9 December 2016 at 05:10, Joe Perches <joe@perches.com> wrote:
> On Fri, 2016-12-09 at 01:33 +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patch defines pr_fmt(fmt) for all pr_* functions,
>> then the pr_* doesn't need to add "arch_timer:" everytime.
>
> trivia:
>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> []
>> @@ -966,7 +967,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
>>
>>       ret = -EINVAL;
>>       if (!irq) {
>> -             pr_err("arch_timer: Frame missing %s irq",
>> +             pr_err("Frame missing %s irq",
>>                      arch_timer_mem_use_virtual ? "virt" : "phys");
>>               goto out;
>>       }
>
> Missing terminating newline
>
>                 pr_err("Frame missing %s irq\n",

yes, you are right , will fix it. :-)
Thanks


-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
