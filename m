From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 1/3] badblocks: add null checks for bb in the badblocks api
Date: Thu, 14 Jan 2016 18:31:54 -0700
Message-ID: <1452821516-26788-2-git-send-email-vishal.l.verma@intel.com>
References: <1452821516-26788-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21756 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbcAOBcI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 20:32:08 -0500
In-Reply-To: <1452821516-26788-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Linda Knippers <linda.knippers@hpe.com>

The move from gendisk wrappers for badblocks functions to
directly using them meant we lost some checks for !disk->bb
Re-add those checks into the badblocks functions so all
users get the checks.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 block/badblocks.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 7be53cb..aa5e0a1 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -68,6 +68,9 @@ int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	sector_t target = s + sectors;
 	unsigned seq;
 
+	if (!bb)
+		return 0;
+
 	if (bb->shift > 0) {
 		/* round the start down, and the end up */
 		s >>= bb->shift;
@@ -156,7 +159,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 	int rv = 0;
 	unsigned long flags;
 
-	if (bb->shift < 0)
+	if (!bb || bb->shift < 0)
 		/* badblocks are disabled */
 		return 0;
 
@@ -321,6 +324,9 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 	sector_t target = s + sectors;
 	int rv = 0;
 
+	if (!bb)
+		return 0;
+
 	if (bb->shift > 0) {
 		/* When clearing we round the start up and the end down.
 		 * This should not matter as the shift should align with
@@ -415,7 +421,7 @@ EXPORT_SYMBOL_GPL(badblocks_clear);
  */
 void ack_all_badblocks(struct badblocks *bb)
 {
-	if (bb->page == NULL || bb->changed)
+	if (!bb || bb->page == NULL || bb->changed)
 		/* no point even trying */
 		return;
 	write_seqlock_irq(&bb->lock);
@@ -451,11 +457,13 @@ ssize_t badblocks_show(struct badblocks *bb, char *page, int unack)
 {
 	size_t len;
 	int i;
-	u64 *p = bb->page;
+	u64 *p;
 	unsigned seq;
 
-	if (bb->shift < 0)
-		return 0;
+	if (!bb || bb->shift < 0)
+		return sprintf(page, "\n");
+
+	p = bb->page;
 
 retry:
 	seq = read_seqbegin(&bb->lock);
@@ -504,6 +512,9 @@ ssize_t badblocks_store(struct badblocks *bb, const char *page, size_t len,
 	int length;
 	char newline;
 
+	if (!bb)
+		return -ENXIO;
+
 	switch (sscanf(page, "%llu %d%c", &sector, &length, &newline)) {
 	case 3:
 		if (newline != '\n')
-- 
2.5.0

