From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/11] ACPI: static acpi_no_initrd_override_setup()
Date: Thu, 14 Feb 2008 02:02:27 -0500
Message-ID: <bfaed45e30f19bb4cee779f3229d2744bc2b2c46.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:21951 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756057AbYBNHKo (ORCPT
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
Acked-by: Eric Piel <eric.piel@tremplin-utc.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 15e6023..346f049 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -419,7 +419,7 @@ acpi_os_table_override(struct acpi_table_header * existing_table,
 }
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
-int __init acpi_no_initrd_override_setup(char *s)
+static int __init acpi_no_initrd_override_setup(char *s)
 {
 	acpi_no_initrd_override = 1;
 	return 1;
-- 
1.5.4.1.122.gaa8d

