From: Len Brown <lenb@kernel.org>
Subject: [PATCH 048/112] ACPI: thinkpad-acpi: silence _sta warning
Date: Thu,  7 Feb 2008 04:34:10 -0500
Message-ID: <013c40e457ac573b29daa0e369c2ba6729c23557.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755883AbYBGJgU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:20 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Pritt Laes <plaes@plaes.org>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

When both CONFIG_THINKPAD_ACPI_DOCK and CONFIG_THINKPAD_ACPI_BAY are
undefined, _sta is not used and that causes a gcc warning.  Fix it
(and I think this is a regression, I am pretty sure I fixed this once
before, sorry about that).

Issue reported by: Pritt Laes.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Pritt Laes <plaes@plaes.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 049ec42..e18f1e1 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -414,6 +414,7 @@ static int acpi_ec_write(int i, u8 v)
 	return 1;
 }
 
+#if defined(CONFIG_THINKPAD_ACPI_DOCK) || defined(CONFIG_THINKPAD_ACPI_BAY)
 static int _sta(acpi_handle handle)
 {
 	int status;
@@ -423,6 +424,7 @@ static int _sta(acpi_handle handle)
 
 	return status;
 }
+#endif
 
 static int issue_thinkpad_cmos_command(int cmos_cmd)
 {
-- 
1.5.4.23.gef5b9

