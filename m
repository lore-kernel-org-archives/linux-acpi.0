From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 28 Aug 2017 22:55:07 +0200
Message-ID: <1587060.BVEodWPrhf@aspire.rjw.lan>
References: <20170823225447.15608-1-toshi.kani@hpe.com> <20170823225447.15608-2-toshi.kani@hpe.com> <20170824075348.gqvobmk7mf5ppaip@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45997 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751269AbdH1VDr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Aug 2017 17:03:47 -0400
In-Reply-To: <20170824075348.gqvobmk7mf5ppaip@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Toshi Kani <toshi.kani@hpe.com>, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, August 24, 2017 9:53:48 AM CEST Borislav Petkov wrote:
> On Wed, Aug 23, 2017 at 04:54:43PM -0600, Toshi Kani wrote:
> > ACPI OEM ID / OEM Table ID / Revision can be used to identify
> > a platform based on ACPI firmware info.  acpi_blacklisted(),
> > intel_pstate_platform_pwr_mgmt_exists(), and some other funcs,
> > have been using similar check to detect a list of platforms
> > that require special handlings.
> > 
> > Move the platform check in acpi_blacklisted() to a new common
> > utility function, acpi_match_platform_list(), so that other
> > drivers do not have to implement their own version.
> > 
> > There is no change in functionality.
> > 
> > Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Borislav Petkov <bp@alien8.de>
> > ---
> >  drivers/acpi/blacklist.c |   83 ++++++++--------------------------------------
> >  drivers/acpi/utils.c     |   36 ++++++++++++++++++++
> >  include/linux/acpi.h     |   19 +++++++++++
> >  3 files changed, 69 insertions(+), 69 deletions(-)
> 
> ...
> 
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index b9d956c..0a9e597 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -816,3 +816,39 @@ static int __init acpi_backlight(char *str)
> >  	return 1;
> >  }
> >  __setup("acpi_backlight=", acpi_backlight);
> > +
> > +/**
> > + * acpi_match_platform_list - Check if the system matches with a given list
> > + * @plat: pointer to acpi_platform_list table terminated by a NULL entry
> > + *
> > + * Return the matched index if the system is found in the platform list.
> > + * Otherwise, return a negative error code.
> > + */
> > +int acpi_match_platform_list(const struct acpi_platform_list *plat)
> > +{
> > +	struct acpi_table_header hdr;
> > +	int idx = 0;
> > +
> > +	if (acpi_disabled)
> > +		return -ENODEV;
> > +
> > +	for (; plat->oem_id[0]; plat++, idx++) {
> > +		if (ACPI_FAILURE(acpi_get_table_header(plat->table, 0, &hdr)))
> > +			continue;
> > +
> > +		if (strncmp(plat->oem_id, hdr.oem_id, ACPI_OEM_ID_SIZE))
> > +			continue;
> > +
> > +		if (strncmp(plat->oem_table_id, hdr.oem_table_id, ACPI_OEM_TABLE_ID_SIZE))
> > +			continue;
> > +
> > +		if ((plat->pred == all_versions) ||
> > +		    (plat->pred == less_than_or_equal && hdr.oem_revision <= plat->oem_revision) ||
> > +		    (plat->pred == greater_than_or_equal && hdr.oem_revision >= plat->oem_revision) ||
> > +		    (plat->pred == equal && hdr.oem_revision == plat->oem_revision))
> 
> If you align the second part of the test like this:
> 
>              if ((plat->pred == all_versions) ||
>                  (plat->pred == less_than_or_equal	&& hdr.oem_revision <= plat->oem_revision) ||
>                  (plat->pred == greater_than_or_equal	&& hdr.oem_revision >= plat->oem_revision) ||
>                  (plat->pred == equal			&& hdr.oem_revision == plat->oem_revision))
> 
> it gets maximally readable. But I'd leave that up to Rafael when committing
> - no need to send another version.
> 
> Other than that:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

OK

So what about the [3-5/5] in this series?

My current plan is to apply them too and expose a branch with them, can I
go ahead with that?

Thanks,
Rafael

