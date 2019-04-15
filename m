Return-Path: <SRS0=A1TZ=SR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87531C10F0E
	for <linux-acpi@archiver.kernel.org>; Mon, 15 Apr 2019 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD1720854
	for <linux-acpi@archiver.kernel.org>; Mon, 15 Apr 2019 18:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfDOSbX (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:31:23 -0400
Received: from foss.arm.com ([217.140.101.70]:40484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfDOSbX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Apr 2019 14:31:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7FAE80D;
        Mon, 15 Apr 2019 11:31:22 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC9023F706;
        Mon, 15 Apr 2019 11:31:20 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] ACPI/IORT: Check ATS capability in root complex
 nodes
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        will.deacon@arm.com
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        joro@8bytes.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        okaya@kernel.org, zhongmiao@hisilicon.com, eric.auger@redhat.com
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
 <20190409165245.26500-2-jean-philippe.brucker@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c10c7adb-c7f6-f8c6-05cc-f4f143427a2d@arm.com>
Date:   Mon, 15 Apr 2019 19:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409165245.26500-2-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190415183118.L9ef_BVa9eCiIjbUnEC4OY3CA_x7J4cWz1yKePnu98o@z>

On 09/04/2019 17:52, Jean-Philippe Brucker wrote:
> Root complex node in IORT has a bit telling whether it supports ATS or
> not. Store this bit in the IOMMU fwspec when setting up a device, so it
> can be accessed later by an IOMMU driver.

Hmm, it doesn't feel quite right to store a copy of the same RC/SMMU 
integration property for every endpoint...

It seems like it might be more logical to track this at the SMMU end, 
i.e. only allow ARM_SMMU_FEAT_ATS to be set if all RCs targeting that 
SMMU also support ATS. For the moment that seems sufficiently realistic, 
and unless some wacky topology ever actually shows up in silicon to 
complain, I'm inclined not to care too much about it being potentially 
overly restrictive.

Furthermore, I'm now wondering whether it would make sense to push this 
into the PCI layer as well (or instead), i.e. hook into pci_init_ats() 
or pci_enable_ats() and it the device is untrusted or the topology 
doesn't support ATS, prevent the capability from ever being enabled at 
all, rather than trying to mitigate it later at the SMMU end. What do 
you reckon?

> Use the negative version (NO_ATS) at the moment because it's not clear
> if/how the bit needs to be integrated in other firmware descriptions. The
> SMMU has a feature bit telling if it supports ATS, which might be
> sufficient in most systems for deciding whether or not we should enable
> the ATS capability in endpoints.

I can fairly confidently guarantee that it won't. For instance, MMU-600 
reports IDR0.ATS==1 because MMU-600 implements the SMMUv3 architectural 
ATS support. Actually making use of that support, though, still requires 
an RC capable of generating the appropriate DTI-ATS messages, and that a 
DTI interface is wired up correctly between the two.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>   drivers/acpi/arm64/iort.c | 11 +++++++++++
>   include/linux/iommu.h     |  4 ++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e48894e002ba..7f2c1c9c6b38 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1028,6 +1028,14 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>   	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
>   }
>   
> +static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_root_complex *pci_rc;
> +
> +	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
> +	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
> +}
> +
>   /**
>    * iort_iommu_configure - Set-up IOMMU configuration for a device.
>    *
> @@ -1063,6 +1071,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>   		info.node = node;
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>   					     iort_pci_iommu_init, &info);
> +
> +		if (!err && !iort_pci_rc_supports_ats(node))
> +			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_NO_ATS;
>   	} else {
>   		int i = 0;
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3dbeb457fb16..ed6738c358ca 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -509,10 +509,14 @@ struct iommu_fwspec {
>   	const struct iommu_ops	*ops;
>   	struct fwnode_handle	*iommu_fwnode;
>   	void			*iommu_priv;
> +	u32			flags;
>   	unsigned int		num_ids;
>   	u32			ids[1];
>   };
>   
> +/* Firmware disabled ATS in the root complex */

More likely firmware is just describing how the hardware was built ;)

Robin.

> +#define IOMMU_FWSPEC_PCI_NO_ATS			(1 << 0)
> +
>   int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>   		      const struct iommu_ops *ops);
>   void iommu_fwspec_free(struct device *dev);
> 
