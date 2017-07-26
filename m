From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v4 3/6] btt: ensure that flags were also unchanged during a map_read
Date: Wed, 26 Jul 2017 17:35:43 -0600
Message-ID: <20170726233546.29052-4-vishal.l.verma@intel.com>
References: <20170726233546.29052-1-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:21047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbdGZXho (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jul 2017 19:37:44 -0400
In-Reply-To: <20170726233546.29052-1-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>

In btt_map_read, we read the map twice to make sure that the map entry
didn't change after we added it to the read tracking table. In
anticipation of expanding the use of the error bit, also make sure that
the error and zero flags are constant across the two map reads.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/nvdimm/btt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 8842baa..374ae62 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1032,6 +1032,7 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 		 */
 		while (1) {
 			u32 new_map;
+			int new_t, new_e;
 
 			if (t_flag) {
 				zero_fill_data(page, off, cur_len);
@@ -1050,15 +1051,18 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 			 */
 			barrier();
 
-			ret = btt_map_read(arena, premap, &new_map, &t_flag,
-						&e_flag, NVDIMM_IO_ATOMIC);
+			ret = btt_map_read(arena, premap, &new_map, &new_t,
+						&new_e, NVDIMM_IO_ATOMIC);
 			if (ret)
 				goto out_rtt;
 
-			if (postmap == new_map)
+			if ((postmap == new_map) && (t_flag == new_t) &&
+					(e_flag == new_e))
 				break;
 
 			postmap = new_map;
+			t_flag = new_t;
+			e_flag = new_e;
 		}
 
 		ret = btt_data_read(arena, page, off, postmap, cur_len);
-- 
2.9.3

