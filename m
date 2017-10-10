From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2] acpi/arm64: pr_err() strings should end with newlines
Date: Tue, 10 Oct 2017 11:24:36 +0100
Message-ID: <20171010102436.GA949@red-moon>
References: <d81bee42b06beefa9a7149b5b35bf884836c2595.1506321825.git.arvind.yadav.cs@gmail.com>
 <59DC93FE.2060004@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbdJJKYn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Oct 2017 06:24:43 -0400
Content-Disposition: inline
In-Reply-To: <59DC93FE.2060004@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 10, 2017 at 05:33:50PM +0800, Hanjun Guo wrote:
> On 2017/9/25 15:24, Arvind Yadav wrote:
> > pr_err() messages should terminated with a new-line to avoid
> > other messages being concatenated onto the end.
> >
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > ---
> > changes in v2:
> >              Add changelog.
> >
> >  drivers/acpi/arm64/gtdt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> > index 597a737..92f9edf 100644
> > --- a/drivers/acpi/arm64/gtdt.c
> > +++ b/drivers/acpi/arm64/gtdt.c
> > @@ -199,7 +199,7 @@ static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
> >  	struct acpi_gtdt_timer_entry *gtdt_frame;
> >  
> >  	if (!block->timer_count) {
> > -		pr_err(FW_BUG "GT block present, but frame count is zero.");
> > +		pr_err(FW_BUG "GT block present, but frame count is zero.\n");
> >  		return -ENODEV;
> >  	}
> >  
> 
> Make sense to me,
> 
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Lorenzo, could you pick this up for 4.15?

Sure, thanks for reminding.

Thanks,
Lorenzo
