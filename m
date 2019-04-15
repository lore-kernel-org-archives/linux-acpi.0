Return-Path: <SRS0=A1TZ=SR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B25C10F0E
	for <linux-acpi@archiver.kernel.org>; Mon, 15 Apr 2019 18:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9830820818
	for <linux-acpi@archiver.kernel.org>; Mon, 15 Apr 2019 18:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfDOSA3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:00:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40068 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbfDOSA3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Apr 2019 14:00:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58C7B80D;
        Mon, 15 Apr 2019 11:00:28 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5CC23F706;
        Mon, 15 Apr 2019 11:00:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] ACPI/IORT: Check ATS capability in root complex
 nodes
To:     Will Deacon <will.deacon@arm.com>
Cc:     zhongmiao@hisilicon.com, okaya@kernel.org, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        sudeep.holla@arm.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, lenb@kernel.org
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
 <20190409165245.26500-2-jean-philippe.brucker@arm.com>
 <20190415132108.GB15023@fuggles.cambridge.arm.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <ca0bf1eb-dc8f-97b5-6577-f72bdb60e5bd@arm.com>
Date:   Mon, 15 Apr 2019 19:00:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190415132108.GB15023@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190415180004.3wV2I5xu6tagTSor722lsiOhO4vvMFyzftC_4PwrDLQ@z>

On 15/04/2019 14:21, Will Deacon wrote:
> On Tue, Apr 09, 2019 at 05:52:39PM +0100, Jean-Philippe Brucker wrote:
>> Root complex node in IORT has a bit telling whether it supports ATS or
>> not. Store this bit in the IOMMU fwspec when setting up a device, so it
>> can be accessed later by an IOMMU driver.
>>
>> Use the negative version (NO_ATS) at the moment because it's not clear
>> if/how the bit needs to be integrated in other firmware descriptions. The
>> SMMU has a feature bit telling if it supports ATS, which might be
>> sufficient in most systems for deciding whether or not we should enable
>> the ATS capability in endpoints.
> 
> Hmm, the SMMUv3 architecture manual is pretty explicit about this:
> 
>   | It [SMMU_IDR0.ATS] does not guarantee that client devices and intermediate
>   | components also support ATS and this must be determined separately.
> 
> so we may need to extend the PCI bindings to describe this. I think the
> negative logic is likely to get in the way if that's the case.

Right. For devicetree I can resurrect the patch I proposed a while ago
[1]. Rob wasn't keen on adding an "ats-supported" property to PCI host
bridge nodes. Instead the host controller drivers should deduce whether
ATS is supported from the compatible string. But I'll resend that patch
adding the property only to pci-host-ecam-generic.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2017-May/022043.html

>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>>  drivers/acpi/arm64/iort.c | 11 +++++++++++
>>  include/linux/iommu.h     |  4 ++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index e48894e002ba..7f2c1c9c6b38 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -1028,6 +1028,14 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>  	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
>>  }
>>  
>> +static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
>> +{
>> +	struct acpi_iort_root_complex *pci_rc;
>> +
>> +	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
>> +	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
>> +}
> 
> Do we need to worry about the "noats" command-line option here? It feels
> like we should be checking with the PCI subsystem before telling the SMMU
> we're good to go.

I'm checking the noats option in arm_smmu_enable_ats() at the moment,
using the pci_ats_disabled() helper.

Thanks,
Jean
