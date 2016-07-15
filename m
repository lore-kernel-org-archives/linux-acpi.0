From: joeyli <jlee-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH 1/2] nfit: fix _FIT evaluation memory leak
Date: Fri, 15 Jul 2016 13:15:53 +0800
Message-ID: <20160715051553.GE27155@linux-rxt1.site>
References: <146855333714.573.13934675433503265133.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <146855333714.573.13934675433503265133.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Xiao Guangrong <guangrong.xiao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Dan,

On Thu, Jul 14, 2016 at 08:28:57PM -0700, Dan Williams wrote:
> acpi_evaluate_object() allocates memory. Free the buffer allocated
> during acpi_nfit_add().
> 
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Cc: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Reported-by: Xiao Guangrong <guangrong.xiao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Reported-by: Haozhong Zhang <haozhong.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/nfit.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index 0497175ee6cb..008dbaaa2b75 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -2414,12 +2414,15 @@ static int acpi_nfit_add(struct acpi_device *adev)
>  			acpi_desc->nfit =
>  				(struct acpi_nfit_header *)obj->buffer.pointer;
>  			sz = obj->buffer.length;
> +			rc = acpi_nfit_init(acpi_desc, sz);
>  		} else
>  			dev_dbg(dev, "%s invalid type %d, ignoring _FIT\n",
>  				 __func__, (int) obj->type);
> -	}
> +		kfree(buf.pointer);
> +		acpi_desc->nfit = NULL;

Looks "acpi_desc->nfit = NULL" statement will be removed in [PATCH 2/2]
immediately. Why add it in PATCH 1?

> +	} else
> +		rc = acpi_nfit_init(acpi_desc, sz);
>  
> -	rc = acpi_nfit_init(acpi_desc, sz);
>  	if (rc) {
>  		nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
>  		return rc;
>

Other parts are no problem to me.


Thanks a lot! 
Joey Lee
