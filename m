Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C5DC433F5
	for <linux-acpi@archiver.kernel.org>; Fri,  1 Apr 2022 11:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiDAL2y (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 1 Apr 2022 07:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiDAL2u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Apr 2022 07:28:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5727547C;
        Fri,  1 Apr 2022 04:26:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A682E67373; Fri,  1 Apr 2022 13:26:49 +0200 (CEST)
Date:   Fri, 1 Apr 2022 13:26:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: Bug 215742 - The NVME storage quirked as SIMPLE SUSPEND makes
 system resume failed after suspend (Regression)
Message-ID: <20220401112649.GA14810@lst.de>
References: <edba451c-1798-c60e-5d84-0a9f6a5d134d@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edba451c-1798-c60e-5d84-0a9f6a5d134d@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 01, 2022 at 09:55:14AM +0200, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all people that seemed to be relevant
> here. Mario, could you maybe take a look at this? Or is that something
> for the NVM or ACPI people? Or was this discussed somewhere else
> already? Or even fixed?

I've not seenthe report.  Looks like the BIOS sets the StorageD3 flag
in the ACPI tables in this system but doesn't actually want it,
which is really strange.  We could add some kind of quirk based on
DMI matching, but this all seems weird.
