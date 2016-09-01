From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] acpi, nfit: add dimm device notification support
Date: Thu, 1 Sep 2016 12:46:21 -0700
Message-ID: <CAPcyv4ikttQ2zjo9QZ4bSW5inX4z9cKvpL8JfMr0ugQfwFB3Jg@mail.gmail.com>
References: <147198925154.3136.14739108342311837939.stgit@dwillia2-desk3.amr.corp.intel.com>
 <147198926249.3136.6163137762013359047.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <147198926249.3136.6163137762013359047.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

On Tue, Aug 23, 2016 at 2:54 PM, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Per "ACPI 6.1 Section 9.20.3" NVDIMM devices, children of the ACPI0012
> NVDIMM Root device, can receive health event notifications.
>
> Given that these devices are precluded from registering a notification
> handler via acpi_driver.acpi_device_ops (due to no _HID), we use
> acpi_install_notify_handler() directly.  The registered handler,
> acpi_nvdimm_notify(), triggers a poll(2) event on the nmemX/nfit/flags
> sysfs attribute when a health event notification is received.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/nfit/core.c   |   83 ++++++++++++++++++++++++++++++++++++++++++--
>  drivers/acpi/nfit/nfit.h   |    5 +++
>  drivers/nvdimm/dimm_devs.c |    6 +++
>  include/linux/libnvdimm.h  |    1 +
>  4 files changed, 91 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 8120e8218f93..65f155db4283 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
[..]
> @@ -2400,6 +2464,7 @@ static int acpi_nfit_desc_init_scrub_attr(struct acpi_nfit_desc *acpi_desc)
>
>  static void acpi_nfit_destruct(void *data)
>  {
> +       struct nfit_mem *nfit_mem;
>         struct acpi_nfit_desc *acpi_desc = data;
>         struct device *bus_dev = to_nvdimm_bus_dev(acpi_desc->nvdimm_bus);
>
> @@ -2415,6 +2480,16 @@ static void acpi_nfit_destruct(void *data)
>          * either submit or see ->cancel set.
>          */
>         device_lock(bus_dev);
> +       /*
> +        * Clear out the nfit_mem->flags_attr and shut down dimm event
> +        * notifications.
> +        */
> +       list_for_each_entry(nfit_mem, &acpi_desc->dimms, list) {
> +               sysfs_put(nfit_mem->flags_attr);
> +               nfit_mem->flags_attr = NULL;

We need to check if flags_attr is NULL here in the case when the DIMM
failed to initialize.  I believe the crash I am hitting is fixed by
Toshi's patch https://patchwork.kernel.org/patch/9284427/, but I'll
still fix this up for other cases.
