From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] acpi: fix apei related table size checking
Date: Fri, 23 Jul 2010 10:39:17 -0700
Message-ID: <4C49D3C5.4000007@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:40390 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab0GWRkV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jul 2010 13:40:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Andi Kleen <ak@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>, Daniel J Blueman <daniel.blueman@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


also check if we can find right action in apei.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/acpi/apei/apei-base.c |    5 +++++
 drivers/acpi/apei/einj.c      |    3 ++-
 drivers/acpi/apei/erst.c      |    3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/apei/einj.c
===================================================================
--- linux-2.6.orig/drivers/acpi/apei/einj.c
+++ linux-2.6/drivers/acpi/apei/einj.c
@@ -426,7 +426,8 @@ DEFINE_SIMPLE_ATTRIBUTE(error_inject_fop
 
 static int einj_check_table(struct acpi_table_einj *einj_tab)
 {
-	if (einj_tab->header_length != sizeof(struct acpi_table_einj))
+	if (einj_tab->header_length !=
+	    (sizeof(struct acpi_table_einj) - sizeof(einj_tab->header)))
 		return -EINVAL;
 	if (einj_tab->header.length < sizeof(struct acpi_table_einj))
 		return -EINVAL;
Index: linux-2.6/drivers/acpi/apei/erst.c
===================================================================
--- linux-2.6.orig/drivers/acpi/apei/erst.c
+++ linux-2.6/drivers/acpi/apei/erst.c
@@ -749,7 +749,8 @@ __setup("erst_disable", setup_erst_disab
 
 static int erst_check_table(struct acpi_table_erst *erst_tab)
 {
-	if (erst_tab->header_length != sizeof(struct acpi_table_erst))
+	if (erst_tab->header_length !=
+	    (sizeof(struct acpi_table_erst) - sizeof(erst_tab->header)))
 		return -EINVAL;
 	if (erst_tab->header.length < sizeof(struct acpi_table_erst))
 		return -EINVAL;
Index: linux-2.6/drivers/acpi/apei/apei-base.c
===================================================================
--- linux-2.6.orig/drivers/acpi/apei/apei-base.c
+++ linux-2.6/drivers/acpi/apei/apei-base.c
@@ -163,6 +163,7 @@ int apei_exec_run(struct apei_exec_conte
 	u32 i, ip;
 	struct acpi_whea_header *entry;
 	apei_exec_ins_func_t run;
+	bool found_action = false;
 
 	ctx->ip = 0;
 
@@ -178,6 +179,7 @@ rewind:
 		entry = &ctx->action_table[i];
 		if (entry->action != action)
 			continue;
+		found_action = true;
 		if (ip == ctx->ip) {
 			if (entry->instruction >= ctx->instructions ||
 			    !ctx->ins_table[entry->instruction].run) {
@@ -198,6 +200,9 @@ rewind:
 			goto rewind;
 	}
 
+	if (!found_action)
+		return -ENODEV;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(apei_exec_run);
