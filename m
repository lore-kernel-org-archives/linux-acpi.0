From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/3] ACPI: constify first argument of struct acpi_scan_handler::match
Date: Wed,  9 Sep 2015 23:59:41 +0200
Message-ID: <1441835983-15197-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:33879 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbbIIV74 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2015 17:59:56 -0400
Received: by laeb10 with SMTP id b10so16348393lae.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2015 14:59:54 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org

One wouldn't expect a "match" function modify the string it searches
for, and indeed the only instance of the struct
acpi_scan_handler::match callback, acpi_pnp_match, can easily be
changed. While there, update its helper matching_id().

This is also preparation for constifying struct acpi_hardware_id::id.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/acpi/acpi_pnp.c | 4 ++--
 include/acpi/acpi_bus.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index c58940b231d6..48fc3ad13a4b 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -316,7 +316,7 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
 	{""},
 };
 
-static bool matching_id(char *idstr, char *list_id)
+static bool matching_id(const char *idstr, const char *list_id)
 {
 	int i;
 
@@ -333,7 +333,7 @@ static bool matching_id(char *idstr, char *list_id)
 	return true;
 }
 
-static bool acpi_pnp_match(char *idstr, const struct acpi_device_id **matchid)
+static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matchid)
 {
 	const struct acpi_device_id *devid;
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5ba8fb64f664..9a1b46c64fc1 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -129,7 +129,7 @@ static inline struct acpi_hotplug_profile *to_acpi_hotplug_profile(
 struct acpi_scan_handler {
 	const struct acpi_device_id *ids;
 	struct list_head list_node;
-	bool (*match)(char *idstr, const struct acpi_device_id **matchid);
+	bool (*match)(const char *idstr, const struct acpi_device_id **matchid);
 	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
 	void (*detach)(struct acpi_device *dev);
 	void (*bind)(struct device *phys_dev);
-- 
2.1.3

