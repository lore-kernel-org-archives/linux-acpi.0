From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH -next] ACPI/IORT: Fix the error return code in
 iort_add_smmu_platform_device()
Date: Mon, 6 Feb 2017 12:10:43 +0000
Message-ID: <20170206121042.GD19939@arm.com>
References: <20170205154559.31664-1-weiyj.lk@gmail.com>
 <20170206100411.GA12444@red-moon>
 <1922286.EyoiMMS0FI@aspire.rjw.lan>
 <20170206120733.GA31126@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751911AbdBFMKm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Feb 2017 07:10:42 -0500
Content-Disposition: inline
In-Reply-To: <20170206120733.GA31126@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wei Yongjun <weiyj.lk@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-acpi@vger.kernel.org, catalin.marinas@arm.com

On Mon, Feb 06, 2017 at 12:07:33PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Feb 06, 2017 at 12:41:12PM +0100, Rafael J. Wysocki wrote:
> > On Monday, February 06, 2017 10:04:11 AM Lorenzo Pieralisi wrote:
> > > On Sun, Feb 05, 2017 at 03:45:59PM +0000, Wei Yongjun wrote:
> > > > From: Wei Yongjun <weiyongjun1@huawei.com>
> > > > 
> > > > The error return code PTR_ERR(pdev) is always 0 since pdev is
> > > > equal to 0 in this error handling case.
> > > > 
> > > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > > > ---
> > > >  drivers/acpi/arm64/iort.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > It has been reported twice already:
> > > 
> > > https://patchwork.kernel.org/patch/9521003/
> > > 
> > > Rafael, do you expect me to send you a pull request with IORT fixes ?
> > > 
> > > I can't see Dan's patch in linux-acpi patchwork anymore, and there
> > > is another fix pending:
> > > 
> > > https://patchwork.kernel.org/patch/9507041/
> > > 
> > > Please let me know how you want to handle them.
> > 
> > I wasn't sure about who was the target maintainer to be honest.
> > 
> > I'd prefer ARM64-specific material to go in via the ARM64 tree, if
> > that's possible.
> 
> I CC'ed Catalin and Will so that we can sort this out, I took for
> granted that ACPI changes would go via the ACPI tree even if they
> are ARM64 specific, I am not sure it makes much sense for them to
> go via the arm64 arch tree, anyway it is something to be decided
> because the two fixes above have already missed -rc* and I have to
> know which way patches should go from now onwards.

I have no problem taking arm64 ACPI patches via arm64 if that's what
Rafael prefers. However, I won't proactively pick them up like I do for
other arm64 patches, so please send me a pull request when you have stuff
that you want merged.

Will
