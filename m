From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 1/1] acpi: apei: Enable APEI multiple GHES source to share a single external IRQ
Date: Sun, 23 Jul 2017 00:01:10 +0200
Message-ID: <1893763.BLgt1zgLk5@aspire.rjw.lan>
References: <1500661477-6536-1-git-send-email-lho@apm.com> <1500661477-6536-2-git-send-email-lho@apm.com> <20170722055954.GA2082@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65531 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750921AbdGVWJG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 22 Jul 2017 18:09:06 -0400
In-Reply-To: <20170722055954.GA2082@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Loc Ho <lho@apm.com>, msalter@redhat.com, rafael@kernel.org, tbaicar@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@apm.com

On Saturday, July 22, 2017 07:59:54 AM Borislav Petkov wrote:
> On Fri, Jul 21, 2017 at 11:24:37AM -0700, Loc Ho wrote:
> > X-Gene platforms describe multiple GHES error sources with the same hardware
> > error notification type (external interrupt) and interrupt number.
> > Change the GHES interrupt request to support sharing the same IRQ.
> > 
> > Co-authored-by: Tuan Phan <tphan@apm.com>
> > Signed-off-by: Loc Ho <lho@apm.com>
> > ---
> >  drivers/acpi/apei/ghes.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index d661d45..eed09fc 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1157,7 +1157,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
> >  			       generic->header.source_id);
> >  			goto err_edac_unreg;
> >  		}
> > -		rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
> > +		rc = request_irq(ghes->irq, ghes_irq_func, IRQF_SHARED,
> > +				 "GHES IRQ", ghes);
> >  		if (rc) {
> >  			pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
> >  			       generic->header.source_id);
> 
> Acked-by: Borislav Petkov <bp@suse.de>

OK

Should I apply this or will Tony do that?

