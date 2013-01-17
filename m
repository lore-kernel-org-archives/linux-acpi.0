From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] ACPI: add support for CSRT table
Date: Thu, 17 Jan 2013 06:50:35 +0200
Message-ID: <20130117045035.GN2239@intel.com>
References: <1358157111-26510-1-git-send-email-mika.westerberg@linux.intel.com>
 <1358352823-6018-1-git-send-email-mika.westerberg@linux.intel.com>
 <1414072.uJWlZ7TPsD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23832 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757464Ab3AQEqn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2013 23:46:43 -0500
Content-Disposition: inline
In-Reply-To: <1414072.uJWlZ7TPsD@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org

On Thu, Jan 17, 2013 at 12:27:32AM +0100, Rafael J. Wysocki wrote:
> > +static int __init acpi_csrt_init(void)
> > +{
> > +	struct acpi_csrt_group *grp, *end;
> > +	struct acpi_table_csrt *csrt;
> > +	acpi_status status;
> > +	int ret;
> > +
> > +	status = acpi_get_table(ACPI_SIG_CSRT, 0,
> > +				(struct acpi_table_header **)&csrt);
> > +	if (ACPI_FAILURE(status)) {
> > +		if (status == AE_NOT_FOUND)
> > +			return -ENOENT;
> > +		return -EINVAL;
> > +	}
> > +
> > +	pr_debug("parsing CSRT table for devices\n");
> > +
> > +	grp = (struct acpi_csrt_group *)(csrt + 1);
> > +	end = (struct acpi_csrt_group *)((void *)csrt + csrt->header.length);
> > +
> > +	while (grp < end) {
> > +		ret = acpi_csrt_parse_resource_group(grp);
> > +		if (ret)
> > +			return ret;
> > +
> > +		grp = (struct acpi_csrt_group *)((void *)grp + grp->length);
> > +	}
> > +
> > +	return 0;
> > +}
> > +subsys_initcall(acpi_csrt_init);
> 
> -> Do we really need a separate initcall for that?  And what if ACPI is
> disabled?

Ah, good point - ACPI can be disabled at runtime as well.

> Perhaps it would be better to call acpi_csrt_init() directly from
> acpi_init() (or from acpi_scan_init() whichever is more suitable)?

Indeed. I'll fix this up and send you a new version soon.

Thanks.
