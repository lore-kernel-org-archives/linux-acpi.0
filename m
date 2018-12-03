From: "Verma, Vishal L" <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] acpi/nfit: Fix user-initiated ARS to be "ARS-long"
 rather than "ARS-short"
Date: Mon, 3 Dec 2018 21:19:17 +0000
Message-ID: <f62c2c146b846286a19bf708aa7204d5341b1fe4.camel@intel.com>
References: <154386182529.24428.16722249724563229676.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <154386182529.24428.16722249724563229676.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <A828882E70DA6D41BFD2CD7592019C98-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Cc: "Zloch, Jacek" <jacek.zloch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


On Mon, 2018-12-03 at 10:30 -0800, Dan Williams wrote:
> A "short" ARS (address range scrub) instructs the platform firmware
> to
> return known errors. In contrast, a "long" ARS instructs platform
> firmware to arrange every data address on the DIMM to be read /
> checked
> for poisoned data.
> 
> The conversion of the flags in commit d3abaf43bab8 "acpi, nfit: Fix
> Address Range Scrub completion tracking", changed the meaning of
> passing
> '0' to acpi_nfit_ars_rescan(). Previously '0' meant "not short", now
> '0'
> is ARS_REQ_SHORT. Pass ARS_REQ_LONG to restore the expected scrub-
> type
> behavior of user-initiated ARS sessions.
> 
> Fixes: d3abaf43bab8 ("acpi, nfit: Fix Address Range Scrub completion
> tracking")
> Reported-by: Jacek Zloch <jacek.zloch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/nfit/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good,
Reviewed-by: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 14d9f5bea015..5912d30020c7 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1308,7 +1308,7 @@ static ssize_t scrub_store(struct device *dev,
>  	if (nd_desc) {
>  		struct acpi_nfit_desc *acpi_desc =
> to_acpi_desc(nd_desc);
>  
> -		rc = acpi_nfit_ars_rescan(acpi_desc, 0);
> +		rc = acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
>  	}
>  	device_unlock(dev);
>  	if (rc)
> 
