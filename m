From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv2 3/5] ACPI: suppress compiler warning in battery.c
Date: Mon, 11 Mar 2013 11:17:06 +0200
Message-ID: <1362993428-14823-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:39079 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287Ab3CKJRe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Mar 2013 05:17:34 -0400
In-Reply-To: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch fixes following compiler warning when build via make W=3D1:

drivers/acpi/battery.c:149:52: warning: no previous prototype for =E2=80=
=98acpi_battery_present=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c5cd5b5..0cc384b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -146,7 +146,7 @@ struct acpi_battery {
=20
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat)
=20
-inline int acpi_battery_present(struct acpi_battery *battery)
+static inline int acpi_battery_present(struct acpi_battery *battery)
 {
 	return battery->device->status.battery_present;
 }
--=20
1.8.2.rc0.22.gb3600c3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
