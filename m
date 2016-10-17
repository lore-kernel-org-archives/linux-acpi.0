From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 6/7] ACPICA: Move acpi_gbl_max_loop_iterations to the public globals file
Date: Tue, 18 Oct 2016 03:03:57 +0800
Message-ID: <8da8bbb2648dd4069f0d391333f8f028e63cafe4.1476725675.git.lv.zheng@intel.com>
References: <cover.1476725675.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35688 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933253AbcJQTEK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2016 15:04:10 -0400
Received: by mail-qt0-f195.google.com with SMTP id g49so6573047qtc.2
        for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2016 12:04:10 -0700 (PDT)
In-Reply-To: <cover.1476725675.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit eb8b2194200867dec9ba38e5ab98b5b8ef262945

Moved to acpixf.h with the rest of the configuration globals.

Link: https://github.com/acpica/acpica/commit/eb8b2194
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h | 4 ----
 include/acpi/acpixf.h          | 7 +++++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index b549e6d..edbb42e 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -240,10 +240,6 @@ ACPI_INIT_GLOBAL(u32, acpi_gbl_nesting_level, 0);
 
 ACPI_GLOBAL(struct acpi_thread_state *, acpi_gbl_current_walk_list);
 
-/* Maximum number of While() loop iterations before forced abort */
-
-ACPI_GLOBAL(u32, acpi_gbl_max_loop_iterations);
-
 /* Control method single step flag */
 
 ACPI_GLOBAL(u8, acpi_gbl_cm_single_step);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c7b3a13..07ab21e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -259,6 +259,13 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_osi_data, 0);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_reduced_hardware, FALSE);
 
 /*
+ * Maximum number of While() loop iterations before forced method abort.
+ * This mechanism is intended to prevent infinite loops during interpreter
+ * execution within a host kernel.
+ */
+ACPI_INIT_GLOBAL(u32, acpi_gbl_max_loop_iterations, ACPI_MAX_LOOP_COUNT);
+
+/*
  * This mechanism is used to trace a specified AML method. The method is
  * traced each time it is executed.
  */
-- 
2.7.4

