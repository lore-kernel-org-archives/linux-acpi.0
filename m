From: Shannon Zhao <zhaoshenglong@huawei.com>
Subject: Re: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Fri, 27 Feb 2015 18:51:43 +0800
Message-ID: <54F04C3F.7040201@huawei.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <54EFE282.1090305@codeaurora.org> <54F02CB6.2090508@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:45597 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbbB0KxQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Feb 2015 05:53:16 -0500
In-Reply-To: <54F02CB6.2090508@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Timur Tabi <timur@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, "Huangpeng (Peter)" <peter.huangpeng@huawei.com>

On 2015/2/27 16:37, Hanjun Guo wrote:
> Hi Timur,
>=20
> On 2015=E5=B9=B402=E6=9C=8827=E6=97=A5 11:20, Timur Tabi wrote:
>> On 02/25/2015 02:39 AM, Hanjun Guo wrote:
>>> Changes since v8:
>>
>> I'm still debugging it, but v9 on the 4.0-rc1 kernel crashes after
>> calling the UEFI boot time services exit function.  That is, this li=
ne:
>>
>> status =3D sys_table->boottime->exit_boot_services(handle, mmap_key)=
;
>>
>> in allocate_new_fdt_and_exit_boot() gets called, and then soon after=
 it
>> returns, the kernel crashes.  It's really early because the UEFI
>> exception handler is called.
>>
>> I did not have this problem with v8 patchset on 3.19.
>=20
> I tested this patch set on FVP base model with UEFI, and booted ok.
> Can you boot the system without this ACPI patch set?
>=20
>>
>>
>> Also, you still have a couple whitespace problems in these patches:
>>
>> Applying: ARM64 / ACPI: additions of ACPI documentation for arm64
>> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:607: new blank =
line
>> at EOF.
>> +
>> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:844: new blank =
line
>> at EOF.
>> +
>> warning: 2 lines add whitespace errors.
>> Applying: Documentation: ACPI for ARM64
>> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:517: new blank =
line
>> at EOF.
>> +
>> warning: 1 line adds whitespace errors.
>=20
> Weired, When I checked the patch locally there were no whitespace
> problems:

I found those whitespace errors too. Please see the comments in each pa=
tch.

--=20
Thanks,
Shannon

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
