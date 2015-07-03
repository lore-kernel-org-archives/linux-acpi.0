From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] ARM64 / SMP: Switch pr_err() to pr_debug() for disabled
 GICC entry
Date: Fri, 3 Jul 2015 09:18:42 +0800
Message-ID: <5595E2F2.4070907@huawei.com>
References: <1435757843-13236-1-git-send-email-hanjun.guo@linaro.org> <1435858716.24502.8.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:30891 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbbGCBT4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2015 21:19:56 -0400
In-Reply-To: <1435858716.24502.8.camel@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org

On 2015/7/3 1:38, Mark Salter wrote:
> On Wed, 2015-07-01 at 21:37 +0800, Hanjun Guo wrote:
>
>> It is normal that firmware presents GICC entry or entries (processors)
>> with disabled flag in ACPI MADT, taking a system of 16 cpus for example,
>> ACPI firmware may present 8 enabled first with another 8 cpus disabled
>> in MADT, the disabled cpus can be hot-added later.
>>
>> Firmware may also present more cpus than the hardware actually has, but
>> disabled the unused ones, and easily enable it when the hardware has such
>> cpus to make the firmware code scalable.
>>
>> So that's not an error for disabled cpus in MADT, we can switch
>> pr_err() to pr_debug() instead.
>>
> I agree with pr_debug instead of pr_err, but for hotplug to work
> I think we need to continue to parse the MADT instead of bailing
> out altogether, right? We need to know at init time how many

Yes, agreed :)

> possible cpus there are and that number never changes as cpus
> are plugged/unplugged. Right now, set_cpu_possible() only gets
> called if smp_cpu_setup() gets called and smp_cpu_setup() only
> gets called if the cpu is in the cpu_logical_map.

We need some extra work to make the physical CPU hotplug work
on ARM64.

Thanks
Hanjun

