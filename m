From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 4/6] btt: cache sector_size in arena_info
Date: Fri, 14 Jul 2017 16:11:46 -0600
Message-ID: <20170714221148.11232-5-vishal.l.verma@intel.com>
References: <20170714221148.11232-1-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:46348 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdGNWNb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jul 2017 18:13:31 -0400
In-Reply-To: <20170714221148.11232-1-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>

In preparation for the error clearing rework, add sector_size in the
arena_info struct.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/nvdimm/btt.c | 1 +
 drivers/nvdimm/btt.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 304dac4..6b84eae 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -566,6 +566,7 @@ static struct arena_info *alloc_arena(struct btt *btt, size_t size,
 	if (!arena)
 		return NULL;
 	arena->nd_btt = btt->nd_btt;
+	arena->sector_size = btt->sector_size;
 
 	if (!size)
 		return arena;
diff --git a/drivers/nvdimm/btt.h b/drivers/nvdimm/btt.h
index 09fabf5..2bc0d10b 100644
--- a/drivers/nvdimm/btt.h
+++ b/drivers/nvdimm/btt.h
@@ -108,6 +108,7 @@ struct aligned_lock {
  *			handle incoming writes.
  * @version_major:	Metadata layout version major.
  * @version_minor:	Metadata layout version minor.
+ * @sector_size:	The Linux sector size - 512 or 4096
  * @nextoff:		Offset in bytes to the start of the next arena.
  * @infooff:		Offset in bytes to the info block of this arena.
  * @dataoff:		Offset in bytes to the data area of this arena.
@@ -135,6 +136,7 @@ struct arena_info {
 	u32 nfree;
 	u16 version_major;
 	u16 version_minor;
+	u32 sector_size;
 	/* Byte offsets to the different on-media structures */
 	u64 nextoff;
 	u64 infooff;
-- 
2.9.3

