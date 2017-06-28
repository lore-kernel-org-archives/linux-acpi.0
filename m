From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] acpi/nfit: Issue Start ARS to retrieve existing records
Date: Wed, 28 Jun 2017 14:26:24 -0700
Message-ID: <CAPcyv4i_cCPsurej1YDVgocTiuxzT0uKFYSg1Hzn40GQc0PJvQ@mail.gmail.com>
References: <20170617082218.8955-1-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20170617082218.8955-1-toshi.kani-ZPxbGqLxI0U@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jun 17, 2017 at 1:22 AM, Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org> wrote:
> ACPI 6.2 defines in section 9.20.7.2 that the OSPM may call a Start
> ARS with Flags Bit [1] set upon receiving the 0x81 notification.
>
>   Upon receiving the notification, the OSPM may decide to issue
>   a Start ARS with Flags Bit [1] set to prepare for the retrieval
>   of existing records and issue the Query ARS Status function to
>   retrieve the records.
>
> Add support to call a Start ARS from acpi_nfit_uc_error_notify()
> with ND_ARS_RETURN_PREV_DATA set when HW_ERROR_SCRUB_ON is not set.
>
> Link: http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> Signed-off-by: Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
> Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> Cc: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
> ---
> v3 (2/2): Add flags info to acpi_nfit_desc (Dan Williams)
> ---
>  drivers/acpi/nfit/core.c   |   11 ++++++++---
>  drivers/acpi/nfit/mce.c    |    2 +-
>  drivers/acpi/nfit/nfit.h   |    3 ++-
>  include/uapi/linux/ndctl.h |    1 +
>  4 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index cc22778..7e08ee0 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1031,7 +1031,7 @@ static ssize_t scrub_store(struct device *dev,
>         if (nd_desc) {
>                 struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>
> -               rc = acpi_nfit_ars_rescan(acpi_desc);
> +               rc = acpi_nfit_ars_rescan(acpi_desc, 0);
>         }
>         device_unlock(dev);
>         if (rc)
> @@ -2051,6 +2051,7 @@ static int ars_start(struct acpi_nfit_desc *acpi_desc, struct nfit_spa *nfit_spa
>         memset(&ars_start, 0, sizeof(ars_start));
>         ars_start.address = spa->address;
>         ars_start.length = spa->length;
> +       ars_start.flags = acpi_desc->ars_start_flags;

Hmm don't we also need a statement like this in ars_continue()?

>         if (nfit_spa_type(spa) == NFIT_SPA_PM)
>                 ars_start.type = ND_ARS_PERSISTENT;
>         else if (nfit_spa_type(spa) == NFIT_SPA_VOLATILE)
> @@ -2613,6 +2614,7 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
>                                 return rc;
>                 }
>
> +       acpi_desc->ars_start_flags = 0;

...and I would think the ND_ARS_RETURN_PREV_DATA context would only be
valid for the duration of the current scrub, so we should clear the
flags at the end of acpi_nfit_scrub().
