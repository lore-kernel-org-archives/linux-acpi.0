Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB14C48BCF
	for <linux-acpi@archiver.kernel.org>; Wed,  9 Jun 2021 13:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466E5613AE
	for <linux-acpi@archiver.kernel.org>; Wed,  9 Jun 2021 13:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhFINC3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:02:29 -0400
Received: from verein.lst.de ([213.95.11.211]:56144 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhFINCZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Jun 2021 09:02:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4FFBF68AFE; Wed,  9 Jun 2021 15:00:26 +0200 (CEST)
Date:   Wed, 9 Jun 2021 15:00:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v6 1/2] ACPI: Move check for _DSD StorageD3Enable
 property to acpi
Message-ID: <20210609130025.GC1837@lst.de>
References: <20210607173156.5548-1-mario.limonciello@amd.com> <20210608053546.GA14116@lst.de> <20210608200101.GB339628@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608200101.GB339628@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 08, 2021 at 01:01:01PM -0700, Keith Busch wrote:
> On Tue, Jun 08, 2021 at 07:35:46AM +0200, Christoph Hellwig wrote:
> > On Mon, Jun 07, 2021 at 12:31:55PM -0500, Mario Limonciello wrote:
> > > +/**
> > > + * acpi_storage_d3 - Check if a storage device should use D3.
> > > + * @dev: Device to check
> > > + *
> > > + * Returns %true if @dev should be put into D3 when the ->suspend method is
> > > + * called, else %false.  The name of this function is somewhat misleading
> > > + * as it has nothing to do with storage except for the name of the ACPI
> > > + * property.  On some platforms resume will not work if this hint is ignored.
> > > + *
> > > + */
> > 
> > I still do not like this comment.  There is nothing about only using this
> > for storage devices.  It is specific to a PCIe slot, and if I plug
> > something that is not a storage device into it the same restrictions
> > still apply.
> 
> Hm, I thought this comment was good. Despite the dupious connection to
> storage, the function name matches the ACPI property, so an explanation
> for this misnomer seems appropriate.

I suggested a comment earlier that explains the connection without being
completely misleading.
