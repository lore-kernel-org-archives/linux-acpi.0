Return-Path: <SRS0=Cl+M=TP=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8848AC04E53
	for <linux-acpi@archiver.kernel.org>; Wed, 15 May 2019 10:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0842084A
	for <linux-acpi@archiver.kernel.org>; Wed, 15 May 2019 10:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEOKPj (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 15 May 2019 06:15:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40086 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfEOKPi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 May 2019 06:15:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE6F80D;
        Wed, 15 May 2019 03:15:38 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 014BD3F703;
        Wed, 15 May 2019 03:15:36 -0700 (PDT)
Date:   Wed, 15 May 2019 11:15:34 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        guohanjun@huawei.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH RESEND] ACPI/IORT: Fix build error when IOMMU_SUPPORT
 disabled
Message-ID: <20190515101534.GF24357@fuggles.cambridge.arm.com>
References: <20190515033406.79020-1-wangkefeng.wang@huawei.com>
 <20190515034253.79348-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515034253.79348-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 15, 2019 at 11:42:53AM +0800, Kefeng Wang wrote:
> drivers/acpi/arm64/iort.c: In function iort_iommu_configure:
> drivers/acpi/arm64/iort.c:1079:21: error: struct iommu_fwspec has no member named flags
>     dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>                      ^~
> drivers/acpi/arm64/iort.c:1079:32: error: IOMMU_FWSPEC_PCI_RC_ATS
> undeclared (first use in this function)
>     dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>                                 ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/arm64/iort.c:1079:32: note: each undeclared identifier is reported only once for each function it appears in
> 
> If IOMMU_SUPPORT not enabled, struct iommu_fwspec without members and
> IOMMU_FWSPEC_PCI_RC_ATS not defined, add new iommu_fwspec_set_ats_flags()
> to set IOMMU_FWSPEC_PCI_RC_ATS flags to solve build error.
> 
> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>

What's this "Hulk Robot"? Does it report things publicly?

Anyway, I can pick this up if Lorenzo acks it.

Will
