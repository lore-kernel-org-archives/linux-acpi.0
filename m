Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC71C28D13
	for <linux-acpi@archiver.kernel.org>; Mon, 22 Aug 2022 11:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiHVLVU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 22 Aug 2022 07:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiHVLVR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Aug 2022 07:21:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B281F63E;
        Mon, 22 Aug 2022 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ktMzlSFdVQYUGp03litM44l4Gx4FNd+6ZShF2nft75g=; b=ljTOP2NOOOEPk/1TF0QWa2ajJK
        KqVDEbmCr3KQ/zmtQkDGm+QLYYN700ufnjfEvy1vtpoJ4aVO/lgj72RIHglIaG925iWDmeOjw3dKV
        czsJEaLgSURBV5wXu11GNsq/cyf4fehp4tVZce8bAqBR2CAwf6z35O0JglOYWn5R/jhd5UDHOoHgb
        Y2cfZz3F+KsGqv4Q4FR7ewbMpiTTX0ulhL4skI3GErKOcf0l/8usRywD9U9tl7oQsoQoAtvEPS+W6
        GeeraySviOpmiP/U4zpRidJB9qXKKrL/8KB2RW1gBml8txR18tMwhdxARX18wedHD0OKaP1CQVC0A
        BSGHMG1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ5UQ-0087Er-3k; Mon, 22 Aug 2022 11:21:06 +0000
Date:   Mon, 22 Aug 2022 04:21:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, catalin.marinas@arm.com,
        jean-philippe@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        tglx@linutronix.de, maz@kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu/dma: Move public interfaces to linux/iommu.h
Message-ID: <YwNmosMGZdGtY3LX@infradead.org>
References: <cover.1660668998.git.robin.murphy@arm.com>
 <9cd99738f52094e6bed44bfee03fa4f288d20695.1660668998.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd99738f52094e6bed44bfee03fa4f288d20695.1660668998.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 70393fbb57ed..79cb6eb560a8 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1059,4 +1059,40 @@ void iommu_debugfs_setup(void);
>  static inline void iommu_debugfs_setup(void) {}
>  #endif
>  
> +#ifdef CONFIG_IOMMU_DMA
> +#include <linux/msi.h>

I don't think msi.h is actually needed here.

Just make the struct msi_desc and struct msi_msg forward declarations
unconditional and we should be fine.
