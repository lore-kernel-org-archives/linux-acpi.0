From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 03/20] ARM64 / ACPI: Introduce the skeleton of _PDC related
 for ARM64
Date: Fri, 24 Jan 2014 22:43:15 +0800
Message-ID: <52E27C03.8090903@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-4-git-send-email-hanjun.guo@linaro.org> <52D93D4E.5020605@arm.com> <52DCEA66.90903@linaro.org> <20140123161918.GA25927@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:43452 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbaAXOnY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jan 2014 09:43:24 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so3348526pad.14
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jan 2014 06:43:23 -0800 (PST)
In-Reply-To: <20140123161918.GA25927@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles.Garci>

On 2014=E5=B9=B401=E6=9C=8824=E6=97=A5 00:19, Catalin Marinas wrote:
> On Mon, Jan 20, 2014 at 09:20:38AM +0000, Hanjun Guo wrote:
>> On 2014-1-17 22:25, Sudeep Holla wrote:
>>> On 17/01/14 12:24, Hanjun Guo wrote:
>>>> --- a/arch/arm64/kernel/process.c
>>>> +++ b/arch/arm64/kernel/process.c
>>>> @@ -89,6 +89,9 @@ void arch_cpu_idle_prepare(void)
>>>>   	local_fiq_enable();
>>>>   }
>>>>  =20
>>>> +unsigned long boot_option_idle_override =3D IDLE_NO_OVERRIDE;
>>>> +EXPORT_SYMBOL(boot_option_idle_override);
>>>> +
>>> This is what I mentioned in other email. Do we really foresee use o=
f this in
>>> ARM64 or it's just added to avoid build issues ?
>> Just avoid build issues, can not foresee use of this in ARM64 :)
> So ideally we should look for a better solution here.

Ok, I will try my best.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
