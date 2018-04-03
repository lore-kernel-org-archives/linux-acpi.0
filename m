From: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/6] nfit, address-range-scrub: fix scrub in-progress
 reporting
Date: Tue, 3 Apr 2018 08:31:01 -0700
Message-ID: <f4647d2b-dcc9-f54b-7674-2bc96aec10cf@intel.com>
References: <152273076087.38372.4803377088477706610.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152273077198.38372.11857145045474104173.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <152273077198.38372.11857145045474104173.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On 4/2/2018 9:46 PM, Dan Williams wrote:
> There is a small window whereby ARS scan requests can schedule work that
> userspace will miss when polling scrub_show. Hold the init_mutex lock
> over calls to report the status to close this potential escape. Also,
> make sure that requests to cancel the ARS workqueue are treated as an
> idle event.
>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Cc: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Fixes: 37b137ff8c83 ("nfit, libnvdimm: allow an ARS scrub...")
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Reviewed-by: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


> ---
>   drivers/acpi/nfit/core.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index ea9f3e727fef..2a1fc3817a81 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1249,8 +1249,11 @@ static ssize_t scrub_show(struct device *dev,
>   	if (nd_desc) {
>   		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>   
> +		mutex_lock(&acpi_desc->init_mutex);
>   		rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
> -				(work_busy(&acpi_desc->work)) ? "+\n" : "\n");
> +				work_busy(&acpi_desc->work)
> +				&& !acpi_desc->cancel ? "+\n" : "\n");
> +		mutex_unlock(&acpi_desc->init_mutex);
>   	}
>   	device_unlock(dev);
>   	return rc;
>
