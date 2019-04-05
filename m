Return-Path: <SRS0=kPaS=SH=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87374C282CE
	for <linux-acpi@archiver.kernel.org>; Fri,  5 Apr 2019 18:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594162146F
	for <linux-acpi@archiver.kernel.org>; Fri,  5 Apr 2019 18:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfDESIT (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:08:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54020 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfDESIT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Apr 2019 14:08:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B73E0168F;
        Fri,  5 Apr 2019 11:08:18 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E50FD3F557;
        Fri,  5 Apr 2019 11:08:16 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 2/4] iommu/arm-smmu-v3: Link domains and devices
To:     Will Deacon <will.deacon@arm.com>
Cc:     "eric.auger@redhat.com" <eric.auger@redhat.com>,
        zhongmiao@hisilicon.com, okaya@kernel.org, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        sudeep.holla@arm.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, lenb@kernel.org
References: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
 <20190320173634.21895-3-jean-philippe.brucker@arm.com>
 <20190404143924.GB27823@fuggles.cambridge.arm.com>
 <312d33a5-8eca-3fae-fd8b-8325e045761b@arm.com>
 <20190405163949.GA19828@fuggles.cambridge.arm.com>
Message-ID: <b21e1dc0-c0c8-6c48-fd3f-cd6c9653434b@arm.com>
Date:   Fri, 5 Apr 2019 19:07:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190405163949.GA19828@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190405180756.-ikKypjvTWsX6HJ6yPNi7kOF2OHFx0MWOFSleP_P7DU@z>

On 05/04/2019 17:39, Will Deacon wrote:
>>> I'm wondering whether we can't take this a bit further and re-organise the
>>> data structures to make this a little simpler overall. Something along the
>>> lines of:
>>>
>>> 	struct arm_smmu_master_data {
>>> 		struct list_head		list; // masters in the same domain
>>> 		struct arm_smmu_device		*smmu;
>>> 		unsigned int			num_sids;
>>> 		u32				*sids; // Points into fwspec
>>> 		struct arm_smmu_domain		*domain; // NULL -> !assigned
>>> 	};
>>>
>>> and then just add a list_head into struct arm_smmu_domain to track the
>>> masters that have been attached (if you're feeling brave, you could put
>>> this into the s1_cfg).
>>
>> I'm not sure about that last bit, shouldn't the list of masters apply to
>> both s1 and s2?
> 
> I was assuming that (a) we were only using ATS with stage-1 and (b) we only
> need the masters list for ATC invalidation. Did I go wrong somewhere?

Hmm, I messed that up in patch 3, actually. I'm still unsure about it,
but in the end I was meaning to enable ATS for both stage-1 and stage-2
domains. We could make it stage-1 only, but VFIO can assign a device
with a stage-1 domain to userspace. That's the case with QEMU, which
doesn't use VFIO_TYPE1_NESTING_IOMMU at the moment. So I don't think
limiting ATS to stage-1 protects against anything.


For (b), the master list will likely also be used for PASID support, to
invalidate cached CDs for each device in a domain, but that's only stage-1.

Then the current patchsets for nested translation also rely on the
master list to bind guest PASID tables to all devices attached
to a domain. But with those patches, s1_cfg and s2_cfg aren't in an enum
anymore and we could still keep the list in s1_cfg.

Thanks,
Jean
