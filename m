Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A639ECAAD5
	for <linux-acpi@archiver.kernel.org>; Fri,  2 Sep 2022 18:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiIBSQM (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIBSQL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Sep 2022 14:16:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3243E42D1;
        Fri,  2 Sep 2022 11:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9998FB82D01;
        Fri,  2 Sep 2022 18:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67757C433C1;
        Fri,  2 Sep 2022 18:16:04 +0000 (UTC)
Date:   Fri, 2 Sep 2022 19:16:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, jean-philippe@linaro.org,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, tglx@linutronix.de, maz@kernel.org,
        alex.williamson@redhat.com, cohuck@redhat.com,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu/dma: Move public interfaces to linux/iommu.h
Message-ID: <YxJIYD8gjP7yAXb2@arm.com>
References: <cover.1660668998.git.robin.murphy@arm.com>
 <9cd99738f52094e6bed44bfee03fa4f288d20695.1660668998.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd99738f52094e6bed44bfee03fa4f288d20695.1660668998.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 16, 2022 at 06:28:04PM +0100, Robin Murphy wrote:
> The iommu-dma layer is now mostly encapsulated by iommu_dma_ops, with
> only a couple more public interfaces left pertaining to MSI integration.
> Since these depend on the main IOMMU API header anyway, move their
> declarations there, taking the opportunity to update the half-baked
> comments to proper kerneldoc along the way.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Note that iommu_setup_dma_ops() should also become internal in a future
> phase of the great IOMMU API upheaval - for now as the last bit of true
> arch code glue I consider it more "necessarily exposed" than "public".
> 
>  arch/arm64/mm/dma-mapping.c       |  2 +-

And here:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
