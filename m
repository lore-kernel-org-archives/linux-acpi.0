From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/17] ACPICA: Removed unused include files from source files
Date: Thu, 12 Jun 2008 00:35:05 -0400
Message-ID: <dc57a90f061475d71ba70d632d38426dc41df896.1213245200.git.len.brown@intel.com>
References: <1213245316-20835-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:60386 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbYFLEfV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 00:35:21 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2C00K9X1RT7GH1@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 23:28:42 -0500 (CDT)
In-reply-to: <1213245316-20835-1-git-send-email-lenb@kernel.org>
In-reply-to: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
References: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
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
1.5.6.rc2.26.g8c37

