From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 02/21] ACPI / processor: Introduce phys_cpuid_t for CPU
 hardware ID
Date: Thu, 5 Mar 2015 14:23:56 +0100
Message-ID: <CAJZ5v0hu=TB4S00krNk1RpsXeHJVud2ehhcM0dZDhHAk6DamKg@mail.gmail.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
	<1424853601-6675-3-git-send-email-hanjun.guo@linaro.org>
	<1484357.vjmmcyQq4z@vostro.rjw.lan>
	<54F8095C.4030308@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36084 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbCENX5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2015 08:23:57 -0500
In-Reply-To: <54F8095C.4030308@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linaro-acpi@list

On Thu, Mar 5, 2015 at 8:44 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
> On 2015/3/5 6:29, Rafael J. Wysocki wrote:
>> On Wednesday, February 25, 2015 04:39:42 PM Hanjun Guo wrote:

[cut]

>>> @@ -190,7 +190,7 @@ int acpi_map_cpuid(int phys_id, u32 acpi_id)
>>>              if (nr_cpu_ids <= 1 && acpi_id == 0)
>>>                      return acpi_id;
>>>              else
>>> -                    return phys_id;
>>> +                    return -1;
>> Can we use a proper error code here?
>
> I'm afraid not. In ACPI processor drivers, -1 will be deemed to
> invalid cpu logical number, if we return error code here, we need
> to modify multi places of "if (cpu_logical_num == -1)" to

Oh, silly stuff.

> "if (! (cpu_logical_num < 0))" too, so for me, I prefer to keep it as
> -1, but I'm open for suggestions.

OK

I think we need something like invalid_logical_cpuid() and use it
in all of those checks instead of the direct comparisons, but we
can make those changes later.

Rafael
