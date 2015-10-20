From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/2] acpi: nfit: Add support for hot-add
Date: Mon, 19 Oct 2015 19:02:13 -0700
Message-ID: <CAPcyv4hw4DE8VLymO_GD4BDc-dKr6ENP8rzczqQ6i+R2EuBc3w@mail.gmail.com>
References: <1444863866-19173-1-git-send-email-vishal.l.verma@intel.com>
	<1444863866-19173-3-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35685 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbbJTCCP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Oct 2015 22:02:15 -0400
Received: by wicll6 with SMTP id ll6so24010744wic.0
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2015 19:02:14 -0700 (PDT)
In-Reply-To: <1444863866-19173-3-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Elliott Robert <elliott@hpe.com>

On Wed, Oct 14, 2015 at 4:04 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> Add a .notify callback to the acpi_nfit_driver that gets called on a
> hotplug event. From this, evaluate the _FIT ACPI method which returns
> the updated NFIT with handles for the hot-plugged NVDIMM.
>
> Iterate over the new NFIT, and add any new tables found, and
> register/enable the corresponding regions.
>
> In the nfit test framework, after normal initialization, update the NFIT
> with a new hot-plugged NVDIMM, and directly call into the driver to
> update its view of the available regions.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Toshi Kani <toshi.kani@hpe.com>
> Cc: Elliott, Robert <elliott@hpe.com>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: <linux-nvdimm@lists.01.org>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/acpi/nfit.c              | 197 +++++++++++++++++++++++++++++----------
>  drivers/acpi/nfit.h              |   2 +
>  tools/testing/nvdimm/test/nfit.c | 156 ++++++++++++++++++++++++++++++-
>  3 files changed, 304 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index 35b4b56..b13c235 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -224,9 +224,13 @@ static bool add_spa(struct acpi_nfit_desc *acpi_desc,
>                 struct acpi_nfit_system_address *spa)
>  {
>         struct device *dev = acpi_desc->dev;
> -       struct nfit_spa *nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa),
> -                       GFP_KERNEL);
> +       struct nfit_spa *nfit_spa;
> +
> +       list_for_each_entry(nfit_spa, &acpi_desc->spas, list)
> +               if (memcmp(nfit_spa->spa, spa, sizeof(*spa)) == 0)
> +                       return true;
>

It's unfortunate that when we have an NFIT with multiple SPA entries
that we check subsequent entries against themselves when we know they
must be all new.  Aside from the performance overhead it also hides
buggy BIOS implementations that may be duplicating entries when it
really wanted to make them unique.

I think in acpi_nfit_init we should splice off the old contents if to
a "prev" list and only check for duplicates when "prev" is not empty.
If a duplicate is found use list_move to bring them back into the
acpi_desc list proper.

The side benefit of this is that it becomes easier to add table
deletion support at later date, i.e. anything still on a "prev" list
at the end of parsing got deleted in the new NFIT.

