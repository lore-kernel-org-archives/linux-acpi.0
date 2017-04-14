From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 6/7] acpi,
 nfit: limit ->flush_probe() to initialization work
Date: Fri, 14 Apr 2017 14:57:37 -0700
Message-ID: <149220705756.36563.14401124380313786346.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149220702552.36563.10552898152402020832.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44587 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754794AbdDNWDW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Apr 2017 18:03:22 -0400
In-Reply-To: <149220702552.36563.10552898152402020832.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org

The nvdimm probe flushing mechanism gives userspace a sync point where
it knows all asynchronous driver probe sequences have completed.
However, it need not wait for other asynchronous actions, like
on-demand address-range-scrub. Track the init work separately from other
work in the workqueue, and only flush the former.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    7 +++++++
 drivers/acpi/nfit/nfit.h |    1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 1d54833ade3f..69c6cc77130c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2581,6 +2581,7 @@ static void acpi_nfit_scrub(struct work_struct *work)
 			acpi_nfit_register_region(acpi_desc, nfit_spa);
 		}
 	}
+	acpi_desc->init_complete = 1;
 
 	list_for_each_entry(nfit_spa, &acpi_desc->spas, list)
 		acpi_nfit_async_scrub(acpi_desc, nfit_spa);
@@ -2784,6 +2785,12 @@ static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
 	device_lock(dev);
 	device_unlock(dev);
 
+	/* bounce the init_mutex to make init_complete valid */
+	mutex_lock(&acpi_desc->init_mutex);
+	mutex_unlock(&acpi_desc->init_mutex);
+	if (acpi_desc->init_complete)
+		return 0;
+
 	/*
 	 * Scrub work could take 10s of seconds, userspace may give up so we
 	 * need to be interruptible while waiting.
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index aaabd2721f8e..fac098bfa585 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -163,6 +163,7 @@ struct acpi_nfit_desc {
 	unsigned int scrub_count;
 	unsigned int scrub_mode;
 	unsigned int cancel:1;
+	unsigned int init_complete:1;
 	unsigned long dimm_cmd_force_en;
 	unsigned long bus_cmd_force_en;
 	int (*blk_do_io)(struct nd_blk_region *ndbr, resource_size_t dpa,

