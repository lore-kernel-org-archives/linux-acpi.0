Return-Path: <SRS0=TUQs=UT=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689ACC43613
	for <linux-acpi@archiver.kernel.org>; Thu, 20 Jun 2019 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8A82083B
	for <linux-acpi@archiver.kernel.org>; Thu, 20 Jun 2019 09:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfFTJtl (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:49:41 -0400
Received: from foss.arm.com ([217.140.110.172]:56838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFTJtl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jun 2019 05:49:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 151F5360;
        Thu, 20 Jun 2019 02:49:41 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAA403F246;
        Thu, 20 Jun 2019 02:49:39 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:49:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        leif.lindholm@linaro.org
Subject: Re: [RFC PATCH] acpi/arm64: ignore 5.1 FADTs that are reported as 5.0
Message-ID: <20190620094937.GB20872@e121166-lin.cambridge.arm.com>
References: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
 <20190619122434.GA25656@e107155-lin>
 <20190620075732.GB4699@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620075732.GB4699@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 20, 2019 at 08:57:32AM +0100, Lee Jones wrote:
> On Wed, 19 Jun 2019, Sudeep Holla wrote:
> 
> > On Wed, Jun 19, 2019 at 02:18:31PM +0200, Ard Biesheuvel wrote:
> > > Some Qualcomm Snapdragon based laptops built to run Microsoft Windows
> > > are clearly ACPI 5.1 based, given that that is the first ACPI revision
> > > that supports ARM, and introduced the FADT 'arm_boot_flags' field,
> > > which has a non-zero field on those systems.
> > > 
> > > So in these cases, infer from the ARM boot flags that the FADT must be
> > > 5.1 or later, and treat it as 5.1.
> > > 
> > 
> > Makes sense and looks simple to me.
> > 
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Could we pleeeeease have this in for v5.3?
> 
> We have available, consumer-level platforms that rely on this change.

But we do not have the kernel infrastructure to support them so
I am fine with it but urgency is questionable as far as I am
concerned.

Lorenzo
