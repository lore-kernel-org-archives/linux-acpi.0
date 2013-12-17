From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 08/11] drivers: acpi: Include appropriate header file in
 dock.c
Date: Tue, 17 Dec 2013 15:00:04 +0530
Message-ID: <ebb12eee9871ab9d4e1c08c421a47b4b351c9929.1387271324.git.rashika.kheria@gmail.com>
References: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:53812 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab3LQJaO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2013 04:30:14 -0500
Content-Disposition: inline
In-Reply-To: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, josh@joshtriplett.org

Includes appropriate header file internal.h in dock.c because
function acpi_dock_init() has its prototype declaration in
internal.h.

This eliminates the following warning in dock.c:
drivers/acpi/dock.c:899:13: warning: no previous prototype for =E2=80=98=
acpi_dock_init=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/dock.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index dcd73cc..f229862 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -34,6 +34,7 @@
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include "internal.h"
=20
 #define PREFIX "ACPI: "
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
