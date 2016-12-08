From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v17 08/15] clocksource/drivers/arm_arch_timer:
 move arch_timer_needs_of_probing into DT init call
Date: Thu, 8 Dec 2016 11:16:21 +0800
Message-ID: <CADyBb7vAfMGV5ERFqAbwo4v4BhJv5s_-x4DXmdvy=iUacBzJWQ@mail.gmail.com>
References: <20161125084623.22515-9-fu.wei@linaro.org> <201611252221.UyJ9iWPV%fengguang.wu@intel.com>
 <CADyBb7uAObQn_JVp_qw9+7POiqUctdzy3cYLsb0rk-JMX5W1uw@mail.gmail.com> <CAOZdJXU7Lg66RKvA=sYtUXUdwLLbh9FtcW0_U-fmjaztnqS3Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33642 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933056AbcLHDQe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2016 22:16:34 -0500
Received: by mail-io0-f176.google.com with SMTP id j65so6558825iof.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 Dec 2016 19:16:22 -0800 (PST)
In-Reply-To: <CAOZdJXU7Lg66RKvA=sYtUXUdwLLbh9FtcW0_U-fmjaztnqS3Ng@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: kbuild test robot <lkp@intel.com>, Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, kbuild-all@01.org, "Abdulhamid, Harb" <harba@codeaurora.org>, Julien Grall <julien.grall@arm.com>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-ke

Hi Timur,

On 8 December 2016 at 01:25, Timur Tabi <timur@codeaurora.org> wrote:
> On Fri, Nov 25, 2016 at 9:06 AM, Fu Wei <fu.wei@linaro.org> wrote:
>>
>> a "+ int ret;" should be move from [12/15] to here, I have fix the
>> problem in my repo, it would happen in next patchset
>>
>> https://git.linaro.org/people/fu.wei/linux.git/log/?h=topic-gtdt-wakeup-timer_upstream_v18_devel
>
> Fu, please post v18 to the mailing list so that it can be picked up
> for 4.10 (if it's not too late already).

Great thanks for your suggestion!  :-)
yes, you are right, I would love to post v18 ASAP.

But I am still waiting for more feedback from the maintainers.
For Now, the only feedback is this fix from "kbuild test robot" :-(

>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
