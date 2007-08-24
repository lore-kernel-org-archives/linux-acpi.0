From: Len Brown <len.brown@intel.com>
Subject: [PATCH 20/25] PNPACPI: remove unnecessary casts of "void *"
Date: Fri, 24 Aug 2007 03:21:07 -0400
Message-ID: <11879400963954-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
 <11879400892741-git-send-email-len.brown@intel.com>
 <11879400903190-git-send-email-len.brown@intel.com>
 <11879400911609-git-send-email-len.brown@intel.com>
 <11879400921598-git-send-email-len.brown@intel.com>
 <11879400933976-git-send-email-len.brown@intel.com>
 <1187940094867-git-send-email-len.brown@intel.com>
 <11879400951708-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4204 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763385AbXHXHVi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:38 -0400
In-Reply-To: <11879400951708-git-send-email-len.brown@intel.com>
Message-Id: <4721a4cc8864f0eb92958c3e0479e7994e8b0072.1187939443.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Remove unnecessary casts of void pointers.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Adam Belay <abelay@novell.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index a0784fe..0e3b8d0 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -240,8 +240,7 @@ static void pnpacpi_parse_allocated_address_space(struct pnp_resource_table *res
 static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 					      void *data)
 {
-	struct pnp_resource_table *res_table =
-	    (struct pnp_resource_table *)data;
+	struct pnp_resource_table *res_table = data;
 	int i;
 
 	switch (res->type) {
@@ -564,8 +563,7 @@ static acpi_status pnpacpi_option_resource(struct acpi_resource *res,
 					   void *data)
 {
 	int priority = 0;
-	struct acpipnp_parse_option_s *parse_data =
-	    (struct acpipnp_parse_option_s *)data;
+	struct acpipnp_parse_option_s *parse_data = data;
 	struct pnp_dev *dev = parse_data->dev;
 	struct pnp_option *option = parse_data->option;
 
@@ -703,7 +701,7 @@ static int pnpacpi_supported_resource(struct acpi_resource *res)
 static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
 					   void *data)
 {
-	int *res_cnt = (int *)data;
+	int *res_cnt = data;
 
 	if (pnpacpi_supported_resource(res))
 		(*res_cnt)++;
@@ -712,7 +710,7 @@ static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
 
 static acpi_status pnpacpi_type_resources(struct acpi_resource *res, void *data)
 {
-	struct acpi_resource **resource = (struct acpi_resource **)data;
+	struct acpi_resource **resource = data;
 
 	if (pnpacpi_supported_resource(res)) {
 		(*resource)->type = res->type;
@@ -884,8 +882,7 @@ int pnpacpi_encode_resources(struct pnp_resource_table *res_table,
 	int i = 0;
 	/* pnpacpi_build_resource_template allocates extra mem */
 	int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
-	struct acpi_resource *resource =
-	    (struct acpi_resource *)buffer->pointer;
+	struct acpi_resource *resource = buffer->pointer;
 	int port = 0, irq = 0, dma = 0, mem = 0;
 
 	pnp_dbg("res cnt %d", res_cnt);
-- 
1.5.3.rc6.17.g1911
