Return-Path: <SRS0=Uq2U=YA=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF89ECE58C
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Oct 2019 15:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AB421721
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Oct 2019 15:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfJGP2v (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:28:51 -0400
Received: from 8bytes.org ([81.169.241.247]:57602 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfJGP2v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Oct 2019 11:28:51 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2502336D; Mon,  7 Oct 2019 17:28:50 +0200 (CEST)
Date:   Mon, 7 Oct 2019 17:28:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Message-ID: <20191007152848.GA20456@8bytes.org>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
 <20190924193739.86133-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924193739.86133-7-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 24, 2019 at 10:37:39PM +0300, Andy Shevchenko wrote:
> Since we have a generic helper, drop custom implementation in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iommu/amd_iommu.c | 30 +++++-------------------------
>  1 file changed, 5 insertions(+), 25 deletions(-)

Acked-by: Joerg Roedel <jroedel@suse.de>
