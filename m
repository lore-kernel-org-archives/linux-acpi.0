From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2/2] nfit: update address range scrub commands to the acpi
 6.1 format
Date: Sat, 20 Feb 2016 14:46:48 -0800
Message-ID: <20160220224648.20667.43800.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20160220224637.20667.84618.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60370 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759607AbcBTWrN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Feb 2016 17:47:13 -0500
In-Reply-To: <20160220224637.20667.84618.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Linda Knippers <linda.knippers@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>, stable@vger.kernel.org, linux-acpi@vger.kernel.org

The original format of these commands from the "NVDIMM DSM Interface
Example" [1] are superseded by the ACPI 6.1 definition of the "NVDIMM Root
Device _DSMs" [2].

[1]: http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
[2]: http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf
     "9.20.7 NVDIMM Root Device _DSMs"

Changes include:
1/ New 'restart' fields in ars_status, unfortunately these are
   implemented in the middle of the existing definition so this change
   is not backwards compatible.  The expectation is that shipping
   platforms will only ever support the ACPI 6.1 definition.

2/ New status values for ars_start ('busy') and ars_status ('overflow').

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Linda Knippers <linda.knippers@hpe.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit.c        |    6 +++---
 drivers/nvdimm/bus.c       |   12 ++++++------
 include/linux/libnvdimm.h  |    2 +-
 include/uapi/linux/ndctl.h |   11 +++++++++--
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index 424b362e8fdc..3edb1324b9d5 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -1503,9 +1503,7 @@ static int ars_do_start(struct nvdimm_bus_descriptor *nd_desc,
 		case 1:
 			/* ARS unsupported, but we should never get here */
 			return 0;
-		case 2:
-			return -EINVAL;
-		case 3:
+		case 6:
 			/* ARS is in progress */
 			msleep(1000);
 			break;
@@ -1537,6 +1535,8 @@ static int ars_get_status(struct nvdimm_bus_descriptor *nd_desc,
 		case 2:
 			/* No ARS performed for the current boot */
 			return 0;
+		case 3:
+			/* TODO: error list overflow support */
 		default:
 			return -ENXIO;
 		}
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 99953b34fa1d..5d28e9405f32 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -382,14 +382,14 @@ static const struct nd_cmd_desc __nd_cmd_bus_descs[] = {
 	[ND_CMD_ARS_CAP] = {
 		.in_num = 2,
 		.in_sizes = { 8, 8, },
-		.out_num = 2,
-		.out_sizes = { 4, 4, },
+		.out_num = 4,
+		.out_sizes = { 4, 4, 4, 4, },
 	},
 	[ND_CMD_ARS_START] = {
-		.in_num = 4,
-		.in_sizes = { 8, 8, 2, 6, },
-		.out_num = 1,
-		.out_sizes = { 4, },
+		.in_num = 5,
+		.in_sizes = { 8, 8, 2, 1, 5, },
+		.out_num = 2,
+		.out_sizes = { 4, 4, },
 	},
 	[ND_CMD_ARS_STATUS] = {
 		.out_num = 3,
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index c736382fd260..141ffdd59960 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -26,7 +26,7 @@ enum {
 
 	/* need to set a limit somewhere, but yes, this is likely overkill */
 	ND_IOCTL_MAX_BUFLEN = SZ_4M,
-	ND_CMD_MAX_ELEM = 4,
+	ND_CMD_MAX_ELEM = 5,
 	ND_CMD_MAX_ENVELOPE = 16,
 	ND_MAX_MAPPINGS = 32,
 
diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index 5b4a4be06e2b..cc68b92124d4 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -66,14 +66,18 @@ struct nd_cmd_ars_cap {
 	__u64 length;
 	__u32 status;
 	__u32 max_ars_out;
+	__u32 clear_err_unit;
+	__u32 reserved;
 } __packed;
 
 struct nd_cmd_ars_start {
 	__u64 address;
 	__u64 length;
 	__u16 type;
-	__u8 reserved[6];
+	__u8 flags;
+	__u8 reserved[5];
 	__u32 status;
+	__u32 scrub_time;
 } __packed;
 
 struct nd_cmd_ars_status {
@@ -81,11 +85,14 @@ struct nd_cmd_ars_status {
 	__u32 out_length;
 	__u64 address;
 	__u64 length;
+	__u64 restart_address;
+	__u64 restart_length;
 	__u16 type;
+	__u16 flags;
 	__u32 num_records;
 	struct nd_ars_record {
 		__u32 handle;
-		__u32 flags;
+		__u32 reserved;
 		__u64 err_address;
 		__u64 length;
 	} __packed records[0];

