From: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH] tools/testing/nvdimm: add manufacturing_{date|location}
 dimm properties
Date: Fri, 15 Jul 2016 14:40:59 -0600
Message-ID: <20160715204059.GB12960@omniknight.lm.intel.com>
References: <146861143970.17001.5728377300713176227.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:11540 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbcGOUl1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jul 2016 16:41:27 -0400
Content-Disposition: inline
In-Reply-To: <146861143970.17001.5728377300713176227.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org

On 07/15, Dan Williams wrote:
> New for ACPI 6.1, these fields are used in the common dimm
> representation format defined by section 5.2.25.9 "NVDIMM representation
> format".
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  tools/testing/nvdimm/test/nfit.c |   54 +++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 33 deletions(-)

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index d4a4635c1186..78cba1e3b1da 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -639,6 +639,16 @@ static int nfit_test1_alloc(struct nfit_test *t)
>  	return ars_state_init(&t->pdev.dev, &t->ars_state);
>  }
>  
> +static void dcr_common_init(struct acpi_nfit_control_region *dcr)
> +{
> +	dcr->vendor_id = 0xabcd;
> +	dcr->device_id = 0;
> +	dcr->revision_id = 1;
> +	dcr->valid_fields = 1;
> +	dcr->manufacturing_location = 0xa;
> +	dcr->manufacturing_date = cpu_to_be16(2016);
> +}
> +
>  static void nfit_test0_setup(struct nfit_test *t)
>  {
>  	const int flush_hint_size = sizeof(struct acpi_nfit_flush_address)
> @@ -967,9 +977,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>  	dcr->header.type = ACPI_NFIT_TYPE_CONTROL_REGION;
>  	dcr->header.length = sizeof(struct acpi_nfit_control_region);
>  	dcr->region_index = 0+1;
> -	dcr->vendor_id = 0xabcd;
> -	dcr->device_id = 0;
> -	dcr->revision_id = 1;
> +	dcr_common_init(dcr);
>  	dcr->serial_number = ~handle[0];
>  	dcr->code = NFIT_FIC_BLK;
>  	dcr->windows = 1;
> @@ -984,9 +992,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>  	dcr->header.type = ACPI_NFIT_TYPE_CONTROL_REGION;
>  	dcr->header.length = sizeof(struct acpi_nfit_control_region);
>  	dcr->region_index = 1+1;
> -	dcr->vendor_id = 0xabcd;
> -	dcr->device_id = 0;
> -	dcr->revision_id = 1;
> +	dcr_common_init(dcr);
>  	dcr->serial_number = ~handle[1];
>  	dcr->code = NFIT_FIC_BLK;
>  	dcr->windows = 1;
> @@ -1001,9 +1007,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>  	dcr->header.type = ACPI_NFIT_TYPE_CONTROL_REGION;
>  	dcr->header.length = sizeof(struct acpi_nfit_control_region);
>  	dcr->region_index = 2+1;
> -	dcr->vendor_id = 0xabcd;
> -	dcr->device_id = 0;
> -	dcr->revision_id = 1;
> +	dcr_common_init(dcr);
>  	dcr->serial_number = ~handle[2];
>  	dcr->code = NFIT_FIC_BLK;
>  	dcr->windows = 1;
> @@ -1018,9 +1022,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>  	dcr->header.type = ACPI_NFIT_TYPE_CONTROL_REGION;
>  	dcr->header.length = sizeof(struct acpi_nfit_control_region);
>  	dcr->region_index = 3+1;
> -	dcr->vendor_id = 0xabcd;
> -	dcr->device_id = 0;
> -	dcr->revision_id = 1;
> +	dcr_common_init(dcr);
>  	dcr->serial_number = ~handle[3];
>  	dcr->code = NFIT_FIC_BLK;
>  	dcr->windows = 1;
> @@ -1037,9 +1039,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>  	dcr->header.length = offsetof(struct acpi_nfit_control_region,
>  			window_size);
>  	dcr->region_index = 4+1;
> -	dcr->vendor_id = 0xabcd;
> -	dcr->device_id = 0;
> -	dcr->revision_id = 1;
> +	dcr_common_init(dcr);
>  	dcr->serial_number = ~handle[0];
>  	dcr->code = NFIT_FIC_BYTEN;
>  	dcr->windows = 0;
> @@ -1051,9 +1051,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>  	dcr->header.length = offsetof(struct acpi_nfit_control_region,
>  			window_size);
>  	dcr->region_index = 5+1;
> -	dcr->vendor_id = 0xabcd;
> -	dcr->device_id = 0;
> -	dcr->revision_id = 1;
> +	dcr_common_init(dcr);
>  	dcr->serial_number = ~handle[1];
>  	dcr->code = NFIT_FIC_BYTEN;
>  	dcr->windows = 0;
> @@ -1065,9 +1063,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>  	dcr->header.length = offsetof(struct acpi_nfit_control_region,
>  			window_size);
>  	dcr->region_index = 6+1;
> -	dcr->vendor_id = 0xabcd;
> -	dcr->device_id = 0;
> -	dcr->revision_id = 1;
> +	dcr_common_init(dcr);
>  	dcr->serial_number = ~handle[2];
>  	dcr->code = NFIT_FIC_BYTEN;
>  	dcr->windows = 0;
> @@ -1079,9 +1075,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>  	dcr->header.length = offsetof(struct acpi_nfit_control_region,
>  			window_size);
>  	dcr->region_index = 7+1;
> -	dcr->vendor_id = 0xabcd;
> -	dcr->device_id = 0;
> -	dcr->revision_id = 1;
> +	dcr_common_init(dcr);
>  	dcr->serial_number = ~handle[3];
>  	dcr->code = NFIT_FIC_BYTEN;
>  	dcr->windows = 0;
> @@ -1176,9 +1170,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>  		dcr->header.type = ACPI_NFIT_TYPE_CONTROL_REGION;
>  		dcr->header.length = sizeof(struct acpi_nfit_control_region);
>  		dcr->region_index = 8+1;
> -		dcr->vendor_id = 0xabcd;
> -		dcr->device_id = 0;
> -		dcr->revision_id = 1;
> +		dcr_common_init(dcr);
>  		dcr->serial_number = ~handle[4];
>  		dcr->code = NFIT_FIC_BLK;
>  		dcr->windows = 1;
> @@ -1195,9 +1187,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>  		dcr->header.length = offsetof(struct acpi_nfit_control_region,
>  				window_size);
>  		dcr->region_index = 9+1;
> -		dcr->vendor_id = 0xabcd;
> -		dcr->device_id = 0;
> -		dcr->revision_id = 1;
> +		dcr_common_init(dcr);
>  		dcr->serial_number = ~handle[4];
>  		dcr->code = NFIT_FIC_BYTEN;
>  		dcr->windows = 0;
> @@ -1375,9 +1365,7 @@ static void nfit_test1_setup(struct nfit_test *t)
>  	dcr->header.length = offsetof(struct acpi_nfit_control_region,
>  			window_size);
>  	dcr->region_index = 0+1;
> -	dcr->vendor_id = 0xabcd;
> -	dcr->device_id = 0;
> -	dcr->revision_id = 1;
> +	dcr_common_init(dcr);
>  	dcr->serial_number = ~0;
>  	dcr->code = NFIT_FIC_BYTE;
>  	dcr->windows = 0;
> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
