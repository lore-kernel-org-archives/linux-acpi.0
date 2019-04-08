Return-Path: <SRS0=s14x=SK=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B012C10F14
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D950220883
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDHKrA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:47:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46244 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDHKrA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Apr 2019 06:47:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD72C15AD;
        Mon,  8 Apr 2019 03:46:59 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D66D3F718;
        Mon,  8 Apr 2019 03:46:58 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:46:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hanjun.guo@linaro.org
Subject: Re: [PATCH RESEND v2] ACPI/IORT: Reject platform dev creation when
 dev set to wrong numa node
Message-ID: <20190408104658.GB2727@red-moon>
References: <20190328140022.85790-1-wangkefeng.wang@huawei.com>
 <20190329031751.73814-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190329031751.73814-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190408104658.OYmbqrX-R7xQsV4B7gZvDSN-VtkIBykm1nL27MCdJWk@z>

Also, in the $SUBJECT, s/numa/NUMA because that's an acronym not
an English word.

Here:

"ACPI/IORT: Reject platform device creation on NUMA node mapping failure"

Thanks,
Lorenzo

On Fri, Mar 29, 2019 at 11:17:51AM +0800, Kefeng Wang wrote:
> If there is only node 0 in system, but smmuv3 device is set to offline
> node 1, parsed from proximity domain in SMMUv3 IORT table, it will lead
> to following crash,
> 
> [   47.492451] Unable to handle kernel paging request at virtual address 0000000000001388
> [   47.500361] Mem abort info:
> [   47.503143]   ESR = 0x96000004
> [   47.506189]   Exception class = DABT (current EL), IL = 32 bits
> [   47.512099]   SET = 0, FnV = 0
> [   47.515140]   EA = 0, S1PTW = 0
> [   47.518272] Data abort info:
> [   47.521144]   ISV = 0, ISS = 0x00000004
> [   47.524970]   CM = 0, WnR = 0
> [   47.527929] [0000000000001388] user address but active_mm is swapper
> [   47.534285] Internal error: Oops: 96000004 [#1] SMP
> [   47.539151] Modules linked in:
> [   47.542194] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.0.0 #15
> [   47.549490] pstate: 80c00009 (Nzcv daif +PAN +UAO)
> [   47.554272] pc : __alloc_pages_nodemask+0x13c/0x1068
> [   47.559224] lr : __alloc_pages_nodemask+0xdc/0x1068
> ...
> [   47.646873] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> [   47.653560] Call trace:
> [   47.655994]  __alloc_pages_nodemask+0x13c/0x1068
> [   47.660600]  new_slab+0xec/0x570
> [   47.663816]  ___slab_alloc+0x3e0/0x4f8
> [   47.667553]  __slab_alloc+0x60/0x80
> [   47.671029]  __kmalloc_node_track_caller+0x10c/0x478
> [   47.675984]  devm_kmalloc+0x44/0xb0
> [   47.679460]  pinctrl_bind_pins+0x4c/0x188
> [   47.683457]  really_probe+0x78/0x2b8
> [   47.687019]  driver_probe_device+0x64/0x110
> [   47.691189]  device_driver_attach+0x74/0x98
> [   47.695360]  __driver_attach+0x9c/0xe8
> [   47.699095]  bus_for_each_dev+0x84/0xd8
> [   47.702919]  driver_attach+0x30/0x40
> [   47.706481]  bus_add_driver+0x170/0x218
> [   47.710304]  driver_register+0x64/0x118
> [   47.714128]  __platform_driver_register+0x54/0x60
> [   47.718820]  arm_smmu_driver_init+0x24/0x2c
> [   47.722991]  do_one_initcall+0xbc/0x328
> [   47.726816]  kernel_init_freeable+0x304/0x3ac
> [   47.731162]  kernel_init+0x18/0x110
> [   47.734638]  ret_from_fork+0x10/0x1c
> [   47.738202] Code: f90013b5 b9410fa1 1a9f0694 b50014c2 (b9400804)
> [   47.744307] ---[ end trace dfeaed4c373a32da ]--
> 
> This could be triggered by firmware bug with bad IORT configuration,
> or a NUMA node has no memory attaching to it, also with NR_CPUS less
> than CPUs presented in MADT.
> 
> Make dev_set_proximity() with a return value, terminating device creation
> if it return failure.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e48894e002ba..1fc1851b078e 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1232,18 +1232,23 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
>  /*
>   * set numa proximity domain for smmuv3 device
>   */
> -static void  __init arm_smmu_v3_set_proximity(struct device *dev,
> +static int  __init arm_smmu_v3_set_proximity(struct device *dev,
>  					      struct acpi_iort_node *node)
>  {
>  	struct acpi_iort_smmu_v3 *smmu;
>  
>  	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>  	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
> -		set_dev_node(dev, acpi_map_pxm_to_node(smmu->pxm));
> +		int node = acpi_map_pxm_to_node(smmu->pxm);
> +		if (node != NUMA_NO_NODE && !node_online(node))
> +			return -EINVAL;
> +
> +		set_dev_node(dev, node);
>  		pr_info("SMMU-v3[%llx] Mapped to Proximity domain %d\n",
>  			smmu->base_address,
>  			smmu->pxm);
>  	}
> +	return 0;
>  }
>  #else
>  #define arm_smmu_v3_set_proximity NULL
> @@ -1318,7 +1323,7 @@ struct iort_dev_config {
>  	int (*dev_count_resources)(struct acpi_iort_node *node);
>  	void (*dev_init_resources)(struct resource *res,
>  				     struct acpi_iort_node *node);
> -	void (*dev_set_proximity)(struct device *dev,
> +	int (*dev_set_proximity)(struct device *dev,
>  				    struct acpi_iort_node *node);
>  };
>  
> @@ -1369,8 +1374,11 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  	if (!pdev)
>  		return -ENOMEM;
>  
> -	if (ops->dev_set_proximity)
> -		ops->dev_set_proximity(&pdev->dev, node);
> +	if (ops->dev_set_proximity) {
> +		ret = ops->dev_set_proximity(&pdev->dev, node);
> +		if (ret)
> +			goto dev_put;
> +	}
>  
>  	count = ops->dev_count_resources(node);
>  
> -- 
> 2.20.1
> 
