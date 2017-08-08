From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3] irqchip/gic-v3-its: Allow GIC ITS number more than
 MAX_NUMNODES
Date: Tue, 8 Aug 2017 10:04:21 +0800
Message-ID: <100a52a8-d7c6-481c-dfe8-11c269d5b09b@linaro.org>
References: <1501064149-37285-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35433 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdHHCEZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2017 22:04:25 -0400
Received: by mail-pg0-f48.google.com with SMTP id v189so8560822pgd.2
        for <linux-acpi@vger.kernel.org>; Mon, 07 Aug 2017 19:04:25 -0700 (PDT)
In-Reply-To: <1501064149-37285-1-git-send-email-guohanjun@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, John Garry <john.garry@huawei.com>

On 2017/7/26 18:15, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> When enabling ITS NUMA support on D05, I got the boot log:
> 
> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
> [    0.000000] SRAT: ITS affinity exceeding max count[4]
> 
> This is wrong on D05 as we have 8 ITSs with 4 NUMA nodes.
> 
> So dynamically alloc the memory needed instead of using
> its_srat_maps[MAX_NUMNODES], which count the number of
> ITS entry(ies) in SRAT and alloc its_srat_maps as needed,
> then build the mapping of numa node to ITS ID. Of course,
> its_srat_maps will be freed after ITS probing because
> we don't need that after boot.
> 
> After doing this, I got what I wanted:
> 
> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
> [    0.000000] SRAT: PXM 2 -> ITS 4 -> Node 2
> [    0.000000] SRAT: PXM 2 -> ITS 5 -> Node 2
> [    0.000000] SRAT: PXM 2 -> ITS 6 -> Node 2
> [    0.000000] SRAT: PXM 3 -> ITS 7 -> Node 3
> 
> Fixes: dbd2b8267233 ("irqchip/gic-v3-its: Add ACPI NUMA node mapping")
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
> 
> v2->v3:
>    - Remove the NULL check for its_srat_maps as its_in_srat will be 0;
>    - Add warning if alloc memory failed for its_srat_maps;
>    - Update commit log as Lorenzo suggested;
>    - Add review tag

Sorry for the ping, I'm not sure if I missed some review comments
for v2, if I did, I'm sorry for that, please give me some hint if
I need to respin another version.

Thanks
Hanjun
