From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 17/21] clocksource / arch_timer: Parse GTDT to initialize
 arch timer
Date: Tue, 03 Feb 2015 21:28:11 +0800
Message-ID: <54D0CCEB.2020200@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-18-git-send-email-hanjun.guo@linaro.org> <3447958.XfVzbZ6OCs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:63960 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965423AbbBCN2Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2015 08:28:24 -0500
Received: by mail-pa0-f45.google.com with SMTP id et14so96318051pad.4
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2015 05:28:24 -0800 (PST)
In-Reply-To: <3447958.XfVzbZ6OCs@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>, wangyij

On 2015=E5=B9=B402=E6=9C=8803=E6=97=A5 06:23, Rafael J. Wysocki wrote:
> On Monday, February 02, 2015 08:45:45 PM Hanjun Guo wrote:
>> Using the information presented by GTDT (Generic Timer Description T=
able)
>> to initialize the arch timer (not memory-mapped).
>>
>> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Tested-by: Jon Masters <jcm@redhat.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/kernel/time.c             |   7 ++
>>   drivers/clocksource/arm_arch_timer.c | 132 +++++++++++++++++++++++=
+++++-------
>
> An ACK from Thomas Gleixner is necessary for that.

I will CC Thomas in the change log in next version
with both patch 16/17.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
