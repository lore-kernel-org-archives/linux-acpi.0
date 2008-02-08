From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/8] ACPI: add newline to printk
Date: Fri,  8 Feb 2008 01:29:17 -0500
Message-ID: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
References: <1202452164-32320-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:37463 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760546AbYBHG3i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 01:29:38 -0500
In-Reply-To: <1202452164-32320-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 27ccd68..a14501c 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -343,7 +343,7 @@ struct acpi_table_header *acpi_find_dsdt_initrd(void)
 	struct kstat stat;
 	char *ramfs_dsdt_name = "/DSDT.aml";
 
-	printk(KERN_INFO PREFIX "Checking initramfs for custom DSDT");
+	printk(KERN_INFO PREFIX "Checking initramfs for custom DSDT\n");
 
 	/*
 	 * Never do this at home, only the user-space is allowed to open a file.
-- 
1.5.4.34.g053d9

