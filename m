From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv2 1/5] ACPI: suppress compiler warnings in button.c
Date: Mon, 11 Mar 2013 11:17:04 +0200
Message-ID: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22038 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab3CKJR1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Mar 2013 05:17:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch fixes following compiler warnings when build via make W=3D1:

drivers/acpi/button.c:220:5: warning: no previous prototype for =E2=80=98=
acpi_lid_notifier_register=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/button.c:226:5: warning: no previous prototype for =E2=80=98=
acpi_lid_notifier_unregister=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/button.c:232:5: warning: no previous prototype for =E2=80=98=
acpi_lid_open=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/button.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 86c7d54..92a659a 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <acpi/button.h>
=20
 #define PREFIX "ACPI: "
=20
--=20
1.8.2.rc0.22.gb3600c3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
