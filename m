From: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] acpi, nfit: Further restrict userspace ARS start
 requests
Date: Mon, 15 Oct 2018 14:24:44 -0700
Message-ID: <38b2dd11-2db8-d1f2-470b-67bc3ec013d0@intel.com>
References: <153963719771.2140296.1457598322723171137.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <153963719771.2140296.1457598322723171137.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On 10/15/2018 02:00 PM, Dan Williams wrote:
> In addition to not allowing ARS start while the background thread is
> actively running, prevent ARS start while any scrub request is pending.
> 
> This aligns the window for ARS start submission with the status of ARS
> reported via sysfs. Previously userspace could sneak its own ARS start
> requests in while sysfs reported -EBUSY.
> 
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Reviewed-by: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
> Changes in v2:
> * Require acpi_desc->scrub_spa to be NULL to prevent requests being sent
>   while a scrub is active, or whose results are waiting to be reaped.
> 
>  drivers/acpi/nfit/core.c |   19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index f7efcd9843e0..253c0e85554d 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3364,6 +3364,8 @@ static int __acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
>  		struct nvdimm *nvdimm, unsigned int cmd)
>  {
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_nfit_desc(nd_desc);
> +	struct nfit_spa *nfit_spa;
> +	int rc = 0;
>  
>  	if (nvdimm)
>  		return 0;
> @@ -3373,13 +3375,20 @@ static int __acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
>  	/*
>  	 * The kernel and userspace may race to initiate a scrub, but
>  	 * the scrub thread is prepared to lose that initial race.  It
> -	 * just needs guarantees that any ars it initiates are not
> -	 * interrupted by any intervening start reqeusts from userspace.
> +	 * just needs guarantees that any ARS it initiates are not
> +	 * interrupted by any intervening start requests from userspace.
>  	 */
> -	if (work_busy(&acpi_desc->dwork.work))
> -		return -EBUSY;
> +	mutex_lock(&acpi_desc->init_mutex);
> +	list_for_each_entry(nfit_spa, &acpi_desc->spas, list)
> +		if (acpi_desc->scrub_spa
> +				|| test_bit(ARS_REQ_SHORT, &nfit_spa->ars_state)
> +				|| test_bit(ARS_REQ_LONG, &nfit_spa->ars_state)) {
> +			rc = -EBUSY;
> +			break;
> +		}
> +	mutex_unlock(&acpi_desc->init_mutex);
>  
> -	return 0;
> +	return rc;
>  }
>  
>  /* prevent security commands from being issued via ioctl */
> 
