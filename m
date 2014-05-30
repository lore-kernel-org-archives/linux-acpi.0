From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/10] ACPI / scan: .match() callback for ACPI scan handlers
Date: Fri, 30 May 2014 04:21:52 +0200
Message-ID: <4647369.p7RRNThZaL@vostro.rjw.lan>
References: <1400781753-2682-1-git-send-email-rui.zhang@intel.com> <35042328.kk6ZUUdfyN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35042328.kk6ZUUdfyN@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.garrett@nebula.com, mika.westerberg@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a .match() callback for ACPI scan handlers to allow them to
use more elaborate matching algorithms if necessary.  That is needed
for the upcoming PNP scan handler in particular.

This change is based on a Zhang Rui's prototype.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
drivers/acpi/scan.c     | 17 +++++++++++------
 drivers/acpi/scan.c     |    3 +++
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 4 insertions(+)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1977,6 +1977,9 @@ static bool acpi_scan_handler_matching(s
 {
 	const struct acpi_device_id *devid;
 
+	if (handler->match)
+		return handler->match(idstr, matchid);
+
 	for (devid = handler->ids; devid->id[0]; devid++)
 		if (!strcmp((char *)devid->id, idstr)) {
 			if (matchid)
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -131,6 +131,7 @@ static inline struct acpi_hotplug_profil
 struct acpi_scan_handler {
 	const struct acpi_device_id *ids;
 	struct list_head list_node;
+	bool (*match)(char *idstr, const struct acpi_device_id **matchid);
 	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
 	void (*detach)(struct acpi_device *dev);
 	void (*bind)(struct device *phys_dev);
