From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v7 00/15] ACPI platform MSI support and its example mbigen
Date: Sat, 14 Jan 2017 09:04:08 +0800
Message-ID: <58797908.90700@huawei.com>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <CACVXFVO8n=Y+eN0Z_zMZJsirf+VNSr-y9g3uwwxQZzAxds=m4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:54356 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdANBFh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jan 2017 20:05:37 -0500
In-Reply-To: <CACVXFVO8n=Y+eN0Z_zMZJsirf+VNSr-y9g3uwwxQZzAxds=m4g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, huxinwei@huawei.com, Kefeng Wang <wangkefeng.wang@huawei.com>, Matthias Brugger <mbrugger@suse.com>, Jon Masters <jcm@redhat.com>, "Yimin (Leo)" <yimin@huawei.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Ma Jun <majun258@huawei.com>

Hi Ming,

On 2017/1/13 18:23, Ming Lei wrote:
> On Wed, Jan 11, 2017 at 11:06 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> With platform msi support landed in the kernel, and the introduction
>> of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
>> is ready, this patch set add few patches to enable the ACPI platform
>> msi support.
>>
>> For platform device connecting to ITS on arm platform, we have IORT
>> table with the named componant node to describe the mappings of paltform
>> device and ITS, so we can retrieve the dev id and find its parent
>> irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).
>>
>> v6 -> v7:
>>         - Introduce iort_node_map_platform_id() to retrieve the
>>           dev id for both NC (named component) -> ITS/SMMU and
>>           NC -> SMMU -> ITS cases, suggested by Lorenzo;
>>
>>         - Reorder the patches and rewrite some commit message;
>>
>>         - Remove the test tags because it has major changes
>>           to retrieve the dev id, Sinan, Majun, Xinwei, could
>>           you please test them again on your platform?
>>
>>         - rebased on top of 4.10-rc3 and Lorenzo's patch
>>           https://patchwork.kernel.org/patch/9507041/
>>
>>         - Tested against Agustin's patch [1-2/3] "[PATCH V9 0/3] irqchip: qcom:
>>           Add IRQ combiner driver"
> Looks v7 works fine on D05, together with Lorenzo's
> fix([v2] ACPI/IORT: Fix iort_node_get_id() mapping entries indexing) and
> Agustin's patchset of "v9 irqchip: qcom: Add IRQ combiner driver".
>
> Tested-by: Ming Lei <ming.lei@canonical.com>

Thank you very much :)

Hanjun

