From: Len Brown <lenb@kernel.org>
Subject: [PATCH 020/112] ACPI: EC: Some hardware requires burst mode to operate properly
Date: Thu,  7 Feb 2008 04:33:42 -0500
Message-ID: <b3b233c7d948a5f55185fb5a1b248157b948a1e5.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755883AbYBGJfp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:45 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Burst mode temporary (50 ms) locks EC to do only transactions with
driver, without it some hardware returns abstract garbage.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=9341

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 63862df..445ecba 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -575,6 +575,8 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (bits != 8 && acpi_strict)
 		return AE_BAD_PARAMETER;
 
+	acpi_ec_burst_enable(ec);
+
 	if (function == ACPI_READ) {
 		result = acpi_ec_read(ec, address, &temp);
 		*value = temp;
@@ -594,6 +596,8 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 		}
 	}
 
+	acpi_ec_burst_disable(ec);
+
 	switch (result) {
 	case -EINVAL:
 		return AE_BAD_PARAMETER;
-- 
1.5.4.23.gef5b9

