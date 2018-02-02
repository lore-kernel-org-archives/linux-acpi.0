From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] acpi, nfit: fix register dimm error handling
Date: Fri, 2 Feb 2018 12:31:08 -0800
Message-ID: <CAPcyv4jPNxSKxb-kzaw8njhDHGUs7DOPASS_GBXbPGOFP4RN=g@mail.gmail.com>
References: <20180202210036.3153-1-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180202210036.3153-1-toshi.kani-ZPxbGqLxI0U@public.gmane.org>
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
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 2, 2018 at 1:00 PM, Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org> wrote:
> A NULL pointer reference kernel bug was observed when
> acpi_nfit_add_dimm() called in acpi_nfit_register_dimms()
> failed. This error path does not set nfit_mem->nvdimm, but
> the 2nd list_for_each_entry() loop in the function assumes
> it's always set. Add a check to nfit_mem->nvdimm.
>
> Signed-off-by: Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
> Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> ---
>  drivers/acpi/nfit/core.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index abeb4df4f22e..b28ce440a06f 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1867,6 +1867,9 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
>                 struct kernfs_node *nfit_kernfs;
>
>                 nvdimm = nfit_mem->nvdimm;
> +               if (!nvdimm)
> +                       continue;
> +
>                 nfit_kernfs = sysfs_get_dirent(nvdimm_kobj(nvdimm)->sd, "nfit");
>                 if (nfit_kernfs)
>                         nfit_mem->flags_attr = sysfs_get_dirent(nfit_kernfs,

Yes, I assume this also needs:

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Fixes: ba9c8dd3c222 ("acpi, nfit: add dimm device notification support")
