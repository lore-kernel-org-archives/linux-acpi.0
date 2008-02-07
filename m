From: Len Brown <lenb@kernel.org>
Subject: [PATCH 022/112] ACPI: remove P2B-S from blacklist.
Date: Thu,  7 Feb 2008 04:33:44 -0500
Message-ID: <37748ebf8888aef6a252016d7c3cdc84514df051.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757616AbYBGJfs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:48 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dave Jones <davej@redhat.com>, Len Brown <len.brown@intel.com>

From: Dave Jones <davej@redhat.com>

According to http://bugzilla.kernel.org/show_bug.cgi?id=6933
The latest BIOS for the P2B-S works fine.
Remove it from the blacklist.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 3ec110c..7c24a8d 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -67,8 +67,6 @@ static struct acpi_blacklist_item acpi_blacklist[] __initdata = {
 	/* IBM 600E - _ADR should return 7, but it returns 1 */
 	{"IBM   ", "TP600E  ", 0x00000105, ACPI_SIG_DSDT, less_than_or_equal,
 	 "Incorrect _ADR", 1},
-	{"ASUS\0\0", "P2B-S   ", 0, ACPI_SIG_DSDT, all_versions,
-	 "Bogus PCI routing", 1},
 
 	{""}
 };
-- 
1.5.4.23.gef5b9

