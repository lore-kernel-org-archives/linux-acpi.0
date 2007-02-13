From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/41] ACPI: bay: fix build warning
Date: Tue, 13 Feb 2007 00:49:22 -0500
Message-ID: <11713458101527-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:36316 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751071AbXBMFuL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:11 -0500
In-Reply-To: <11713458083103-git-send-email-lenb@kernel.org>
Message-Id: <d94d3dff0d5da3bdfcbb424ba5c08534521fd690.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Andrew Morton <akpm@linux-foundation.org>

drivers/acpi/bay.c: In function 'bay_add':
drivers/acpi/bay.c:310: warning: statement with no effect

Fix it by rewriting those macros in C.  Much nicer.

Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpi_drivers.h |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 4dc8a50..3d7ebe0 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -122,10 +122,24 @@ extern int register_hotplug_dock_device(acpi_handle handle,
 	acpi_notify_handler handler, void *context);
 extern void unregister_hotplug_dock_device(acpi_handle handle);
 #else
-#define is_dock_device(h)			(0)
-#define register_dock_notifier(nb) 		(-ENODEV)
-#define unregister_dock_notifier(nb)           	do { } while(0)
-#define register_hotplug_dock_device(h1, h2, c)	(-ENODEV)
-#define unregister_hotplug_dock_device(h)       do { } while(0)
+static inline int is_dock_device(acpi_handle handle)
+{
+	return 0;
+}
+static inline int register_dock_notifier(struct notifier_block *nb)
+{
+	return -ENODEV;
+}
+static inline void unregister_dock_notifier(struct notifier_block *nb)
+{
+}
+static inline int register_hotplug_dock_device(acpi_handle handle,
+				acpi_notify_handler handler, void *context)
+{
+	return -ENODEV;
+}
+static inline void unregister_hotplug_dock_device(acpi_handle handle)
+{
+}
 #endif
 #endif /*__ACPI_DRIVERS_H__*/
-- 
1.5.0.rc4.345.gb4d2
