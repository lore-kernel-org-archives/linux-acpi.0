From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH] acpi: add NFIT and HMAT to the initrd override list
Date: Mon, 18 Dec 2017 12:54:05 -0700
Message-ID: <20171218195405.GA18900@linux.intel.com>
References: <151275056532.8020.17160155121603376532.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58815 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758693AbdLRTyG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Dec 2017 14:54:06 -0500
Content-Disposition: inline
In-Reply-To: <151275056532.8020.17160155121603376532.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-nvdimm@lists.01.org

On Fri, Dec 08, 2017 at 08:29:25AM -0800, Dan Williams wrote:
> These tables, NFIT and HMAT, are essential for describing
> next-generation platform memory topologies and performance
> characteristics. Allow them to be overridden for debug and test and
> purposes.
> 
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>

Yes please!  This works in my test setup for inserting custom HMAT tables, and
I would really like to have this for testing my HMAT series:

https://lists.01.org/pipermail/linux-nvdimm/2017-December/013571.html

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/tables.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 80ce2a7d224b..67a44fd79449 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -456,7 +456,8 @@ static const char * const table_sigs[] = {
>  	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
>  	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
>  	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
> -	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
> +	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_NFIT,
> +	ACPI_SIG_HMAT, NULL };
>  
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>  
> 
