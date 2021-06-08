Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC7C47082
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Jun 2021 20:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CD36024A
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Jun 2021 20:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhFHUDE (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 8 Jun 2021 16:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233933AbhFHUDC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 16:03:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5943361375;
        Tue,  8 Jun 2021 20:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623182464;
        bh=F2Y55vEIvmldRRvnuJh//gyZ7g+GCfz2XlFDoM/UTpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8U9MCxcaCa/qPwqeDahooVTEXTjWTkNUiKl1E+J45jVnXVBJPI/Tp166PNQhFLs1
         3STrTaJVFjLj6aO7aL/zMjcAwYpWZKs4g3j6T33AC4NkhFMDGAJbwlGyDiVsSB7g6t
         0FPcmOMt7RMexMjNHnqDD6w5o8g2c4F+Qon2JQ/udWC9sNqErLwQKAxaxyBbaxBj3M
         0g6MLp4tweY3Kcbxwq8zOJA80qU1CHnM8Kic55g4Qpy/81/uH8DngQteapAbGEw7bp
         LSXrbHqIOsmeIqA64fRseYyLIk01XzMA2tJGs3WEMPIImKmT8ivETOKfeb/+k9Q1Id
         HEqvScXEmMnUQ==
Date:   Tue, 8 Jun 2021 13:01:01 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
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
Message-ID: <20210608200101.GB339628@dhcp-10-100-145-180.wdc.com>
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210608053546.GA14116@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608053546.GA14116@lst.de>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 08, 2021 at 07:35:46AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 07, 2021 at 12:31:55PM -0500, Mario Limonciello wrote:
> > +/**
> > + * acpi_storage_d3 - Check if a storage device should use D3.
> > + * @dev: Device to check
> > + *
> > + * Returns %true if @dev should be put into D3 when the ->suspend method is
> > + * called, else %false.  The name of this function is somewhat misleading
> > + * as it has nothing to do with storage except for the name of the ACPI
> > + * property.  On some platforms resume will not work if this hint is ignored.
> > + *
> > + */
> 
> I still do not like this comment.  There is nothing about only using this
> for storage devices.  It is specific to a PCIe slot, and if I plug
> something that is not a storage device into it the same restrictions
> still apply.

Hm, I thought this comment was good. Despite the dupious connection to
storage, the function name matches the ACPI property, so an explanation
for this misnomer seems appropriate.
