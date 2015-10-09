From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 1/3] nfit: in acpi_nfit_init, break on a 0-length table
Date: Fri, 09 Oct 2015 13:23:07 -0400
Message-ID: <x49bnc8j6ro.fsf@segfault.boston.devel.redhat.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
	<1444254577-23744-2-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46901 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757580AbbJIRXJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Oct 2015 13:23:09 -0400
In-Reply-To: <1444254577-23744-2-git-send-email-vishal.l.verma@intel.com>
	(Vishal Verma's message of "Wed, 7 Oct 2015 15:49:35 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-nvdimm@ml01.01.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

Vishal Verma <vishal.l.verma@intel.com> writes:

> If acpi_nfit_init is called (such as from nfit_test), with an nfit table
> that has more memory allocated than it needs (and a similarly large
> 'size' field, add_tables would happily keep adding null SPA Range tables
> filling up all available memory.
>
> Make it friendlier by breaking out if a 0-length header is found in any
> of the tables.

Shouldn't that at least spew a warning?  Or does the spec allow for
zero-length tables?

-Jeff

>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: <linux-nvdimm@lists.01.org>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/acpi/nfit.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index c1b8d03..ed599d1 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -335,6 +335,9 @@ static void *add_table(struct acpi_nfit_desc *acpi_desc, void *table,
>  		return NULL;
>  
>  	hdr = table;
> +	if (!hdr->length)
> +		return NULL;
> +
>  	switch (hdr->type) {
>  	case ACPI_NFIT_TYPE_SYSTEM_ADDRESS:
>  		if (!add_spa(acpi_desc, table))
