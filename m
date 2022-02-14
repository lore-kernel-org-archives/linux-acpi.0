Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E7CC433EF
	for <linux-acpi@archiver.kernel.org>; Mon, 14 Feb 2022 12:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiBNMJR (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 14 Feb 2022 07:09:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiBNMJR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Feb 2022 07:09:17 -0500
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 04:09:09 PST
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B2E4889C;
        Mon, 14 Feb 2022 04:09:09 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 23FD82FB; Mon, 14 Feb 2022 13:00:10 +0100 (CET)
Date:   Mon, 14 Feb 2022 13:00:09 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] IOMMU: Intel: DMAR: Replace acpi_bus_get_device()
Message-ID: <YgpESSz6XaVcYnaQ@8bytes.org>
References: <1807113.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1807113.tdWV9SEqCh@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 01, 2022 at 07:11:40PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/iommu/intel/dmar.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied with adjusted subject, thanks Rafael.

