From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH -next] ACPI/IORT: Fix the error return code in iort_add_smmu_platform_device()
Date: Mon, 06 Feb 2017 12:41:12 +0100
Message-ID: <1922286.EyoiMMS0FI@aspire.rjw.lan>
References: <20170205154559.31664-1-weiyj.lk@gmail.com> <20170206100411.GA12444@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48896 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751456AbdBFLp7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2017 06:45:59 -0500
In-Reply-To: <20170206100411.GA12444@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-acpi@vger.kernel.org

On Monday, February 06, 2017 10:04:11 AM Lorenzo Pieralisi wrote:
> On Sun, Feb 05, 2017 at 03:45:59PM +0000, Wei Yongjun wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> > 
> > The error return code PTR_ERR(pdev) is always 0 since pdev is
> > equal to 0 in this error handling case.
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/acpi/arm64/iort.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> It has been reported twice already:
> 
> https://patchwork.kernel.org/patch/9521003/
> 
> Rafael, do you expect me to send you a pull request with IORT fixes ?
> 
> I can't see Dan's patch in linux-acpi patchwork anymore, and there
> is another fix pending:
> 
> https://patchwork.kernel.org/patch/9507041/
> 
> Please let me know how you want to handle them.

I wasn't sure about who was the target maintainer to be honest.

I'd prefer ARM64-specific material to go in via the ARM64 tree, if that's possible.

Thanks,
Rafael

