From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv2 4/5] ACPI: suppress compiler warning in container.c
Date: Mon, 11 Mar 2013 11:17:07 +0200
Message-ID: <1362993428-14823-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56515 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab3CKJR2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Mar 2013 05:17:28 -0400
In-Reply-To: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch fixes following compiler warning when build via make W=3D1:

drivers/acpi/container.c:183:116: warning: no previous prototype for =E2=
=80=98acpi_container_init=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/container.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 5523ba7..6624c01 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -35,6 +35,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
=20
+#include "internal.h"
+
 #define PREFIX "ACPI: "
=20
 #define _COMPONENT			ACPI_CONTAINER_COMPONENT
--=20
1.8.2.rc0.22.gb3600c3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
