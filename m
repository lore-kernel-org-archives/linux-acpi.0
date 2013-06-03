From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ghes: fix error return code in ghes_probe()
Date: Mon, 03 Jun 2013 21:48:55 +0200
Message-ID: <1382711.KFDAtoNYNp@vostro.rjw.lan>
References: <CAPgLHd8ONsRjZr9vKMiSR3ZgD7nD8mg+x3pM88+U6DPB=bO_XQ@mail.gmail.com> <1370225694.7548.9.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57501 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759739Ab3FCTjz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Jun 2013 15:39:55 -0400
In-Reply-To: <1370225694.7548.9.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, lenb@kernel.org, wfp5p@virginia.edu, mchehab@redhat.com, gregkh@linuxfoundation.org, yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

On Monday, June 03, 2013 10:14:54 AM Huang Ying wrote:
> On Mon, 2013-06-03 at 10:08 +0800, Wei Yongjun wrote:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > Fix to return a negative error code in the acpi_gsi_to_irq() and
> > request_irq() error handling case instead of 0, as done elsewhere
> > in this function.
> > 
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Good catch!
> 
> Reviewed-by: Huang Ying <ying.huang@intel.com>

Queued up as a fix for 3.10.

Do we need that in -stable?  If so, which versions?

Rafael


> > ---
> >  drivers/acpi/apei/ghes.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 403baf4..fcd7d91 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -919,13 +919,14 @@ static int ghes_probe(struct platform_device *ghes_dev)
> >  		break;
> >  	case ACPI_HEST_NOTIFY_EXTERNAL:
> >  		/* External interrupt vector is GSI */
> > -		if (acpi_gsi_to_irq(generic->notify.vector, &ghes->irq)) {
> > +		rc = acpi_gsi_to_irq(generic->notify.vector, &ghes->irq);
> > +		if (rc) {
> >  			pr_err(GHES_PFX "Failed to map GSI to IRQ for generic hardware error source: %d\n",
> >  			       generic->header.source_id);
> >  			goto err_edac_unreg;
> >  		}
> > -		if (request_irq(ghes->irq, ghes_irq_func,
> > -				0, "GHES IRQ", ghes)) {
> > +		rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
> > +		if (rc) {
> >  			pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
> >  			       generic->header.source_id);
> >  			goto err_edac_unreg;
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
