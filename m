Return-Path: <SRS0=A1TZ=SR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E220AC10F0E
	for <linux-acpi@archiver.kernel.org>; Mon, 15 Apr 2019 13:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2EB206BA
	for <linux-acpi@archiver.kernel.org>; Mon, 15 Apr 2019 13:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfDONVC (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:21:02 -0400
Received: from foss.arm.com ([217.140.101.70]:34788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfDONVB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Apr 2019 09:21:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E884374;
        Mon, 15 Apr 2019 06:21:01 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 323933F68F;
        Mon, 15 Apr 2019 06:20:59 -0700 (PDT)
Date:   Mon, 15 Apr 2019 14:20:54 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, okaya@kernel.org, zhongmiao@hisilicon.com,
        eric.auger@redhat.com
Subject: Re: [PATCH v2 0/7] Add PCI ATS support to Arm SMMUv3
Message-ID: <20190415132054.GA15023@fuggles.cambridge.arm.com>
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190415132054.L_zdNXqo9H7iVCkSGbRz-I03SxDOVBYJTfq0clYE2iQ@z>

Hi Jean-Philippe,

On Tue, Apr 09, 2019 at 05:52:38PM +0100, Jean-Philippe Brucker wrote:
> This series enables PCI ATS in SMMUv3. Changes since v1 [1]:
> 
> * Simplify the SMMU structures (patches 2-4 are new).
> 
> * Don't enable ATS for devices that are attached to a bypass domain,
>   because in that case a translation request would cause F_BAD_ATS_TREQ.
>   Translation requests in that case cause F_BAD_ATS_TREQ. Enable ATS in
>   attach_dev() rather than add_device().
> 
> * Enable ATS for stage-1 and stage-2 STEs alike. There is no benefit to
>   disabling ATS for stage-2 domains.
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg714628.html
> 
> Jean-Philippe Brucker (7):
>   ACPI/IORT: Check ATS capability in root complex nodes
>   iommu/arm-smmu-v3: Rename arm_smmu_master_data to arm_smmu_master
>   iommu/arm-smmu-v3: Store SteamIDs in master
>   iommu/arm-smmu-v3: Add a master->domain pointer
>   iommu/arm-smmu-v3: Link domains and devices
>   iommu/arm-smmu-v3: Add support for PCI ATS
>   iommu/arm-smmu-v3: Disable tagged pointers

Patches 2, 3, 4, 5 and 7 look fine to me. I've left some comments on the
other two.

Cheers,

Will
