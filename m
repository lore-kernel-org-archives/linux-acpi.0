From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/15] ACPI/HEST: adjust section selection
Date: Sat, 11 Dec 2010 02:06:40 -0500
Message-ID: <bec4f22a2dbd5a26079cbddbcadf38f8c7e5381f.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33724 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab0LKHww (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:52:52 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900699780NVJ2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:52:51 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jan Beulich <JBeulich@novell.com>, Jan Beulich <jbeulich@novell.com>, Len Brown <len.brown@intel.com>

From: Jan Beulich <JBeulich@novell.com>

Properly const-, __init-, and __read_mostly-annotate this code.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/hest.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 1a3508a..daa7bc6 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -46,9 +46,9 @@ EXPORT_SYMBOL_GPL(hest_disable);
 
 /* HEST table parsing */
 
-static struct acpi_table_hest *hest_tab;
+static struct acpi_table_hest *__read_mostly hest_tab;
 
-static int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
+static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
 	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
 	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
 	[ACPI_HEST_TYPE_IA32_NMI] = sizeof(struct acpi_hest_ia_nmi),
@@ -126,7 +126,7 @@ struct ghes_arr {
 	unsigned int count;
 };
 
-static int hest_parse_ghes_count(struct acpi_hest_header *hest_hdr, void *data)
+static int __init hest_parse_ghes_count(struct acpi_hest_header *hest_hdr, void *data)
 {
 	int *count = data;
 
@@ -135,7 +135,7 @@ static int hest_parse_ghes_count(struct acpi_hest_header *hest_hdr, void *data)
 	return 0;
 }
 
-static int hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
+static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
 {
 	struct platform_device *ghes_dev;
 	struct ghes_arr *ghes_arr = data;
@@ -165,7 +165,7 @@ err:
 	return rc;
 }
 
-static int hest_ghes_dev_register(unsigned int ghes_count)
+static int __init hest_ghes_dev_register(unsigned int ghes_count)
 {
 	int rc, i;
 	struct ghes_arr ghes_arr;
-- 
1.7.3.3.480.g2f76a

