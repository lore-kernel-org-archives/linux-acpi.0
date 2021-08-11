Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20689C4320A
	for <linux-acpi@archiver.kernel.org>; Wed, 11 Aug 2021 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A6360FE6
	for <linux-acpi@archiver.kernel.org>; Wed, 11 Aug 2021 14:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhHKOzk (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 11 Aug 2021 10:55:40 -0400
Received: from foss.arm.com ([217.140.110.172]:52452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232597AbhHKOzj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Aug 2021 10:55:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12CD1063;
        Wed, 11 Aug 2021 07:55:15 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3901A3F718;
        Wed, 11 Aug 2021 07:55:14 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:55:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 1/3] ACPI: osl: Add __force attribute in
 acpi_os_map_iomem() cast
Message-ID: <20210811145508.GA3650@lpieralisi>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-2-lorenzo.pieralisi@arm.com>
 <YRKtEDycefrZLB3X@infradead.org>
 <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
 <YRPZ2Kqb/MFggHzQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRPZ2Kqb/MFggHzQ@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 11, 2021 at 03:08:24PM +0100, Christoph Hellwig wrote:
> On Wed, Aug 11, 2021 at 12:40:28PM +0200, Ard Biesheuvel wrote:
> > The whole problem we are solving here is that ACPI, being based on
> > x86, conflates MMIO mappings with memory mappings, and has been using
> > the same underlying infrastructure for either.
> 
> So let's fix that problem instead of papering over it.

Patch (3) in this series is a fix - I would ask whether it makes
sense to merge patches (2-3) now and think about reworking the current
ACPI IO/MEM mapping API later, it can be an invasive change for a fix,
assuming we agree on how to rework the ACPI IO/MEM mapping API.

Lorenzo
