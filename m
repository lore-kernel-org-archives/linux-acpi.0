From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] acpi,
 nfit: limit ->flush_probe() to initialization work
Date: Fri, 14 Apr 2017 10:30:00 -0700
Message-ID: <CAPcyv4iKHVa0Ek-EkcsYHP6NUTowqdVY-jBkOjas0XS-Zm1n5g@mail.gmail.com>
References: <149218909065.3926.1234846095650907678.stgit@dwillia2-desk3.amr.corp.intel.com>
 <149218911796.3926.17292323458849061393.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <149218911796.3926.17292323458849061393.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 14, 2017 at 9:58 AM, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> The nvdimm probe flushing mechanism gives userspace a sync point where
> it knows all asynchronous driver probe sequences have completed.
> However, it need not wait for other asynchronous actions, like
> on-demand address-range-scrub. Track the init work separately from other
> work in the workqueue, and only flush the former.
>
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/nfit/core.c |   13 ++++++++++---
>  drivers/acpi/nfit/nfit.h |    1 +
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 06738df477db..17cac9d369e0 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -738,7 +738,7 @@ static void nfit_mem_init_bdw(struct acpi_nfit_desc *acpi_desc,
>         }
>  }
>
> -static int nfit_mem_dcr_init(struct acpi_nfit_desc *acpi_desc,
> +static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
>                 struct acpi_nfit_system_address *spa)
>  {
>         struct nfit_mem *nfit_mem, *found;
> @@ -898,7 +898,7 @@ static int nfit_mem_init(struct acpi_nfit_desc *acpi_desc)
>          * BDWs are optional.
>          */
>         list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
> -               rc = nfit_mem_dcr_init(acpi_desc, nfit_spa->spa);
> +               rc = __nfit_mem_init(acpi_desc, nfit_spa->spa);

Whoops, this function rename should have been folded into the previous patch.
