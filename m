From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/4] ACPI / dock: Do not check CONFIG_ACPI_DOCK_MODULE
Date: Thu, 04 Jul 2013 01:26:11 +0200
Message-ID: <3875539.nz3LziUdX0@vostro.rjw.lan>
References: <1640211.P0jyS5muX2@vostro.rjw.lan> <1515394.L46AJCfCTt@vostro.rjw.lan> <2759309.GsYqNLU1ac@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2759309.GsYqNLU1ac@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since commit 94add0f (ACPI / dock: Initialize ACPI dock subsystem
upfront) the ACPI dock driver cannot be a module, so
CONFIG_ACPI_DOCK_MODULE is never set.  For this reason, simplify
the preprocessor conditional in include/acpi/acpi_drivers.h
referring to that symbol unnecessarily.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acpi_drivers.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -117,7 +117,7 @@ struct acpi_dock_ops {
 	acpi_notify_handler uevent;
 };
 
-#if defined(CONFIG_ACPI_DOCK) || defined(CONFIG_ACPI_DOCK_MODULE)
+#ifdef CONFIG_ACPI_DOCK
 extern int is_dock_device(acpi_handle handle);
 extern int register_dock_notifier(struct notifier_block *nb);
 extern void unregister_dock_notifier(struct notifier_block *nb);
@@ -150,6 +150,6 @@ static inline int register_hotplug_dock_
 static inline void unregister_hotplug_dock_device(acpi_handle handle)
 {
 }
-#endif
+#endif /* CONFIG_ACPI_DOCK */
 
 #endif /*__ACPI_DRIVERS_H__*/
