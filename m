From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 06/14] irqchip: gicv3-its: platform-msi: refactor
 its_pmsi_init() to prepare for ACPI
Date: Wed, 4 Jan 2017 18:19:11 +0800
Message-ID: <6a16a21d-f8c0-a836-22b9-e18a4f13c38e@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-7-git-send-email-hanjun.guo@linaro.org>
 <8cdc4bfa-18a3-b9f6-aaba-0efe1f75fb40@semihalf.com>
 <601cbdf2-823d-8bde-bbd9-fcc6a1c67f2c@linaro.org>
 <b51b7be9-f8ee-57f9-6d53-6e8bd73dd431@semihalf.com>
 <254387f0-1f63-4c83-ef90-570ef072cddf@linaro.org>
 <e08b5583-bb82-4676-2370-1147d79416ac@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34332 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759557AbdADKUH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jan 2017 05:20:07 -0500
Received: by mail-pg0-f46.google.com with SMTP id y62so173922242pgy.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Jan 2017 02:19:25 -0800 (PST)
In-Reply-To: <e08b5583-bb82-4676-2370-1147d79416ac@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, charles.garcia-tobin@arm.com, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>

On 2017/1/4 17:02, Marc Zyngier wrote:
> On 04/01/17 08:25, Hanjun Guo wrote:
>> On 2017/1/4 15:29, Tomasz Nowicki wrote:
>>> On 04.01.2017 08:02, Hanjun Guo wrote:
>>>> Hi Tomasz,
>>>>
>>>> On 2017/1/3 15:41, Tomasz Nowicki wrote:
>>>>> Hi,
>>>>>
>>>>> Can we merge patch 4 & 6 into one patch so that we keep refactoring part
>>>>> as one piece ? I do not see a reason to keep them separate or have patch
>>>>> 5 in between. You can refactor what needs to be refactored, add
>>>>> necessary functions to iort.c and then support ACPI for
>>>>> irq-gic-v3-its-platform-msi.c
>>>>
>>>> There are two functions here,
>>>>  - retrieve the dev id from IORT which was DT based only;
>>>>
>>>>  - init the platform msi domain from MADT;
>>>>
>>>> For each of them split it into two steps,
>>>>  - refactor the code for ACPI later and it's easy for review
>>>>    because wen can easily to figure out it has functional
>>>>    change or not
>>>>
>>>>  - add ACPI functionality
>>>>
>>>> Does it make sense?
>>>
>>> It is up to Marc, but personally I prefer:
>>> 1. Refactor dev id retrieving and init function in one patch and
>>> highlight no functional changes in changelog
>>> 2. Crate necessary infrastructure in iort.c
>>> 3. Then add ACPI support to irq-gic-v3-its-platform-msi.c
>>
>> I have no strong preferences, and it's easy to do so as just
>> need to squash/reorder the patches.
>>
>> Marc, Lorenzo, could you give some suggestions here?
>
> I think it'd make the reviewing easier to have patches that are
> semantically grouped together (all the ACPI IORT together, for example).
>
> It would help understanding where you're aiming at instead of jumping
> from irqchip to ACPI and back every other patch...

OK, I will reorder the patches and address the comments, then post
a new version.

Thanks
Hanjun
