From: "Verma, Vishal L" <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ACPI: nfit: remove redundant assignment if nfit_mem
 found
Date: Fri, 10 Aug 2018 23:45:35 +0000
Message-ID: <1533944734.6054.38.camel@intel.com>
References: <1533199444-29607-1-git-send-email-oceanhehy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1533199444-29607-1-git-send-email-oceanhehy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <DCC5CA9523A00740AB44287C469ACDF3-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "oceanhehy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <oceanhehy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Jiang, Dave" <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org" <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


On Thu, 2018-08-02 at 04:44 -0400, oceanhehy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Ocean He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
> 
> When nfit_mem is found via list_for_each_entry, it has already been
> assigned valid value. There is no need to assign it again in the
> following
> codes.
> 
> Signed-off-by: Ocean He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
> ---
> v1: https://patchwork.kernel.org/patch/10553277/
> v2: Sorry for noise. I got an email problem, so I have to resend to
> loop 
> linux-nvdimm-hn68Rpc1hR1TeqIcxkLZrQ@public.gmane.org
> 
>  drivers/acpi/nfit/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 7c47900..85dde54 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1048,9 +1048,7 @@ static int __nfit_mem_init(struct
> acpi_nfit_desc *acpi_desc,
>  				break;
>  			}
>  
> -		if (found)
> -			nfit_mem = found;
> -		else {
> +		if (!found) {

Hi Ocean,

While this is technically correct, the old way was easier to read. We
loop through and find the matching handle. If we found one, then
nfit_mem was whatever was found. If not, we allocate it.

With this change, one has to go grok the list_for_.. loop to figure out
where nfit_mem is coming from. I'd personally prefer to keep the
existing way..

>  			nfit_mem = devm_kzalloc(acpi_desc->dev,
>  					sizeof(*nfit_mem),
> GFP_KERNEL);
>  			if (!nfit_mem)
