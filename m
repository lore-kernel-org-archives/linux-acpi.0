From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 01/19] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
Date: Tue, 29 Jul 2014 14:50:26 +0100
Message-ID: <53D7A6A2.9020005@arm.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org> <1406206825-15590-2-git-send-email-hanjun.guo@linaro.org> <53D69678.20002@arm.com> <53D79CD8.9050709@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57482 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaG2Nt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jul 2014 09:49:59 -0400
In-Reply-To: <53D79CD8.9050709@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@linaro.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.or>



On 29/07/14 14:08, Hanjun Guo wrote:
> On 2014-7-29 2:29, Sudeep Holla wrote:
> [...]
>>> +
>>> +/*
>>> + * We never plan to use RSDT on arm/arm64 as its deprecated in spec but this
>>> + * variable is still required by the ACPI core
>>> + */
>>> +u32 acpi_rsdt_forced;
>>
>> This looks like yet another stray variable not used anywhere including
>> core ACPI
>
> It will be used by ACPICA to get the RSDP in acpi_tb_parse_root_table()
> in tbutils.c.
>

No I couldn't find it in mainline/acpica/linux-next(pm tree).

On further digging found that commit fab461058385("ACPICA: Cleanup the
option of forcing the use of the RSDT") has renamed it to
acpi_gbl_do_not_use_xsdt and moved it into acpica with default false.
So you can remove this.

Regards,
Sudeep

