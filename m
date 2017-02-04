From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v8 00/15] ACPI platform MSI support and its example mbigen
Date: Sat, 4 Feb 2017 11:59:27 +0800
Message-ID: <5895519F.2060608@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <a2eb29e2-0f46-0be0-dc43-b3a086556965@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:37909 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753510AbdBDEA0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2017 23:00:26 -0500
In-Reply-To: <a2eb29e2-0f46-0be0-dc43-b3a086556965@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, Matthias Brugger <mbrugger@suse.com>, Wei Xu <xuwei5@hisilicon.com>, Ming Lei <tom.leiming@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>

On 2017/2/3 22:50, Sinan Kaya wrote:
> On 1/18/2017 7:54 AM, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
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
> I understand that there is a consensus on IORT/SMMUv3 specific pieces
> of this series while there is some ongoing work on the MBIgen part in
> due to dependency on Agustin's patch vs. ACPI definitions.

I think both Agustin's patch set and my mbigen one are in good shape
now if I didn't miss something, Rafael and Lorenzo already acked Agustin's
patch [1-2/3], I provided my review and test tags on them.

And Lorenzo said about the mbigen patches:
"I think this patch (and the FW that goes with it) is wrong, but the rest
of the series, in particular the IORT bits, are ok with me."
and I fixed the wrong patch and updated the _PRS to _CRS as Lorenzo
suggested in v8.

So, can I kindly ask that those patches (Agustin's patch set and my mbigen one)
be merged to 4.11 please? It's really important for Hisilicon (Hip06/Hip07) SoCs
which native NIC [1], SAS [2], USB and even the console on Hip07-D05 drivers
depend on those patches, and those platform are completely dead without
them if PCI is not enabled...

Thanks
Hanjun

[1]: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/hisilicon/hns/
[2]: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/hisi_sas/


