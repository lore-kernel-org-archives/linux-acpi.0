From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 4/4] ACPI: IORT: Add SMMUv3 MSI support
Date: Tue, 12 Sep 2017 16:51:43 +0100
Message-ID: <20170912155143.GA29684@red-moon>
References: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
 <1502276017-63108-5-git-send-email-guohanjun@huawei.com>
 <20170811093348.GC26039@red-moon>
 <CAGHbJ3AgEvbpsPdeqJ+bFWa5hBMqxBX6g1eC4HiUvHarJf8H+g@mail.gmail.com>
 <20170815171525.GB13707@e107981-lin.cambridge.arm.com>
 <de1b88e0-57d5-b73b-bc49-3c28070df6b1@linaro.org>
 <20170817130139.GA17795@red-moon>
 <96c8b5d8-eff2-6583-04da-cb3fdab8e6cb@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42524 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbdILPtW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Sep 2017 11:49:22 -0400
Content-Disposition: inline
In-Reply-To: <96c8b5d8-eff2-6583-04da-cb3fdab8e6cb@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linuxarm <linuxarm@huawei.com>, Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>

On Tue, Sep 12, 2017 at 11:27:13AM +0800, Hanjun Guo wrote:
> Hi Lorenzo,
> 
> On 2017/8/17 21:01, Lorenzo Pieralisi wrote:
> >On Thu, Aug 17, 2017 at 03:49:37PM +0800, Hanjun Guo wrote:
> >
> >[...]
> >
> >>>  /**
> >>>   * iort_get_platform_device_domain() - Find MSI domain related to a
> >>>   * platform device
> >>>@@ -1159,6 +1207,8 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
> >>>  	/* Configure DMA for the page table walker */
> >>>  	acpi_dma_configure(&pdev->dev, attr);
> >>>+	iort_set_device_domain(&pdev->dev, node);
> >>
> >>This is fine to me, but I think we still need to retrieve
> >>the output ID as the request id for ITS, which means we
> >>need to do that in iort_pmsi_get_dev_id(), right?
> >
> >Yes, probably we can add code there like:
> >
> >ret = iort_get_id_mapping_index(&index);
> >if (!ret)
> >	iort_node_get_id(node, &id, index);
> >	...
> >
> >This requires updating iort_node_get_id() to allow single mappings
> >for SMMU/PMCG as you flagged up before.
> >
> >I will think a bit more to see if there is a cleaner way to reshuffle
> >the mapping API.
> 
> I would like to send a updated version after the merge window to gather
> more comments, and at the same time we can work on the cleaner way to
> reshuffle the mapping API, what do you thing?

I think you should send an updated patch at -rc1 with comments above, we
can rework the API later or I can do it on top of your patches for the
upcoming merge window.

Thanks !
Lorenzo
