From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/84] ACPICA: fix mutex names in debug code.
Date: Sat, 28 Jun 2008 01:43:18 -0400
Message-ID: <71fcfdef557afcccdefc9421b57d15b0bfd5c8ed.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:62858 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbYF1Fox (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:44:53 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BO3RYPN3F1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:44:50 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Vegard Nossum <vegard.nossum@gmail.com>, Len Brown <len.brown@intel.com>

From: Vegard Nossum <vegard.nossum@gmail.com>

Reorder the mutex names to match the preceding #defines

Signed-off-by: Vegard Nossum <vegard.nossum@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/aclocal.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index c5cdc32..62d7468 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -98,8 +98,8 @@ union acpi_parse_object;
 
 static char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
 	"ACPI_MTX_Interpreter",
-	"ACPI_MTX_Tables",
 	"ACPI_MTX_Namespace",
+	"ACPI_MTX_Tables",
 	"ACPI_MTX_Events",
 	"ACPI_MTX_Caches",
 	"ACPI_MTX_Memory",
-- 
1.5.6.1.89.gd544

