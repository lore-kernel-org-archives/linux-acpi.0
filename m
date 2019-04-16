Return-Path: <SRS0=f16E=SS=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7BC10F13
	for <linux-acpi@archiver.kernel.org>; Tue, 16 Apr 2019 17:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1721920872
	for <linux-acpi@archiver.kernel.org>; Tue, 16 Apr 2019 17:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfDPRFl (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:05:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59900 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfDPRFl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Apr 2019 13:05:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D483C80D;
        Tue, 16 Apr 2019 10:05:38 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E1893F59C;
        Tue, 16 Apr 2019 10:05:37 -0700 (PDT)
Date:   Tue, 16 Apr 2019 18:05:35 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] ACPI/IORT: Reject platform device creation on NUMA
 node mapping failure
Message-ID: <20190416170535.GB7342@fuggles.cambridge.arm.com>
References: <20190408104658.GB2727@red-moon>
 <20190408152112.42056-1-wangkefeng.wang@huawei.com>
 <20190416170220.GF14705@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190416170220.GF14705@red-moon>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190416170535.MEVv-PkdJS6GAxD-rFrvWWH90xm4lIv63Yh0lyx1IZc@z>

On Tue, Apr 16, 2019 at 06:02:20PM +0100, Lorenzo Pieralisi wrote:
> [+Will]
> 
> there is not enough material for an IORT pull request this cycle but
> this patch should be merged and IORT code goes usually via arm64, can
> you pick it up or if you prefer I can resend it on LAKML and CC you in
> if it makes it any simpler ?
> 
> On Mon, Apr 08, 2019 at 11:21:12PM +0800, Kefeng Wang wrote:
> > In a system where, through IORT firmware mappings, the SMMU device is
> > mapped to a NUMA node that is not online, the kernel bootstrap results
> > in the following crash:

Queued for 5.2. Thanks for the heads-up.

Will
