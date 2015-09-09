From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/3] ACPI: constify struct acpi_hardware_id::id
Date: Wed,  9 Sep 2015 23:59:42 +0200
Message-ID: <1441835983-15197-2-git-send-email-linux@rasmusvillemoes.dk>
References: <1441835983-15197-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441835983-15197-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

This is preparation for using kstrdup_const to initialize that member.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/acpi/scan.c        | 4 ++--
 drivers/pnp/pnpacpi/core.c | 4 ++--
 include/acpi/acpi_bus.h    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 01136b879038..a3eaf2080707 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1472,7 +1472,7 @@ bool acpi_device_is_present(struct acpi_device *adev)
 }
 
 static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
-				       char *idstr,
+				       const char *idstr,
 				       const struct acpi_device_id **matchid)
 {
 	const struct acpi_device_id *devid;
@@ -1491,7 +1491,7 @@ static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
 	return false;
 }
 
-static struct acpi_scan_handler *acpi_scan_match_handler(char *idstr,
+static struct acpi_scan_handler *acpi_scan_match_handler(const char *idstr,
 					const struct acpi_device_id **matchid)
 {
 	struct acpi_scan_handler *handler;
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 5153d1d69aee..9113876487ed 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -207,7 +207,7 @@ struct pnp_protocol pnpacpi_protocol = {
 };
 EXPORT_SYMBOL(pnpacpi_protocol);
 
-static char *__init pnpacpi_get_id(struct acpi_device *device)
+static const char *__init pnpacpi_get_id(struct acpi_device *device)
 {
 	struct acpi_hardware_id *id;
 
@@ -222,7 +222,7 @@ static char *__init pnpacpi_get_id(struct acpi_device *device)
 static int __init pnpacpi_add_device(struct acpi_device *device)
 {
 	struct pnp_dev *dev;
-	char *pnpid;
+	const char *pnpid;
 	struct acpi_hardware_id *id;
 	int error;
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 9a1b46c64fc1..fec002919b65 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -227,7 +227,7 @@ typedef char acpi_device_class[20];
 
 struct acpi_hardware_id {
 	struct list_head list;
-	char *id;
+	const char *id;
 };
 
 struct acpi_pnp_type {
-- 
2.1.3