> +       nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa), GFP_KERNEL);
>         if (!nfit_spa)
>                 return false;
>         INIT_LIST_HEAD(&nfit_spa->list);
> @@ -242,9 +246,13 @@ static bool add_memdev(struct acpi_nfit_desc *acpi_desc,
>                 struct acpi_nfit_memory_map *memdev)
>  {
>         struct device *dev = acpi_desc->dev;
> -       struct nfit_memdev *nfit_memdev = devm_kzalloc(dev,
> -                       sizeof(*nfit_memdev), GFP_KERNEL);
> +       struct nfit_memdev *nfit_memdev;
>
> +       list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list)
> +               if (memcmp(nfit_memdev->memdev, memdev, sizeof(*memdev)) == 0)
> +                       return true;
> +
> +       nfit_memdev = devm_kzalloc(dev, sizeof(*nfit_memdev), GFP_KERNEL);
>         if (!nfit_memdev)
>                 return false;
>         INIT_LIST_HEAD(&nfit_memdev->list);
> @@ -260,9 +268,13 @@ static bool add_dcr(struct acpi_nfit_desc *acpi_desc,
>                 struct acpi_nfit_control_region *dcr)
>  {
>         struct device *dev = acpi_desc->dev;
> -       struct nfit_dcr *nfit_dcr = devm_kzalloc(dev, sizeof(*nfit_dcr),
> -                       GFP_KERNEL);
> +       struct nfit_dcr *nfit_dcr;
>
> +       list_for_each_entry(nfit_dcr, &acpi_desc->dcrs, list)
> +               if (memcmp(nfit_dcr->dcr, dcr, sizeof(*dcr)) == 0)
> +                       return true;
> +
> +       nfit_dcr = devm_kzalloc(dev, sizeof(*nfit_dcr), GFP_KERNEL);
>         if (!nfit_dcr)
>                 return false;
>         INIT_LIST_HEAD(&nfit_dcr->list);
> @@ -277,9 +289,13 @@ static bool add_bdw(struct acpi_nfit_desc *acpi_desc,
>                 struct acpi_nfit_data_region *bdw)
>  {
>         struct device *dev = acpi_desc->dev;
> -       struct nfit_bdw *nfit_bdw = devm_kzalloc(dev, sizeof(*nfit_bdw),
> -                       GFP_KERNEL);
> +       struct nfit_bdw *nfit_bdw;
> +
> +       list_for_each_entry(nfit_bdw, &acpi_desc->bdws, list)
> +               if (memcmp(nfit_bdw->bdw, bdw, sizeof(*bdw)) == 0)
> +                       return true;
>
> +       nfit_bdw = devm_kzalloc(dev, sizeof(*nfit_bdw), GFP_KERNEL);
>         if (!nfit_bdw)
>                 return false;
>         INIT_LIST_HEAD(&nfit_bdw->list);
> @@ -294,9 +310,13 @@ static bool add_idt(struct acpi_nfit_desc *acpi_desc,
>                 struct acpi_nfit_interleave *idt)
>  {
>         struct device *dev = acpi_desc->dev;
> -       struct nfit_idt *nfit_idt = devm_kzalloc(dev, sizeof(*nfit_idt),
> -                       GFP_KERNEL);
> +       struct nfit_idt *nfit_idt;
> +
> +       list_for_each_entry(nfit_idt, &acpi_desc->idts, list)
> +               if (memcmp(nfit_idt->idt, idt, sizeof(*idt)) == 0)
> +                       return true;
>
> +       nfit_idt = devm_kzalloc(dev, sizeof(*nfit_idt), GFP_KERNEL);
>         if (!nfit_idt)
>                 return false;
>         INIT_LIST_HEAD(&nfit_idt->list);
> @@ -311,9 +331,13 @@ static bool add_flush(struct acpi_nfit_desc *acpi_desc,
>                 struct acpi_nfit_flush_address *flush)
>  {
>         struct device *dev = acpi_desc->dev;
> -       struct nfit_flush *nfit_flush = devm_kzalloc(dev, sizeof(*nfit_flush),
> -                       GFP_KERNEL);
> +       struct nfit_flush *nfit_flush;
>
> +       list_for_each_entry(nfit_flush, &acpi_desc->flushes, list)
> +               if (memcmp(nfit_flush->flush, flush, sizeof(*flush)) == 0)
> +                       return true;
> +
> +       nfit_flush = devm_kzalloc(dev, sizeof(*nfit_flush), GFP_KERNEL);
>         if (!nfit_flush)
>                 return false;
>         INIT_LIST_HEAD(&nfit_flush->list);
> @@ -808,12 +832,7 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
>                 device_handle = __to_nfit_memdev(nfit_mem)->device_handle;
>                 nvdimm = acpi_nfit_dimm_by_handle(acpi_desc, device_handle);
>                 if (nvdimm) {
> -                       /*
> -                        * If for some reason we find multiple DCRs the
> -                        * first one wins
> -                        */
> -                       dev_err(acpi_desc->dev, "duplicate DCR detected: %s\n",
> -                                       nvdimm_name(nvdimm));
> +                       dimm_count++;
>                         continue;
>                 }
>
> @@ -1535,6 +1554,8 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
>                 if (!nvdimm_volatile_region_create(nvdimm_bus, ndr_desc))
>                         return -ENOMEM;
>         }
> +
> +       acpi_desc->last_init_spa = nfit_spa;

Rather than play tricks with knowing the list position of new entries,
which I think gets harder if we do the "prev" implementation above, I
think it would be handy to track a generation/sequence number in
acpi_desc for every time acpi_nfit_init() is invoked.

>         return 0;
>  }
>
> @@ -1542,7 +1563,15 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
>  {
>         struct nfit_spa *nfit_spa;
>
> -       list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
> +       if (acpi_desc->last_init_spa) {
> +               nfit_spa = acpi_desc->last_init_spa;
> +               nfit_spa = list_next_entry(nfit_spa, list);
> +
> +       } else
> +               nfit_spa = list_first_entry(&acpi_desc->spas,
> +                               typeof(*nfit_spa), list);
> +
> +       list_for_each_entry_from(nfit_spa, &acpi_desc->spas, list) {

If we do the "generation" change this can be limited to only "new
generation" entries.

>                 int rc = acpi_nfit_register_region(acpi_desc, nfit_spa);
>
>                 if (rc)
> @@ -1558,16 +1587,11 @@ int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, acpi_size sz)
>         u8 *data;
>         int rc;
>
> -       INIT_LIST_HEAD(&acpi_desc->spa_maps);
> -       INIT_LIST_HEAD(&acpi_desc->spas);
> -       INIT_LIST_HEAD(&acpi_desc->dcrs);
> -       INIT_LIST_HEAD(&acpi_desc->bdws);
> -       INIT_LIST_HEAD(&acpi_desc->idts);
> -       INIT_LIST_HEAD(&acpi_desc->flushes);
> -       INIT_LIST_HEAD(&acpi_desc->memdevs);
> -       INIT_LIST_HEAD(&acpi_desc->dimms);
> -       mutex_init(&acpi_desc->spa_map_mutex);
> -
> +       mutex_lock(&acpi_desc->init_mutex);
> +       /*
> +        * In the hotplug case, acpi_desc->nfit will have the updated nfit
> +        * table, but the various lists in acpi_desc correspond to the old table
> +        */
>         data = (u8 *) acpi_desc->nfit;
>         end = data + sz;
>         data += sizeof(struct acpi_table_nfit);
> @@ -1577,45 +1601,41 @@ int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, acpi_size sz)
>         if (IS_ERR(data)) {
>                 dev_dbg(dev, "%s: nfit table parsing error: %ld\n", __func__,
>                                 PTR_ERR(data));
> -               return PTR_ERR(data);
> +               rc = PTR_ERR(data);
> +               goto out_unlock;
>         }
>
> -       if (nfit_mem_init(acpi_desc) != 0)
> -               return -ENOMEM;
> +       if (nfit_mem_init(acpi_desc) != 0) {
> +               rc = -ENOMEM;
> +               goto out_unlock;
> +       }
>
>         acpi_nfit_init_dsms(acpi_desc);
>
>         rc = acpi_nfit_register_dimms(acpi_desc);
>         if (rc)
> -               return rc;
> +               goto out_unlock;
> +
> +       rc = acpi_nfit_register_regions(acpi_desc);
>
> -       return acpi_nfit_register_regions(acpi_desc);
> + out_unlock:
> +       mutex_unlock(&acpi_desc->init_mutex);
> +       return rc;
>  }
>  EXPORT_SYMBOL_GPL(acpi_nfit_init);
>
> -static int acpi_nfit_add(struct acpi_device *adev)
> +static struct acpi_nfit_desc *acpi_nfit_desc_init(struct acpi_device *adev)
>  {
>         struct nvdimm_bus_descriptor *nd_desc;
>         struct acpi_nfit_desc *acpi_desc;
>         struct device *dev = &adev->dev;
> -       struct acpi_table_header *tbl;
> -       acpi_status status = AE_OK;
> -       acpi_size sz;
> -       int rc;
> -
> -       status = acpi_get_table_with_size("NFIT", 0, &tbl, &sz);
> -       if (ACPI_FAILURE(status)) {
> -               dev_err(dev, "failed to find NFIT\n");
> -               return -ENXIO;
> -       }
>
>         acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
>         if (!acpi_desc)
> -               return -ENOMEM;
> +               return ERR_PTR(-ENOMEM);
>
>         dev_set_drvdata(dev, acpi_desc);
>         acpi_desc->dev = dev;
> -       acpi_desc->nfit = (struct acpi_table_nfit *) tbl;
>         acpi_desc->blk_do_io = acpi_nfit_blk_region_do_io;
>         nd_desc = &acpi_desc->nd_desc;
>         nd_desc->provider_name = "ACPI.NFIT";
> @@ -1623,9 +1643,49 @@ static int acpi_nfit_add(struct acpi_device *adev)
>         nd_desc->attr_groups = acpi_nfit_attribute_groups;
>
>         acpi_desc->nvdimm_bus = nvdimm_bus_register(dev, nd_desc);
> -       if (!acpi_desc->nvdimm_bus)
> -               return -ENXIO;
> +       if (!acpi_desc->nvdimm_bus) {
> +               devm_kfree(dev, acpi_desc);
> +               return ERR_PTR(-ENXIO);
> +       }
> +
> +       INIT_LIST_HEAD(&acpi_desc->spa_maps);
> +       INIT_LIST_HEAD(&acpi_desc->spas);
> +       INIT_LIST_HEAD(&acpi_desc->dcrs);
> +       INIT_LIST_HEAD(&acpi_desc->bdws);
> +       INIT_LIST_HEAD(&acpi_desc->idts);
> +       INIT_LIST_HEAD(&acpi_desc->flushes);
> +       INIT_LIST_HEAD(&acpi_desc->memdevs);
> +       INIT_LIST_HEAD(&acpi_desc->dimms);
> +       mutex_init(&acpi_desc->spa_map_mutex);
> +       mutex_init(&acpi_desc->init_mutex);
> +
> +       return acpi_desc;
> +}
> +
> +static int acpi_nfit_add(struct acpi_device *adev)
> +{
> +       struct acpi_nfit_desc *acpi_desc;
> +       struct device *dev = &adev->dev;
> +       struct acpi_table_header *tbl;
> +       acpi_status status = AE_OK;
> +       acpi_size sz;
> +       int rc;
>
> +       status = acpi_get_table_with_size("NFIT", 0, &tbl, &sz);
> +       if (ACPI_FAILURE(status)) {
> +               /* This is ok, we could have an nvdimm hotplugged later */
> +               dev_dbg(dev, "failed to find NFIT at startup\n");
> +               return 0;
> +       }
> +
> +       acpi_desc = acpi_nfit_desc_init(adev);
> +       if (IS_ERR_OR_NULL(acpi_desc)) {
> +               dev_err(dev, "%s: error initializing acpi_desc: %ld\n",
> +                               __func__, PTR_ERR(acpi_desc));
> +               return PTR_ERR(acpi_desc);
> +       }
> +
> +       acpi_desc->nfit = (struct acpi_table_nfit *) tbl;
>         rc = acpi_nfit_init(acpi_desc, sz);
>         if (rc) {
>                 nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
> @@ -1642,6 +1702,44 @@ static int acpi_nfit_remove(struct acpi_device *adev)
>         return 0;
>  }
>
> +static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> +{
> +       struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(&adev->dev);
> +       struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
> +       struct acpi_table_nfit *nfit_saved;
> +       struct device *dev = &adev->dev;
> +       acpi_status status;
> +       int ret;
> +
> +       dev_dbg(dev, "%s: event: %d\n", __func__, event);
> +
> +       if (!acpi_desc) {

What happens if acpi_nfit_add() is still running during this
notification?  I think you need to do this under "device_lock(dev)" to
make sure acpi_nfit_add() has completed.  Probably also need to check
dev->driver to make sure the device is still enabled before adding new
nfit entries. Using init_mutex for this exclusion seems too late since
you need to hold the lock to check if acpi_desc is set in via
dev_set_drvdata()

This raises an interesting question... if we disable the nfit driver
after receiving a notification of a new nfit, what happens when we
re-enable?  I think we need to always check for _FIT in the init path
and use that to override the base table by default, provided it's
populated.

> +               acpi_desc = acpi_nfit_desc_init(adev);
> +               if (IS_ERR_OR_NULL(acpi_desc)) {

Afaics, acpi_nfit_desc_init() always returns an ERR_PTR, never NULL,
so just use IS_ERR() here please.

> +                       dev_err(dev, "%s: error initializing acpi_desc: %ld\n",
> +                               __func__, PTR_ERR(acpi_desc));
> +                       return;
> +               }
> +       }
> +
> +       /* Evaluate _FIT */
> +       status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
> +       if (ACPI_FAILURE(status)) {
> +               dev_err(dev, "failed to evaluate _FIT\n");
> +               return;
> +       }
> +
> +       nfit_saved = acpi_desc->nfit;
> +       acpi_desc->nfit = (struct acpi_table_nfit *)buf.pointer;
> +       ret = acpi_nfit_init(acpi_desc, buf.length);
> +       if (!ret) {
> +               /* Merge failed, restore old nfit, and exit */
> +               acpi_desc->nfit = nfit_saved;
> +               dev_err(dev, "failed to merge updated NFIT\n");
> +       }
> +       kfree(buf.pointer);
> +}
> +
>  static const struct acpi_device_id acpi_nfit_ids[] = {
>         { "ACPI0012", 0 },
>         { "", 0 },
> @@ -1654,6 +1752,7 @@ static struct acpi_driver acpi_nfit_driver = {
>         .ops = {
>                 .add = acpi_nfit_add,
>                 .remove = acpi_nfit_remove,
> +               .notify = acpi_nfit_notify,
>         },
>  };
>
> diff --git a/drivers/acpi/nfit.h b/drivers/acpi/nfit.h
> index 7e74015..1fb0672 100644
> --- a/drivers/acpi/nfit.h
> +++ b/drivers/acpi/nfit.h
> @@ -97,6 +97,7 @@ struct acpi_nfit_desc {
>         struct nvdimm_bus_descriptor nd_desc;
>         struct acpi_table_nfit *nfit;
>         struct mutex spa_map_mutex;
> +       struct mutex init_mutex;
>         struct list_head spa_maps;
>         struct list_head memdevs;
>         struct list_head flushes;
> @@ -105,6 +106,7 @@ struct acpi_nfit_desc {
>         struct list_head dcrs;
>         struct list_head bdws;
>         struct list_head idts;
> +       struct nfit_spa *last_init_spa;
>         struct nvdimm_bus *nvdimm_bus;
>         struct device *dev;
>         unsigned long dimm_dsm_force_en;

[..] snip test implementation...
