From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/4] nfit, libnvdimm: allow an ARS scrub to be
 triggered on demand
Date: Sun, 24 Jul 2016 07:55:53 -0700
Message-ID: <CAPcyv4g=x52KnuSxgmAEt0NDqvTYntm=eqW_FJD67K1CyCge0g@mail.gmail.com>
References: <146933799257.26196.10157809349693736359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146933800343.26196.11707211474975930425.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <146933800343.26196.11707211474975930425.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jul 23, 2016 at 10:26 PM, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> From: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>
> Normally, an ARS (Address Range Scrub) only happens at
> boot/initialization time. There can however arise situations where a
> bus-wide rescan is needed - notably, in the case of discovering a latent
> media error, we should do a full rescan to figure out what other sectors
> are bad, and thus potentially avoid triggering an mce on them in the
> future. Also provide a sysfs trigger to start a bus-wide scrub.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/nfit.c       |  167 +++++++++++++++++++++++++++++++++++++++++++--
>  drivers/acpi/nfit.h       |    4 +
>  drivers/nvdimm/core.c     |    7 ++
>  include/linux/libnvdimm.h |    1
>  4 files changed, 171 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index be7c2fde16e7..2eaa03dc185a 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
[..]
> @@ -2308,17 +2423,30 @@ int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *data, acpi_size sz)
>         const void *end;
>         int rc;
>
> +       acpi_nfit_init_dsms(acpi_desc);
> +
>         if (!acpi_desc->nvdimm_bus) {
> +               acpi_nfit_init_dsms(acpi_desc);
> +
>                 acpi_desc->nvdimm_bus = nvdimm_bus_register(dev,
>                                 &acpi_desc->nd_desc);
>                 if (!acpi_desc->nvdimm_bus)
>                         return -ENOMEM;
> +
>                 rc = devm_add_action_or_reset(dev, acpi_nfit_destruct,
>                                 acpi_desc);
>                 if (rc)
>                         return rc;
> +
> +               rc = acpi_nfit_desc_init_scrub_attr(acpi_desc);
> +               if (rc)
> +                       return rc;
>         }
>
> +       rc = acpi_nfit_desc_init_scrub_attr(acpi_desc);
> +       if (rc)
> +               return rc;
> +

Whoops, rebase error.  I was moving acpi_nfit_init_dsms() and
acpi_nfit_desc_init_scrub_attr() to only run at the initial call to
acpi_nfit_init().
