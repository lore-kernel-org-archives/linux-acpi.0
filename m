From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv2 2/5] ACPI: suppress compiler warnings in processor_throttling.c
Date: Mon, 11 Mar 2013 11:17:05 +0200
Message-ID: <1362993428-14823-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56515 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861Ab3CKJR1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Mar 2013 05:17:27 -0400
In-Reply-To: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch fixes following compiler warnings when build via make W=3D1:

drivers/acpi/processor_throttling.c: In function =E2=80=98acpi_processo=
r_throttling_init=E2=80=99:
drivers/acpi/processor_throttling.c:216:40: warning: suggest braces aro=
und empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/processor_throttling.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/process=
or_throttling.c
index 1d02b7b..e7dd2c1 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -211,9 +211,10 @@ err_ret:
  */
 void acpi_processor_throttling_init(void)
 {
-	if (acpi_processor_update_tsd_coord())
+	if (acpi_processor_update_tsd_coord()) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			"Assume no T-state coordination\n"));
+	}
=20
 	return;
 }
--=20
1.8.2.rc0.22.gb3600c3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
