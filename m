From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 3/6] PNPACPI: remove unnecessary casts of "void *"
Date: Wed, 15 Aug 2007 10:32:10 -0600
Message-ID: <20070815163432.511810658@ldl.fc.hp.com>
References: <20070815163207.062263984@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:52416 "EHLO
	tayrelbas01.tay.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766003AbXHOQxe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Aug 2007 12:53:34 -0400
Content-Disposition: inline; filename=pnp-remove-unnecessary-casts
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Remove unnecessary casts of void pointers.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- w.orig/drivers/pnp/pnpacpi/rsparser.c	2007-08-15 09:47:43.000000000 -0600
+++ w/drivers/pnp/pnpacpi/rsparser.c	2007-08-15 09:47:48.000000000 -0600
@@ -240,8 +240,7 @@
 static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 					      void *data)
 {
-	struct pnp_resource_table *res_table =
-	    (struct pnp_resource_table *)data;
+	struct pnp_resource_table *res_table = data;
 	int i;
 
 	switch (res->type) {
@@ -564,8 +563,7 @@
 					   void *data)
 {
 	int priority = 0;
-	struct acpipnp_parse_option_s *parse_data =
-	    (struct acpipnp_parse_option_s *)data;
+	struct acpipnp_parse_option_s *parse_data = data;
 	struct pnp_dev *dev = parse_data->dev;
 	struct pnp_option *option = parse_data->option;
 
@@ -703,7 +701,7 @@
 static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
 					   void *data)
 {
-	int *res_cnt = (int *)data;
+	int *res_cnt = data;
 
 	if (pnpacpi_supported_resource(res))
 		(*res_cnt)++;
@@ -712,7 +710,7 @@
 
 static acpi_status pnpacpi_type_resources(struct acpi_resource *res, void *data)
 {
-	struct acpi_resource **resource = (struct acpi_resource **)data;
+	struct acpi_resource **resource = data;
 
 	if (pnpacpi_supported_resource(res)) {
 		(*resource)->type = res->type;
@@ -884,8 +882,7 @@
 	int i = 0;
 	/* pnpacpi_build_resource_template allocates extra mem */
 	int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
-	struct acpi_resource *resource =
-	    (struct acpi_resource *)buffer->pointer;
+	struct acpi_resource *resource = buffer->pointer;
 	int port = 0, irq = 0, dma = 0, mem = 0;
 
 	pnp_dbg("res cnt %d", res_cnt);

--
