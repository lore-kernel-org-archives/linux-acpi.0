Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C54C433F5
	for <linux-acpi@archiver.kernel.org>; Mon,  6 Sep 2021 17:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038EA60F92
	for <linux-acpi@archiver.kernel.org>; Mon,  6 Sep 2021 17:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbhIFRpU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:45:20 -0400
Received: from foss.arm.com ([217.140.110.172]:57556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243962AbhIFRpT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Sep 2021 13:45:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95576D;
        Mon,  6 Sep 2021 10:44:13 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 811733F766;
        Mon,  6 Sep 2021 10:44:11 -0700 (PDT)
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        jon@solid-run.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        joro@8bytes.org, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, steven.price@arm.com, Sami.Mujawar@arm.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
Date:   Mon, 6 Sep 2021 18:44:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210805160319.GB23085@lpieralisi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-08-05 17:03, Lorenzo Pieralisi wrote:
> On Thu, Aug 05, 2021 at 09:07:17AM +0100, Shameer Kolothum wrote:
> 
> [...]
> 
>> +static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
>> +{
>> +	struct acpi_iort_node *smmu;
>> +	struct acpi_iort_rmr *rmr;
>> +	struct acpi_iort_rmr_desc *rmr_desc;
>> +	u32 map_count = iort_node->mapping_count;
>> +	u32 sid;
>> +	int i;
>> +
>> +	if (!iort_node->mapping_offset || map_count != 1) {
>> +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
>> +		       iort_node);
>> +		return;
>> +	}
>> +
>> +	/* Retrieve associated smmu and stream id */
>> +	smmu = iort_node_get_id(iort_node, &sid, 0);
>> +	if (!smmu) {
>> +		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
>> +		       iort_node);
>> +		return;
>> +	}
>> +
>> +	/* Retrieve RMR data */
>> +	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
>> +	if (!rmr->rmr_offset || !rmr->rmr_count) {
>> +		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
>> +		       iort_node);
>> +		return;
>> +	}
>> +
>> +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
>> +				rmr->rmr_offset);
>> +
>> +	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
>> +
>> +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
>> +		struct iommu_resv_region *region;
>> +		enum iommu_resv_type type;
>> +		int prot = IOMMU_READ | IOMMU_WRITE;
>> +		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
>> +
>> +		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
>> +			/* PAGE align base addr and size */
>> +			addr &= PAGE_MASK;
>> +			size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
>> +
>> +			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
>> +			       rmr_desc->base_address,
>> +			       rmr_desc->base_address + rmr_desc->length - 1,
>> +			       addr, addr + size - 1);
>> +		}
>> +		if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
>> +			type = IOMMU_RESV_DIRECT_RELAXABLE;
>> +			/*
>> +			 * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
>> +			 * normally used for allocated system memory that is
>> +			 * then used for device specific reserved regions.
>> +			 */
>> +			prot |= IOMMU_CACHE;
>> +		} else {
>> +			type = IOMMU_RESV_DIRECT;
>> +			/*
>> +			 * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
>> +			 * for device memory like MSI doorbell.
>> +			 */
>> +			prot |= IOMMU_MMIO;
>> +		}
> 
> On the prot value assignment based on the remapping flag, I'd like to
> hear Robin/Joerg's opinion, I'd avoid being in a situation where
> "normally" this would work but then we have to quirk it.
> 
> Is this a valid assumption _always_ ?

No. Certainly applying IOMMU_CACHE without reference to the device's 
_CCA attribute or how CPUs may be accessing a shared buffer could lead 
to a loss of coherency. At worst, applying IOMMU_MMIO to a 
device-private buffer *could* cause the device to lose coherency with 
itself if the memory underlying the RMR may have allocated into system 
caches. Note that the expected use for non-remappable RMRs is the device 
holding some sort of long-lived private data in system RAM - the MSI 
doorbell trick is far more of a niche hack really.

At the very least I think we need to refer to the device's memory access 
properties here.

Jon, Laurentiu - how do RMRs correspond to the EFI memory map on your 
firmware? I'm starting to think that as long as the underlying memory is 
described appropriately there then we should be able to infer correct 
attributes from the EFI memory type and flags.

Robin.
