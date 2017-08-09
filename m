From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v5 1/7] btt: fix a missed NVDIMM_IO_ATOMIC case in the write path
Date: Tue,  8 Aug 2017 18:07:40 -0600
Message-ID: <20170809000746.10585-2-vishal.l.verma@intel.com>
References: <20170809000746.10585-1-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14947 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752047AbdHIAJi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Aug 2017 20:09:38 -0400
In-Reply-To: <20170809000746.10585-1-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>

The IO context conversion for rw_bytes missed a case in the BTT write
path (btt_map_write) which should've been marked as atomic.

In reality this should not cause a problem, because map writes are to
small for nsio_rw_bytes to attempt error clearing, but it should be
fixed for posterity.

Add a might_sleep() in the non-atomic section of nsio_rw_bytes so that
things like the nfit unit tests, which don't actually sleep, can catch
bugs like this.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/nvdimm/btt.c   | 3 ++-
 drivers/nvdimm/claim.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 14323fa..f6ea82f 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1156,7 +1156,8 @@ static int btt_write_pg(struct btt *btt, struct bio_integrity_payload *bip,
 		if (ret)
 			goto out_map;
 
-		ret = btt_map_write(arena, premap, new_postmap, 0, 0, 0);
+		ret = btt_map_write(arena, premap, new_postmap, 0, 0,
+			NVDIMM_IO_ATOMIC);
 		if (ret)
 			goto out_map;
 
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 4777046..3e6404f 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -292,6 +292,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 				&& !(flags & NVDIMM_IO_ATOMIC)) {
 			long cleared;
 
+			might_sleep();
 			cleared = nvdimm_clear_poison(&ndns->dev,
 					nsio->res.start + offset, size);
 			if (cleared < size)
-- 
2.9.3

