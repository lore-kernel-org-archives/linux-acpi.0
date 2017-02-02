From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] acpi, nfit: fix acpi_nfit_flush_probe() crash
Date: Thu, 02 Feb 2017 10:53:02 -0800
Message-ID: <148606158246.11883.8248896172906265924.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11803 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdBBS5I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 13:57:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, stable@vger.kernel.org, linux-acpi@vger.kernel.org

We queue an on-stack work item to 'nfit_wq' and wait for it to complete
as part of a 'flush_probe' request. However, if the user cancels the
wait we need to make sure the item is flushed from the queue otherwise
we are leaving an out-of-scope stack address on the work list.

 BUG: unable to handle kernel paging request at ffffbcb3c72f7cd0
 IP: [<ffffffffa9413a7b>] __list_add+0x1b/0xb0
 [..]
 RIP: 0010:[<ffffffffa9413a7b>]  [<ffffffffa9413a7b>] __list_add+0x1b/0xb0
 RSP: 0018:ffffbcb3c7ba7c00  EFLAGS: 00010046
 [..]
 Call Trace:
  [<ffffffffa90bb11a>] insert_work+0x3a/0xc0
  [<ffffffffa927fdda>] ? seq_open+0x5a/0xa0
  [<ffffffffa90bb30a>] __queue_work+0x16a/0x460
  [<ffffffffa90bbb08>] queue_work_on+0x38/0x40
  [<ffffffffc0cf2685>] acpi_nfit_flush_probe+0x95/0xc0 [nfit]
  [<ffffffffc0cf25d0>] ? nfit_visible+0x40/0x40 [nfit]
  [<ffffffffa9571495>] wait_probe_show+0x25/0x60
  [<ffffffffa9546b30>] dev_attr_show+0x20/0x50

Fixes: 7ae0fa439faf ("nfit, libnvdimm: async region scrub workqueue")
Cc: <stable@vger.kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 2f82b8eba360..7361d00818e2 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2704,6 +2704,7 @@ static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
 	struct acpi_nfit_desc *acpi_desc = to_acpi_nfit_desc(nd_desc);
 	struct device *dev = acpi_desc->dev;
 	struct acpi_nfit_flush_work flush;
+	int rc;
 
 	/* bounce the device lock to flush acpi_nfit_add / acpi_nfit_notify */
 	device_lock(dev);
@@ -2716,7 +2717,10 @@ static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
 	INIT_WORK_ONSTACK(&flush.work, flush_probe);
 	COMPLETION_INITIALIZER_ONSTACK(flush.cmp);
 	queue_work(nfit_wq, &flush.work);
-	return wait_for_completion_interruptible(&flush.cmp);
+
+	rc = wait_for_completion_interruptible(&flush.cmp);
+	cancel_work_sync(&flush.work);
+	return rc;
 }
 
 static int acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,

