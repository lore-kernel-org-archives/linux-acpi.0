From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/2] libnvdimm,
 tools/testing/nvdimm: fix 'ars_status' output buffer sizing
Date: Sat, 20 Feb 2016 14:46:43 -0800
Message-ID: <20160220224643.20667.43436.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20160220224637.20667.84618.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:54549 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759607AbcBTWrH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Feb 2016 17:47:07 -0500
In-Reply-To: <20160220224637.20667.84618.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org

Use the output length specified in the command to size the receive
buffer rather than the arbitrary 4K limit.

This bug was hiding the fact that the ndctl implementation of
ndctl_bus_cmd_new_ars_status() was not specifying an output buffer size.

Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/bus.c             |    8 ++++----
 include/linux/libnvdimm.h        |    1 -
 tools/testing/nvdimm/test/nfit.c |    8 ++++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 7e2c43f701bc..99953b34fa1d 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -392,8 +392,8 @@ static const struct nd_cmd_desc __nd_cmd_bus_descs[] = {
 		.out_sizes = { 4, },
 	},
 	[ND_CMD_ARS_STATUS] = {
-		.out_num = 2,
-		.out_sizes = { 4, UINT_MAX, },
+		.out_num = 3,
+		.out_sizes = { 4, 4, UINT_MAX, },
 	},
 };
 
@@ -442,8 +442,8 @@ u32 nd_cmd_out_size(struct nvdimm *nvdimm, int cmd,
 		return in_field[1];
 	else if (nvdimm && cmd == ND_CMD_VENDOR && idx == 2)
 		return out_field[1];
-	else if (!nvdimm && cmd == ND_CMD_ARS_STATUS && idx == 1)
-		return ND_CMD_ARS_STATUS_MAX;
+	else if (!nvdimm && cmd == ND_CMD_ARS_STATUS && idx == 2)
+		return out_field[1] - 8;
 
 	return UINT_MAX;
 }
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index bed40dff0e86..c736382fd260 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -28,7 +28,6 @@ enum {
 	ND_IOCTL_MAX_BUFLEN = SZ_4M,
 	ND_CMD_MAX_ELEM = 4,
 	ND_CMD_MAX_ENVELOPE = 16,
-	ND_CMD_ARS_STATUS_MAX = SZ_4K,
 	ND_MAX_MAPPINGS = 32,
 
 	/* region flag indicating to direct-map persistent memory by default */
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 90bd2ea41032..b3281dcd4a5d 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -217,13 +217,16 @@ static int nfit_test_cmd_set_config_data(struct nd_cmd_set_config_hdr *nd_cmd,
 	return rc;
 }
 
+#define NFIT_TEST_ARS_RECORDS 4
+
 static int nfit_test_cmd_ars_cap(struct nd_cmd_ars_cap *nd_cmd,
 		unsigned int buf_len)
 {
 	if (buf_len < sizeof(*nd_cmd))
 		return -EINVAL;
 
-	nd_cmd->max_ars_out = 256;
+	nd_cmd->max_ars_out = sizeof(struct nd_cmd_ars_status)
+		+ NFIT_TEST_ARS_RECORDS * sizeof(struct nd_ars_record);
 	nd_cmd->status = (ND_ARS_PERSISTENT | ND_ARS_VOLATILE) << 16;
 
 	return 0;
@@ -246,7 +249,8 @@ static int nfit_test_cmd_ars_status(struct nd_cmd_ars_status *nd_cmd,
 	if (buf_len < sizeof(*nd_cmd))
 		return -EINVAL;
 
-	nd_cmd->out_length = 256;
+	nd_cmd->out_length = sizeof(struct nd_cmd_ars_status);
+	/* TODO: emit error records */
 	nd_cmd->num_records = 0;
 	nd_cmd->address = 0;
 	nd_cmd->length = -1ULL;

