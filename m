From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/11] ACPI: static acpi_find_dsdt_initrd()
Date: Thu, 14 Feb 2008 02:02:28 -0500
Message-ID: <adba2a876c1c971980f9bb3c6c8e20c61490647b.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:3160 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756120AbYBNHKo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 02:10:44 -0500
In-Reply-To: <1202972552-17953-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
References: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 346f049..b51954d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -325,7 +325,7 @@ acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
 }
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
-struct acpi_table_header *acpi_find_dsdt_initrd(void)
+static struct acpi_table_header *acpi_find_dsdt_initrd(void)
 {
 	struct file *firmware_file;
 	mm_segment_t oldfs;
-- 
1.5.4.1.122.gaa8d

