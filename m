From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 06/14] irqchip: gicv3-its: platform-msi: refactor
 its_pmsi_init() to prepare for ACPI
Date: Wed, 4 Jan 2017 16:25:47 +0800
Message-ID: <254387f0-1f63-4c83-ef90-570ef072cddf@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-7-git-send-email-hanjun.guo@linaro.org>
 <8cdc4bfa-18a3-b9f6-aaba-0efe1f75fb40@semihalf.com>
 <601cbdf2-823d-8bde-bbd9-fcc6a1c67f2c@linaro.org>
 <b51b7be9-f8ee-57f9-6d53-6e8bd73dd431@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35115 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbdADI0T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jan 2017 03:26:19 -0500
Received: by mail-pg0-f45.google.com with SMTP id i5so160074523pgh.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Jan 2017 00:26:19 -0800 (PST)
In-Reply-To: <b51b7be9-f8ee-57f9-6d53-6e8bd73dd431@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, charles.garcia-tobin@arm.com, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>

On 2017/1/4 15:29, Tomasz Nowicki wrote:
> On 04.01.2017 08:02, Hanjun Guo wrote:
>> Hi Tomasz,
>>
>> On 2017/1/3 15:41, Tomasz Nowicki wrote:
>>> Hi,
>>>
>>> Can we merge patch 4 & 6 into one patch so that we keep refactoring part
>>> as one piece ? I do not see a reason to keep them separate or have patch
>>> 5 in between. You can refactor what needs to be refactored, add
>>> necessary functions to iort.c and then support ACPI for
>>> irq-gic-v3-its-platform-msi.c
>>
>> There are two functions here,
>>  - retrieve the dev id from IORT which was DT based only;
>>
>>  - init the platform msi domain from MADT;
>>
>> For each of them split it into two steps,
>>  - refactor the code for ACPI later and it's easy for review
>>    because wen can easily to figure out it has functional
>>    change or not
>>
>>  - add ACPI functionality
>>
>> Does it make sense?
>
> It is up to Marc, but personally I prefer:
> 1. Refactor dev id retrieving and init function in one patch and
> highlight no functional changes in changelog
> 2. Crate necessary infrastructure in iort.c
> 3. Then add ACPI support to irq-gic-v3-its-platform-msi.c

I have no strong preferences, and it's easy to do so as just
need to squash/reorder the patches.

Marc, Lorenzo, could you give some suggestions here?

Thanks
Hanjun
