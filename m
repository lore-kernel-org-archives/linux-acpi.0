From: Len Brown <len.brown@intel.com>
Subject: [PATCH 006/105] ACPI: EC: Remove casts to/from void* from ec.c
Date: Sun, 29 Apr 2007 00:50:06 -0400
Message-ID: <1177822310688-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57052 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754589AbXD2Evw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:52 -0400
In-Reply-To: <1177822309524-git-send-email-len.brown@intel.com>
Message-Id: <3d02b90be2c7bc7ffbc5e502a135c13838d23ef4.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e7ce6e4..1989631 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -406,7 +406,7 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 * data)
 
 static void acpi_ec_gpe_query(void *ec_cxt)
 {
-	struct acpi_ec *ec = (struct acpi_ec *)ec_cxt;
+	struct acpi_ec *ec = ec_cxt;
 	u8 value = 0;
 	char object_name[8];
 
@@ -424,8 +424,9 @@ static u32 acpi_ec_gpe_handler(void *data)
 {
 	acpi_status status = AE_OK;
 	u8 value;
-	struct acpi_ec *ec = (struct acpi_ec *)data;
+	struct acpi_ec *ec = data;
 	atomic_inc(&ec->event_count);
+
 	if (acpi_ec_mode == EC_INTR) {
 		wake_up(&ec->wait);
 	}
@@ -468,7 +469,7 @@ acpi_ec_space_handler(u32 function,
 		      void *handler_context, void *region_context)
 {
 	int result = 0;
-	struct acpi_ec *ec = NULL;
+	struct acpi_ec *ec = handler_context;
 	u64 temp = *value;
 	acpi_integer f_v = 0;
 	int i = 0;
@@ -480,8 +481,6 @@ acpi_ec_space_handler(u32 function,
 		return AE_BAD_PARAMETER;
 	}
 
-	ec = (struct acpi_ec *)handler_context;
-
       next_byte:
 	switch (function) {
 	case ACPI_READ:
@@ -537,7 +536,7 @@ static struct proc_dir_entry *acpi_ec_dir;
 
 static int acpi_ec_read_info(struct seq_file *seq, void *offset)
 {
-	struct acpi_ec *ec = (struct acpi_ec *)seq->private;
+	struct acpi_ec *ec = seq->private;
 
 	if (!ec)
 		goto end;
@@ -694,7 +693,7 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 static acpi_status
 acpi_ec_io_ports(struct acpi_resource *resource, void *context)
 {
-	struct acpi_ec *ec = (struct acpi_ec *)context;
+	struct acpi_ec *ec = context;
 
 	if (resource->type != ACPI_RESOURCE_TYPE_IO) {
 		return AE_OK;
-- 
1.5.2.rc0.34.gda94
