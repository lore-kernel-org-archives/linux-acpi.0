From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 3/3] acpi: nfit: Add support for hotplug
Date: Fri, 09 Oct 2015 13:33:40 -0400
Message-ID: <x4937xkj6a3.fsf@segfault.boston.devel.redhat.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
	<1444254577-23744-4-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34904 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758117AbbJIRdm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Oct 2015 13:33:42 -0400
In-Reply-To: <1444254577-23744-4-git-send-email-vishal.l.verma@intel.com>
	(Vishal Verma's message of "Wed, 7 Oct 2015 15:49:37 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-nvdimm@ml01.01.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

Vishal Verma <vishal.l.verma@intel.com> writes:

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

OK, so just plugging in new NVDIMMs is supported, right?  Are there
plans to support unplugging DIMMs?

-Jeff

>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: <linux-nvdimm@lists.01.org>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/acpi/nfit.c              | 136 ++++++++++++++++++++++++++++++++----
>  drivers/acpi/nfit.h              |   2 +
>  tools/testing/nvdimm/test/nfit.c | 144 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 267 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index ed599d1..2c24466 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -224,9 +224,13 @@ static bool add_spa(struct acpi_nfit_desc *acpi_desc,
>  		struct acpi_nfit_system_address *spa)
>  {
>  	struct device *dev = acpi_desc->dev;
> -	struct nfit_spa *nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa),
> -			GFP_KERNEL);
> +	struct nfit_spa *nfit_spa;
> +
> +	list_for_each_entry(nfit_spa, &acpi_desc->spas, list)
> +		if (memcmp(nfit_spa->spa, spa, sizeof(*spa)) == 0)
> +			return true;
>  
> +	nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa), GFP_KERNEL);
>  	if (!nfit_spa)
>  		return false;
>  	INIT_LIST_HEAD(&nfit_spa->list);
> @@ -242,9 +246,13 @@ static bool add_memdev(struct acpi_nfit_desc *acpi_desc,
>  		struct acpi_nfit_memory_map *memdev)
>  {
>  	struct device *dev = acpi_desc->dev;
> -	struct nfit_memdev *nfit_memdev = devm_kzalloc(dev,
> -			sizeof(*nfit_memdev), GFP_KERNEL);
> +	struct nfit_memdev *nfit_memdev;
> +
> +	list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list)
> +		if (memcmp(nfit_memdev->memdev, memdev, sizeof(*memdev)) == 0)
> +			return true;
>  
> +	nfit_memdev = devm_kzalloc(dev, sizeof(*nfit_memdev), GFP_KERNEL);
>  	if (!nfit_memdev)
>  		return false;
>  	INIT_LIST_HEAD(&nfit_memdev->list);
> @@ -260,9 +268,13 @@ static bool add_dcr(struct acpi_nfit_desc *acpi_desc,
>  		struct acpi_nfit_control_region *dcr)
>  {
>  	struct device *dev = acpi_desc->dev;
> -	struct nfit_dcr *nfit_dcr = devm_kzalloc(dev, sizeof(*nfit_dcr),
> -			GFP_KERNEL);
> +	struct nfit_dcr *nfit_dcr;
>  
> +	list_for_each_entry(nfit_dcr, &acpi_desc->dcrs, list)
> +		if (memcmp(nfit_dcr->dcr, dcr, sizeof(*dcr)) == 0)
> +			return true;
> +
> +	nfit_dcr = devm_kzalloc(dev, sizeof(*nfit_dcr), GFP_KERNEL);
>  	if (!nfit_dcr)
>  		return false;
>  	INIT_LIST_HEAD(&nfit_dcr->list);
> @@ -277,9 +289,13 @@ static bool add_bdw(struct acpi_nfit_desc *acpi_desc,
>  		struct acpi_nfit_data_region *bdw)
>  {
>  	struct device *dev = acpi_desc->dev;
> -	struct nfit_bdw *nfit_bdw = devm_kzalloc(dev, sizeof(*nfit_bdw),
> -			GFP_KERNEL);
> +	struct nfit_bdw *nfit_bdw;
>  
> +	list_for_each_entry(nfit_bdw, &acpi_desc->bdws, list)
> +		if (memcmp(nfit_bdw->bdw, bdw, sizeof(*bdw)) == 0)
> +			return true;
> +
> +	nfit_bdw = devm_kzalloc(dev, sizeof(*nfit_bdw), GFP_KERNEL);
>  	if (!nfit_bdw)
>  		return false;
>  	INIT_LIST_HEAD(&nfit_bdw->list);
> @@ -294,9 +310,13 @@ static bool add_idt(struct acpi_nfit_desc *acpi_desc,
>  		struct acpi_nfit_interleave *idt)
>  {
>  	struct device *dev = acpi_desc->dev;
> -	struct nfit_idt *nfit_idt = devm_kzalloc(dev, sizeof(*nfit_idt),
> -			GFP_KERNEL);
> +	struct nfit_idt *nfit_idt;
>  
> +	list_for_each_entry(nfit_idt, &acpi_desc->idts, list)
> +		if (memcmp(nfit_idt->idt, idt, sizeof(*idt)) == 0)
> +			return true;
> +
> +	nfit_idt = devm_kzalloc(dev, sizeof(*nfit_idt), GFP_KERNEL);
>  	if (!nfit_idt)
>  		return false;
>  	INIT_LIST_HEAD(&nfit_idt->list);
> @@ -311,9 +331,13 @@ static bool add_flush(struct acpi_nfit_desc *acpi_desc,
>  		struct acpi_nfit_flush_address *flush)
>  {
>  	struct device *dev = acpi_desc->dev;
> -	struct nfit_flush *nfit_flush = devm_kzalloc(dev, sizeof(*nfit_flush),
> -			GFP_KERNEL);
> +	struct nfit_flush *nfit_flush;
>  
> +	list_for_each_entry(nfit_flush, &acpi_desc->flushes, list)
> +		if (memcmp(nfit_flush->flush, flush, sizeof(*flush)) == 0)
> +			return true;
> +
> +	nfit_flush = devm_kzalloc(dev, sizeof(*nfit_flush), GFP_KERNEL);
>  	if (!nfit_flush)
>  		return false;
>  	INIT_LIST_HEAD(&nfit_flush->list);
> @@ -811,6 +835,8 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
>  			 */
>  			dev_err(acpi_desc->dev, "duplicate DCR detected: %s\n",
>  					nvdimm_name(nvdimm));
> +			/* TODO Do we need the warning? */
> +			dimm_count++;
>  			continue;
>  		}
>  
> @@ -1532,6 +1558,8 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
>  		if (!nvdimm_volatile_region_create(nvdimm_bus, ndr_desc))
>  			return -ENOMEM;
>  	}
> +
> +	acpi_desc->last_init_spa = nfit_spa;
>  	return 0;
>  }
>  
> @@ -1539,7 +1567,15 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
>  {
>  	struct nfit_spa *nfit_spa;
>  
> -	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
> +	if (acpi_desc->last_init_spa) {
> +		nfit_spa = acpi_desc->last_init_spa;
> +		nfit_spa = list_next_entry(nfit_spa, list);
> +
> +	} else
> +		nfit_spa = list_first_entry(&acpi_desc->spas,
> +				typeof(*nfit_spa), list);
> +
> +	list_for_each_entry_from(nfit_spa, &acpi_desc->spas, list) {
>  		int rc = acpi_nfit_register_region(acpi_desc, nfit_spa);
>  
>  		if (rc)
> @@ -1590,6 +1626,52 @@ int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, acpi_size sz)
>  }
>  EXPORT_SYMBOL_GPL(acpi_nfit_init);
>  
> +int acpi_nfit_merge(struct acpi_nfit_desc *acpi_desc, acpi_size sz)
> +{
> +	struct device *dev = acpi_desc->dev;
> +	const void *end;
> +	u8 *data;
> +	int rc;
> +
> +	/*
> +	 * TODO Can we get here with an uninitialized acpi_desc?
> +	 * In the case where the only nvdimm in the system is hotplugged?
> +	 */
> +	if (!acpi_desc) {
> +		dev_err(dev, "%s: acpi_desc uninitialized\n", __func__);
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * At this point, acpi_desc->nfit will have the updated nfit table,
> +	 * but the various lists in acpi_dev correspond to the old table.
> +	 */
> +	data = (u8 *) acpi_desc->nfit;
> +	end = data + sz;
> +	data += sizeof(struct acpi_table_nfit);
> +	while (!IS_ERR_OR_NULL(data))
> +		data = add_table(acpi_desc, data, end);
> +
> +	if (IS_ERR(data)) {
> +		dev_dbg(dev, "%s: nfit table parsing error: %ld\n", __func__,
> +				PTR_ERR(data));
> +		return PTR_ERR(data);
> +	}
> +
> +	if (nfit_mem_init(acpi_desc) != 0)
> +		return -ENOMEM;
> +
> +	acpi_nfit_init_dsms(acpi_desc);
> +
> +	rc = acpi_nfit_register_dimms(acpi_desc);
> +	if (rc)
> +		return rc;
> +
> +	rc = acpi_nfit_register_regions(acpi_desc);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(acpi_nfit_merge);
> +
>  static int acpi_nfit_add(struct acpi_device *adev)
>  {
>  	struct nvdimm_bus_descriptor *nd_desc;
> @@ -1639,6 +1721,33 @@ static int acpi_nfit_remove(struct acpi_device *adev)
>  	return 0;
>  }
>  
> +static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> +{
> +	struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(&adev->dev);
> +	struct acpi_table_nfit *nfit_saved;
> +	struct device *dev = &adev->dev;
> +	struct acpi_buffer *buf;
> +	acpi_status status;
> +	int ret;
> +
> +	dev_dbg(dev, "%s: event: %d\n", __func__, event);
> +
> +	/* Evaluate _FIT */
> +	status = acpi_evaluate_fit(adev->handle, &buf);
> +	if (ACPI_FAILURE(status))
> +		dev_err(dev, "failed to evaluate _FIT\n");
> +
> +	nfit_saved = acpi_desc->nfit;
> +	acpi_desc->nfit = (struct acpi_table_nfit *)buf;
> +	ret = acpi_nfit_merge(acpi_desc, buf->length);
> +	if (!ret) {
> +		/* Merge failed, restore old nfit buf, and exit */
> +		acpi_desc->nfit = nfit_saved;
> +		dev_err(dev, "failed to merge updated NFIT\n");
> +	}
> +	kfree(buf->pointer);
> +}
> +
>  static const struct acpi_device_id acpi_nfit_ids[] = {
>  	{ "ACPI0012", 0 },
>  	{ "", 0 },
> @@ -1651,6 +1760,7 @@ static struct acpi_driver acpi_nfit_driver = {
>  	.ops = {
>  		.add = acpi_nfit_add,
>  		.remove = acpi_nfit_remove,
> +		.notify = acpi_nfit_notify,
>  	},
>  };
>  
> diff --git a/drivers/acpi/nfit.h b/drivers/acpi/nfit.h
> index 7e74015..9f4758f 100644
> --- a/drivers/acpi/nfit.h
> +++ b/drivers/acpi/nfit.h
> @@ -105,6 +105,7 @@ struct acpi_nfit_desc {
>  	struct list_head dcrs;
>  	struct list_head bdws;
>  	struct list_head idts;
> +	struct nfit_spa *last_init_spa;
>  	struct nvdimm_bus *nvdimm_bus;
>  	struct device *dev;
>  	unsigned long dimm_dsm_force_en;
> @@ -179,5 +180,6 @@ static inline struct acpi_nfit_desc *to_acpi_desc(
>  
>  const u8 *to_nfit_uuid(enum nfit_uuids id);
>  int acpi_nfit_init(struct acpi_nfit_desc *nfit, acpi_size sz);
> +int acpi_nfit_merge(struct acpi_nfit_desc *acpi_desc, acpi_size sz);
>  extern const struct attribute_group *acpi_nfit_attribute_groups[];
>  #endif /* __NFIT_H__ */
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index 021e6f9..3a7b691 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -44,6 +44,15 @@
>   * +------+  |                 blk5.0             |  pm1.0  |    3      region5
>   *           +-------------------------+----------+-+-------+
>   *
> + * +--+---+
> + * | cpu1 |
> + * +--+---+                   (Hotplug DIMM)
> + *    |      +----------------------------------------------+
> + * +--+---+  |                 blk6.0/pm7.0                 |    4      region6
> + * | imc0 +--+----------------------------------------------+
> + * +------+
> + *
> + *
>   * *) In this layout we have four dimms and two memory controllers in one
>   *    socket.  Each unique interface (BLK or PMEM) to DPA space
>   *    is identified by a region device with a dynamically assigned id.
> @@ -85,8 +94,8 @@
>   *    reference an NVDIMM.
>   */
>  enum {
> -	NUM_PM  = 2,
> -	NUM_DCR = 4,
> +	NUM_PM  = 3,
> +	NUM_DCR = 5,
>  	NUM_BDW = NUM_DCR,
>  	NUM_SPA = NUM_PM + NUM_DCR + NUM_BDW,
>  	NUM_MEM = NUM_DCR + NUM_BDW + 2 /* spa0 iset */ + 4 /* spa1 iset */,
> @@ -115,6 +124,7 @@ static u32 handle[NUM_DCR] = {
>  	[1] = NFIT_DIMM_HANDLE(0, 0, 0, 0, 1),
>  	[2] = NFIT_DIMM_HANDLE(0, 0, 1, 0, 0),
>  	[3] = NFIT_DIMM_HANDLE(0, 0, 1, 0, 1),
> +	[4] = NFIT_DIMM_HANDLE(0, 1, 0, 0, 0),
>  };
>  
>  struct nfit_test {
> @@ -138,6 +148,7 @@ struct nfit_test {
>  	dma_addr_t *dcr_dma;
>  	int (*alloc)(struct nfit_test *t);
>  	void (*setup)(struct nfit_test *t);
> +	int setup_hotplug;
>  };
>  
>  static struct nfit_test *to_nfit_test(struct device *dev)
> @@ -428,6 +439,10 @@ static int nfit_test0_alloc(struct nfit_test *t)
>  	if (!t->spa_set[1])
>  		return -ENOMEM;
>  
> +	t->spa_set[2] = test_alloc_coherent(t, SPA0_SIZE, &t->spa_set_dma[2]);
> +	if (!t->spa_set[2])
> +		return -ENOMEM;
> +
>  	for (i = 0; i < NUM_DCR; i++) {
>  		t->dimm[i] = test_alloc(t, DIMM_SIZE, &t->dimm_dma[i]);
>  		if (!t->dimm[i])
> @@ -950,6 +965,119 @@ static void nfit_test0_setup(struct nfit_test *t)
>  	flush->hint_count = 1;
>  	flush->hint_address[0] = t->flush_dma[3];
>  
> +
> +	if (t->setup_hotplug) {
> +		offset = offset + sizeof(struct acpi_nfit_flush_address) * 4;
> +		/* dcr-descriptor4 */
> +		dcr = nfit_buf + offset;
> +		dcr->header.type = ACPI_NFIT_TYPE_CONTROL_REGION;
> +		dcr->header.length = sizeof(struct acpi_nfit_control_region);
> +		dcr->region_index = 4+1;
> +		dcr->vendor_id = 0xabcd;
> +		dcr->device_id = 0;
> +		dcr->revision_id = 1;
> +		dcr->serial_number = ~handle[4];
> +		dcr->windows = 0;
> +		dcr->window_size = 0;
> +		dcr->command_offset = 0;
> +		dcr->command_size = 0;
> +		dcr->status_offset = 0;
> +		dcr->status_size = 0;
> +
> +		offset = offset + sizeof(struct acpi_nfit_control_region);
> +		/* bdw4 (spa/dcr4, dimm4) */
> +		bdw = nfit_buf + offset;
> +		bdw->header.type = ACPI_NFIT_TYPE_DATA_REGION;
> +		bdw->header.length = sizeof(struct acpi_nfit_data_region);
> +		bdw->region_index = 4+1;
> +		bdw->windows = 1;
> +		bdw->offset = 0;
> +		bdw->size = BDW_SIZE;
> +		bdw->capacity = DIMM_SIZE;
> +		bdw->start_address = 0;
> +
> +		offset = offset + sizeof(struct acpi_nfit_data_region);
> +		/* spa10 (dcr4) dimm4 */
> +		spa = nfit_buf + offset;
> +		spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> +		spa->header.length = sizeof(*spa);
> +		memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
> +		spa->range_index = 10+1;
> +		spa->address = t->dcr_dma[4];
> +		spa->length = DCR_SIZE;
> +
> +		/*
> +		 * spa11 (single-dimm interleave for hotplug, note storage
> +		 * does not actually alias the related block-data-window
> +		 * regions)
> +		 */
> +		spa = nfit_buf + offset + sizeof(*spa);
> +		spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> +		spa->header.length = sizeof(*spa);
> +		memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_PM), 16);
> +		spa->range_index = 11+1;
> +		spa->address = t->spa_set_dma[2];
> +		spa->length = SPA0_SIZE;
> +
> +		/* spa12 (bdw for dcr4) dimm4 */
> +		spa = nfit_buf + offset + sizeof(*spa) * 2;
> +		spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> +		spa->header.length = sizeof(*spa);
> +		memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
> +		spa->range_index = 12+1;
> +		spa->address = t->dimm_dma[4];
> +		spa->length = DIMM_SIZE;
> +
> +		offset = offset + sizeof(*spa) * 3;
> +		/* mem-region14 (spa/dcr4, dimm4) */
> +		memdev = nfit_buf + offset;
> +		memdev->header.type = ACPI_NFIT_TYPE_MEMORY_MAP;
> +		memdev->header.length = sizeof(*memdev);
> +		memdev->device_handle = handle[4];
> +		memdev->physical_id = 4;
> +		memdev->region_id = 0;
> +		memdev->range_index = 10+1;
> +		memdev->region_index = 4+1;
> +		memdev->region_size = 0;
> +		memdev->region_offset = 0;
> +		memdev->address = 0;
> +		memdev->interleave_index = 0;
> +		memdev->interleave_ways = 1;
> +
> +		/* mem-region15 (spa0, dimm4) */
> +		memdev = nfit_buf + offset +
> +				sizeof(struct acpi_nfit_memory_map);
> +		memdev->header.type = ACPI_NFIT_TYPE_MEMORY_MAP;
> +		memdev->header.length = sizeof(*memdev);
> +		memdev->device_handle = handle[4];
> +		memdev->physical_id = 4;
> +		memdev->region_id = 0;
> +		memdev->range_index = 11+1;
> +		memdev->region_index = 4+1;
> +		memdev->region_size = SPA0_SIZE;
> +		memdev->region_offset = t->spa_set_dma[2];
> +		memdev->address = 0;
> +		memdev->interleave_index = 0;
> +		memdev->interleave_ways = 1;
> +
> +		/* mem-region16 (spa/dcr4, dimm4) */
> +		memdev = nfit_buf + offset +
> +				sizeof(struct acpi_nfit_memory_map) * 2;
> +		memdev->header.type = ACPI_NFIT_TYPE_MEMORY_MAP;
> +		memdev->header.length = sizeof(*memdev);
> +		memdev->device_handle = handle[4];
> +		memdev->physical_id = 4;
> +		memdev->region_id = 0;
> +		memdev->range_index = 12+1;
> +		memdev->region_index = 4+1;
> +		memdev->region_size = 0;
> +		memdev->region_offset = 0;
> +		memdev->address = 0;
> +		memdev->interleave_index = 0;
> +		memdev->interleave_ways = 1;
> +
> +	}
> +
>  	acpi_desc = &t->acpi_desc;
>  	set_bit(ND_CMD_GET_CONFIG_SIZE, &acpi_desc->dimm_dsm_force_en);
>  	set_bit(ND_CMD_GET_CONFIG_DATA, &acpi_desc->dimm_dsm_force_en);
> @@ -1114,6 +1242,18 @@ static int nfit_test_probe(struct platform_device *pdev)
>  		return rc;
>  	}
>  
> +	if (nfit_test->setup != nfit_test0_setup)
> +		return 0;
> +
> +	nfit_test->setup_hotplug = 1;
> +	nfit_test->setup(nfit_test);
> +
> +	rc = acpi_nfit_merge(acpi_desc, nfit_test->nfit_size);
> +	if (rc) {
> +		nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
> +		return rc;
> +	}
> +
>  	return 0;
>  }
