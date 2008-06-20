From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/70] ACPICA: Removed unused include files from source files
Date: Fri, 20 Jun 2008 03:43:21 -0400
Message-ID: <f84c026190f9c5c41b462026296144edefc10192.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:53320 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbYFTHob (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:31 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R0077L3UY2241@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:37:47 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

>From lint.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/excreate.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/executer/excreate.c b/drivers/acpi/executer/excreate.c
index 60e62c4..ad09696 100644
--- a/drivers/acpi/executer/excreate.c
+++ b/drivers/acpi/executer/excreate.c
@@ -45,8 +45,6 @@
 #include <acpi/acinterp.h>
 #include <acpi/amlcode.h>
 #include <acpi/acnamesp.h>
-#include <acpi/acevents.h>
-#include <acpi/actables.h>
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("excreate")
-- 
1.5.6

