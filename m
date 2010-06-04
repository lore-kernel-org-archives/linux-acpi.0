From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/16] ACPICA: Fix namestring associated with AE_NO_HANDLER
 exception
Date: Fri, 04 Jun 2010 15:51:33 -0400
Message-ID: <cd214019d9fb8ad059bee1880d693524f612a574.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:56173 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab0FDTvt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:51:49 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I00CD59UCSSU5@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:51:49 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Was incorrectly AE_WAKE_ONLY_GPE.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acexcep.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 5958d78..17714be 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -212,7 +212,7 @@ char const *acpi_gbl_exception_names_env[] = {
 	"AE_NO_GLOBAL_LOCK",
 	"AE_ABORT_METHOD",
 	"AE_SAME_HANDLER",
-	"AE_WAKE_ONLY_GPE",
+	"AE_NO_HANDLER",
 	"AE_OWNER_ID_LIMIT"
 };
 
-- 
1.6.0.6

