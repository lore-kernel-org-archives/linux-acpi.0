From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/60] ACPICA: Increase configurability of error messages
Date: Mon, 25 Oct 2010 02:20:21 -0400
Message-ID: <75434a2ae37b78887b7a1d70d0a23bbd5e09fb01.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63743 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0JYILT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 04:11:19 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00AR06QCM6U2@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 03:11:15 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Update to utxferror.c

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utxferror.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index bf679c4..6f12e31 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -221,7 +221,7 @@ ACPI_EXPORT_SYMBOL(acpi_info)
  * The remainder of this module contains internal error functions that may
  * be configured out.
  */
-#ifndef ACPI_NO_ERROR_MESSAGES
+#if !defined (ACPI_NO_ERROR_MESSAGES) && !defined (ACPI_BIN_APP)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_predefined_warning
-- 
1.7.3.2.90.gd4c43

