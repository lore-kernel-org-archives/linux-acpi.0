Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D71BC07E94
	for <linux-acpi@archiver.kernel.org>; Fri,  4 Jun 2021 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E150F61405
	for <linux-acpi@archiver.kernel.org>; Fri,  4 Jun 2021 15:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFDPX5 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 4 Jun 2021 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFDPX5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2021 11:23:57 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DEAC061766
        for <linux-acpi@vger.kernel.org>; Fri,  4 Jun 2021 08:22:10 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 983AC3A9; Fri,  4 Jun 2021 17:22:08 +0200 (CEST)
Date:   Fri, 4 Jun 2021 17:22:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, rjw@rjwysocki.net,
        lenb@kernel.org, mst@redhat.com, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, will@kernel.org,
        catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v3 2/6] ACPI: Move IOMMU setup code out of IORT
Message-ID: <YLpFHwGPuWsB3AgV@8bytes.org>
References: <20210602154444.1077006-3-jean-philippe@linaro.org>
 <202106030417.97asL7dA-lkp@intel.com>
 <YLiELyo+KLuYqA24@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLiELyo+KLuYqA24@myrica>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 03, 2021 at 09:26:39AM +0200, Jean-Philippe Brucker wrote:
> These are only defined when CONFIG_IOMMU_API is set. IORT uses them inside
> an #ifdef, I can do the same. Maybe moving these two functions to a new
> drivers/acpi/iommu.c would be nicer, though.

Not sure what the ACPI maintainers and reviewers prefer, but I would
just #ifdef the functions and provide stubs in the #else path if
necessary.

Regards,

	Joerg
