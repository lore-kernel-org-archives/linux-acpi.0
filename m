From: "Kani, Toshi" <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: [PATCH 5/6] nfit, address-range-scrub: rework and simplify ARS
 state machine
Date: Wed, 4 Apr 2018 16:26:09 +0000
Message-ID: <1522859143.2693.296.camel@hpe.com>
References: <152273076087.38372.4803377088477706610.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152273078779.38372.13062348829183334140.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <152273078779.38372.13062348829183334140.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <2261346303772C44A1DC3B4EEC8487D4-mmYPd6ayCNGroOM5E8FhRbjFIynDaujOfM0AETQt39g@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2018-04-02 at 21:46 -0700, Dan Williams wrote:
 :
> +static int init_ars(struct acpi_nfit_desc *acpi_desc, struct nfit_spa *nfit_spa,
> +		int query_rc)
>  {
> -	struct acpi_nfit_system_address *spa = nfit_spa->spa;
> -	unsigned int overflow_retry = scrub_overflow_abort;
> -	u64 init_ars_start = 0, init_ars_len = 0;
> -	struct device *dev = acpi_desc->dev;
> -	unsigned int tmo = scrub_timeout;
>  	int rc;
>  
> -	if (!test_bit(ARS_REQ, &nfit_spa->ars_state) || !nfit_spa->nd_region)
> -		return;
> +	switch (query_rc) {
> +	case 0:
> +		/* ARS is idle, lets look for critical known errors... */
> +		break;
> +	case -EBUSY:
> +		/*
> +		 * ARS is already running, some agent thought it was ok
> +		 * to busy ARS before handing off to the nfit driver.
> +		 */
> +		clear_bit(ARS_SHORT, &nfit_spa->ars_state);
> +		rc = query_rc;
> +		goto out;
> +	case -ENOSPC:
> +		/* ARS continuation needed... */
> +		clear_bit(ARS_SHORT, &nfit_spa->ars_state);
> +		rc = query_rc;
> +		goto out;
> +	default:
> +		rc = query_rc;
> +		goto out;
> +	}
>  
> +	WARN_ON_ONCE(!test_bit(ARS_SHORT, &nfit_spa->ars_state));

I am hitting this WARN_ON_ONCE.  I think there is an issue in the code
flow that ars_complete() clears ARS_SHORT before init_ars().

  acpi_nfit_scrub
    acpi_nfit_query_poison
      ars_status_process_records
         ars_complete
    init_ars

Thanks!
-Toshi
