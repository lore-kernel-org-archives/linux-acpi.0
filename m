From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Tue, 06 Jan 2015 19:17:23 +0800
Message-ID: <54ABC443.2070502@linaro.org>
References: <1420368918-5086-1-git-send-email-hanjun.guo@linaro.org> <54AB894C.9010001@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:59571 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbbAFLRv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jan 2015 06:17:51 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so30849706pad.13
        for <linux-acpi@vger.kernel.org>; Tue, 06 Jan 2015 03:17:51 -0800 (PST)
In-Reply-To: <54AB894C.9010001@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yijing Wang <wangyijing@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2015=E5=B9=B401=E6=9C=8806=E6=97=A5 15:05, Yijing Wang wrote:
> On 2015/1/4 18:55, Hanjun Guo wrote:
>> Hi,
>
> Hello Hanjun,
>
> We tested your v5 patch set (and added some GICv3 patches) on Hisilic=
on ARM64 SoC hardware,
> from your change log for v6,  there is only one functional change to =
fix the NULL pointer, I think
> the test result is still valid for v6, please refer to the test resul=
t below [1].
>
> We can boot the system successfully using PSCI on our ARM64 hardware =
using this patch set, of course
> we need to add some more patches (GICv3), but with this patch set:
>
> You could add my Tested-by: Yijing Wang <wangyijing@huawei.com> if yo=
u want.

Great, thanks a lot!

>
> if you want me to test the new version of patch set, please let me kn=
ow, thanks.

if you have some free time, please help me to do that :)

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
