From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] libnvdimm: fix smart data retrieval
Date: Wed, 06 Apr 2016 17:53:44 -0700
Message-ID: <20160407005344.30117.84197.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18982 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbcDGAyl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Apr 2016 20:54:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

It appears that smart data retrieval has been broken the since the
initial implementation.  Fix the payload size to be 128-bytes per the
specification.

Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index fc82743aefb6..19f822d7f652 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -407,7 +407,7 @@ static const struct nd_cmd_desc __nd_cmd_dimm_descs[] = {
 	[ND_CMD_IMPLEMENTED] = { },
 	[ND_CMD_SMART] = {
 		.out_num = 2,
-		.out_sizes = { 4, 8, },
+		.out_sizes = { 4, 128, },
 	},
 	[ND_CMD_SMART_THRESHOLD] = {
 		.out_num = 2,

