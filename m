From: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: [PATCH] acpi, nfit: fix acpi_check_dsm() vs zero functions
 implemented
Date: Mon, 27 Jun 2016 13:40:04 -0400
Message-ID: <bd2353c0-0d84-3c0a-8117-3f24b823f469@hpe.com>
References: <146679026571.24395.11569929364936343871.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <146679026571.24395.11569929364936343871.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Xiao Guangrong <guangrong.xiao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


On 6/24/2016 1:44 PM, Dan Williams wrote:
> QEMU 2.6 implements nascent support for nvdimm DSMs. Depending on
> configuration it may only implement the function0 dsm to indicate that
> no other DSMs are available. Commit 31eca76ba2fc "nfit, libnvdimm:
> limited/whitelisted dimm command marshaling mechanism" breaks QEMU, but
> QEMU is spec compliant.  Per the spec the way to indicate that no
> functions are supported is:
> 
>     If Function Index is zero, the return is a buffer containing one bit
>     for each function index, starting with zero. Bit 0 indicates whether
>     there is support for any functions other than function 0 for the
>     specified UUID and Revision ID. If set to zero, no functions are
>     supported (other than function zero) for the specified UUID and
>     Revision ID.

The rest of that paragraph is:

If set to one, at least one additional function is supported. For all other bits
in the buffer, a bit is set to zero to indicate if that function index is not
supported for the specific UUID and Revision ID. (For example, bit 1 set to 0
indicates that function index 1 is not supported for the specific UUID and
Revision ID.)

> 
> Update the nfit driver to determine the family (interface UUID) without
> requiring the implementation to define any other functions, i.e.
> short-circuit acpi_check_dsm() to succeed per the spec.  The nfit driver
> appears to be the only user passing funcs==0 to acpi_check_dsm(), so
> this behavior change of the common routine should be limited to the
> probing done by the nfit driver.

I don't understand why we're special casing this to support QEMU only when
there are no DSM functions supported.  If we want to implement the
spec and support function zero, I think we should support it correctly.
That means returning the correct value for all spec compliant callers,
even when there are functions that are supported.

-- ljk
> 
> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> Cc: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Jerry Hoemann <jerry.hoemann-ZPxbGqLxI0U@public.gmane.org>
> Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command marshaling mechanism")
> Reported-by: Xiao Guangrong <guangrong.xiao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Tested-by: Xiao Guangrong <guangrong.xiao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/nfit.c  |    6 +++---
>  drivers/acpi/utils.c |    6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index 2215fc847fa9..32579a7b71d5 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -1131,11 +1131,11 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>  
>  	/*
>  	 * Until standardization materializes we need to consider up to 3
> -	 * different command sets.  Note, that checking for function0 (bit0)
> -	 * tells us if any commands are reachable through this uuid.
> +	 * different command sets.  Note, that checking for zero functions
> +	 * tells us if any commands might be reachable through this uuid.
>  	 */
>  	for (i = NVDIMM_FAMILY_INTEL; i <= NVDIMM_FAMILY_HPE2; i++)
> -		if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 1))
> +		if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 0))
>  			break;
>  
>  	/* limit the supported commands to those that are publicly documented */
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 22c09952e177..b4de130f2d57 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -680,9 +680,6 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, u64 rev, u64 funcs)
>  	u64 mask = 0;
>  	union acpi_object *obj;
>  
> -	if (funcs == 0)
> -		return false;
> -
>  	obj = acpi_evaluate_dsm(handle, uuid, rev, 0, NULL);
>  	if (!obj)
>  		return false;
> @@ -695,6 +692,9 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, u64 rev, u64 funcs)
>  			mask |= (((u64)obj->buffer.pointer[i]) << (i * 8));
>  	ACPI_FREE(obj);
>  
> +	if (funcs == 0)
> +		return true;
> +
>  	/*
>  	 * Bit 0 indicates whether there's support for any functions other than
>  	 * function 0 for the specified UUID and revision.
> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
> 
