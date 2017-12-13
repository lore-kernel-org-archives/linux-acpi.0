From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI, APEI, Fix use resource_size
Date: Wed, 13 Dec 2017 16:38:57 +0100
Message-ID: <20171213153857.2cftlirw7vbo5orm@pd.tnic>
References: <1513007072-32020-1-git-send-email-gomonovych@gmail.com>
 <4222319.ltJQ6b6Cov@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:40782 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752860AbdLMPjJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Dec 2017 10:39:09 -0500
Content-Disposition: inline
In-Reply-To: <4222319.ltJQ6b6Cov@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vasyl Gomonovych <gomonovych@gmail.com>, lenb@kernel.org, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 13, 2017 at 01:19:55AM +0100, Rafael J. Wysocki wrote:
> On Monday, December 11, 2017 4:44:31 PM CET Vasyl Gomonovych wrote:
> > Use resource_size function on resource object
> > Underneath __request_region set res->end to start + n - 1
> > Lets use resourse_size to set value properly.
> > 
> > Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> 
> Boris, what do you think?

So if MAINTAINERS says we review apei stuff, it doesn't mean that you
should completely stop doing that! :-P

So this looks like a fix to me since it didn't do the + 1 before.

I don't believe this would break any APEI stuff but it should be tested
a little just in case.

> > ---
> >  drivers/acpi/apei/apei-base.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> > index da370e1..af712a8 100644
> > --- a/drivers/acpi/apei/apei-base.c
> > +++ b/drivers/acpi/apei/apei-base.c
> > @@ -506,8 +506,7 @@ int apei_resources_request(struct apei_resources *resources,
> >  
> >  	rc = -EINVAL;
> >  	list_for_each_entry(res, &resources->iomem, list) {
> > -		r = request_mem_region(res->start, res->end - res->start,
> > -				       desc);
> > +		r = request_mem_region(res->start, resource_size(res), desc);

Jeez, this is silly: we compute resource size just so that __request_region()
can "uncompute" it back:

        res->start = start;
        res->end = start + n - 1;

Lovely.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
