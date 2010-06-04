From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/16] ACPICA: Limit maximum time for Sleep() operator
Date: Fri, 04 Jun 2010 15:51:36 -0400
Message-ID: <ebdc0df1500bb62efd3e0db042eb694706183c86.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:55170 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab0FDTvu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:51:50 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I00C4X9UDUHC6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:51:50 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

To prevent accidental deep sleeps, limit the maximum time that
Sleep() will sleep. Configurable, default maximum is two seconds.
ACPICA bugzilla 854.

http://www.acpica.org/bugzilla/show_bug.cgi?id=854

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acconfig.h |    4 ++++
 drivers/acpi/acpica/exsystem.c |    8 ++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acconfig.h b/drivers/acpi/acpica/acconfig.h
index 33181ad..b17d8de 100644
--- a/drivers/acpi/acpica/acconfig.h
+++ b/drivers/acpi/acpica/acconfig.h
@@ -119,6 +119,10 @@
 
 #define ACPI_MAX_LOOP_ITERATIONS        0xFFFF
 
+/* Maximum sleep allowed via Sleep() operator */
+
+#define ACPI_MAX_SLEEP                  20000	/* Two seconds */
+
 /******************************************************************************
  *
  * ACPI Specification constants (Do not change unless the specification changes)
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 6d32e09..675aaa9 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -201,6 +201,14 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long)
 
 	acpi_ex_relinquish_interpreter();
 
+	/*
+	 * For compatibility with other ACPI implementations and to prevent
+	 * accidental deep sleeps, limit the sleep time to something reasonable.
+	 */
+	if (how_long > ACPI_MAX_SLEEP) {
+		how_long = ACPI_MAX_SLEEP;
+	}
+
 	acpi_os_sleep(how_long);
 
 	/* And now we must get the interpreter again */
-- 
1.6.0.6

