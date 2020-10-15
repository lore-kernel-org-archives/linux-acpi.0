Return-Path: <SRS0=fmxS=DW=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88938C433DF
	for <linux-acpi@archiver.kernel.org>; Thu, 15 Oct 2020 10:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384DF22250
	for <linux-acpi@archiver.kernel.org>; Thu, 15 Oct 2020 10:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbgJOKbO (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:31:14 -0400
Received: from foss.arm.com ([217.140.110.172]:56618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731151AbgJOKbO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Oct 2020 06:31:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08B94D6E;
        Thu, 15 Oct 2020 03:31:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF34F3F66B;
        Thu, 15 Oct 2020 03:31:11 -0700 (PDT)
Date:   Thu, 15 Oct 2020 11:31:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
Message-ID: <20201015103106.GA24739@e121166-lin.cambridge.arm.com>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014191211.27029-8-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 14, 2020 at 09:12:09PM +0200, Nicolas Saenz Julienne wrote:

[...]

> +unsigned int __init acpi_iort_get_zone_dma_size(void)
> +{
> +	struct acpi_table_iort *iort;
> +	struct acpi_iort_node *node, *end;
> +	acpi_status status;
> +	u8 limit = 32;
> +	int i;
> +
> +	if (acpi_disabled)
> +		return limit;
> +
> +	status = acpi_get_table(ACPI_SIG_IORT, 0,
> +				(struct acpi_table_header **)&iort);
> +	if (ACPI_FAILURE(status))
> +		return limit;
> +
> +	node = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->node_offset);
> +	end = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->header.length);
> +
> +	for (i = 0; i < iort->node_count; i++) {
> +		if (node >= end)
> +			break;
> +
> +		switch (node->type) {
> +			struct acpi_iort_named_component *ncomp;
> +			struct acpi_iort_root_complex *rc;
> +
> +		case ACPI_IORT_NODE_NAMED_COMPONENT:
> +			ncomp = (struct acpi_iort_named_component *)node->node_data;
> +			if (ncomp->memory_address_limit)
> +				limit = min(limit, ncomp->memory_address_limit);
> +			break;
> +
> +		case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> +			rc = (struct acpi_iort_root_complex *)node->node_data;
> +			if (rc->memory_address_limit)

You need to add a node revision check here, see rc_dma_get_range() in
drivers/acpi/arm64/iort.c, otherwise we may be reading junk data
in older IORT tables - acpica structures are always referring to the
latest specs.

Thanks,
Lorenzo

> +				limit = min(limit, rc->memory_address_limit);
> +			break;
> +		}
> +		node = ACPI_ADD_PTR(struct acpi_iort_node, node, node->length);
> +	}
> +	acpi_put_table(&iort->header);
> +	return limit;
> +}
> +#endif
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 20a32120bb88..7d2e184f0d4d 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -38,6 +38,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
>  const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  						const u32 *id_in);
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
> +unsigned int acpi_iort_get_zone_dma_size(void);
>  #else
>  static inline void acpi_iort_init(void) { }
>  static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -55,6 +56,9 @@ static inline const struct iommu_ops *iort_iommu_configure_id(
>  static inline
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  { return 0; }
> +
> +static inline unsigned int acpi_iort_get_zone_dma_size(void)
> +{ return 32; }
>  #endif
>  
>  #endif /* __ACPI_IORT_H__ */
> -- 
> 2.28.0
> 
