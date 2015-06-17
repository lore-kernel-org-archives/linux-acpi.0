From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 13/15] libnvdimm: flag libnvdimm block devices as
 non-rotational
Date: Wed, 17 Jun 2015 19:55:57 -0400
Message-ID: <20150617235557.12943.75518.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150617235209.12943.24419.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32642 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499AbbFQX6i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jun 2015 19:58:38 -0400
In-Reply-To: <20150617235209.12943.24419.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: axboe@kernel.dk, linux-nvdimm@lists.01.org
Cc: boaz@plexistor.com, toshi.kani@hp.com, Vishal Verma <vishal.l.verma@linux.intel.com>, linux-kernel@vger.kernel.org, hch@lst.de, linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org, mingo@kernel.org

...since they are effectively SSDs as far as userspace is concerned.

Reviewed-by: Vishal Verma <vishal.l.verma@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 99cf95af5f24..fa82f215990d 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -220,6 +220,7 @@ void nd_blk_queue_init(struct request_queue *q)
 	blk_queue_bounce_limit(q, BLK_BOUNCE_ANY);
 	if (IS_ENABLED(CONFIG_ND_IOSTAT))
 		queue_flag_set_unlocked(QUEUE_FLAG_IO_STAT, q);
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
 }
 EXPORT_SYMBOL(nd_blk_queue_init);
 

