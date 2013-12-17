From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 02/11] drivers: acpi: Include appropriate header file in nvs.c
Date: Tue, 17 Dec 2013 14:45:00 +0530
Message-ID: <1e397a06259f56042ec90d55fbf7423fc3bdca92.1387271324.git.rashika.kheria@gmail.com>
References: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:42277 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab3LQJPP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2013 04:15:15 -0500
Content-Disposition: inline
In-Reply-To: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, josh@joshtriplett.org

Include header file internal.h in nvs.c because functions
suspend_nvs_free(), suspend_nvs_alloc(), suspend_nvs_save() and
suspend_nvs_restore() have their prototype declaration in internal.h.

This eliminates the following warnings in nvs.c:
drivers/acpi/nvs.c:128:6: warning: no previous prototype for =E2=80=98s=
uspend_nvs_free=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/nvs.c:152:5: warning: no previous prototype for =E2=80=98s=
uspend_nvs_alloc=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/nvs.c:169:5: warning: no previous prototype for =E2=80=98s=
uspend_nvs_save=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/nvs.c:201:6: warning: no previous prototype for =E2=80=98s=
uspend_nvs_restore=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/nvs.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 386a9fe..5841914 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/acpi_io.h>
+#include "internal.h"
=20
 /* ACPI NVS regions, APEI may use it */
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
