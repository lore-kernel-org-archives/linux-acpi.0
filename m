Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F8DC6FA82
	for <linux-acpi@archiver.kernel.org>; Fri,  2 Sep 2022 18:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIBSP1 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiIBSP1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Sep 2022 14:15:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158452A439;
        Fri,  2 Sep 2022 11:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B004A6222B;
        Fri,  2 Sep 2022 18:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B8EC433C1;
        Fri,  2 Sep 2022 18:15:21 +0000 (UTC)
Date:   Fri, 2 Sep 2022 19:15:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, jean-philippe@linaro.org,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, tglx@linutronix.de, maz@kernel.org,
        alex.williamson@redhat.com, cohuck@redhat.com,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/3] iommu/dma: Clean up Kconfig
Message-ID: <YxJINWLzESn/Rwhp@arm.com>
References: <cover.1660668998.git.robin.murphy@arm.com>
 <2e33c8bc2b1bb478157b7964bfed976cb7466139.1660668998.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e33c8bc2b1bb478157b7964bfed976cb7466139.1660668998.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 16, 2022 at 06:28:03PM +0100, Robin Murphy wrote:
> Although iommu-dma is a per-architecture chonce, that is currently
> implemented in a rather haphazard way. Selecting from the arch Kconfig
> was the original logical approach, but is complicated by having to
> manage dependencies; conversely, selecting from drivers ends up hiding
> the architecture dependency *too* well. Instead, let's just have it
> enable itself automatically when IOMMU API support is enabled for the
> relevant architectures. It can't get much clearer than that.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/Kconfig          | 1 -

For this change:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
