From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH] drivers: firmware: Move prototype declartions to header file
 cper.h
Date: Wed, 18 Dec 2013 12:21:31 +0530
Message-ID: <20131218064527.GA3353@rashika>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35370 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab3LRGwA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Dec 2013 01:52:00 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, "Chen, Gong" <gong.chen@linux.intel.com>, Rashika Kheria <rashika.kheria@gmail.com>, Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-acpi@vger.kernel.org, josh@joshtriplett.org

Move prototype declarations of function cper_estatus_print(),
cper_estatus_check_header() and cper_estatus_check() from file
drivers/acpi/apei/apei-internal.h to header file include/linux/cper.h
because these functions are used by both acpi driver and firmware
driver.
The header file include/linux/cper.h was chosen because it is included
in both the drivers.

This eliminates the following warnings in efi/cper.c:
drivers/firmware/efi/cper.c:346:6: warning: no previous prototype for =E2=
=80=98cper_estatus_print=E2=80=99 [-Wmissing-prototypes]
drivers/firmware/efi/cper.c:374:5: warning: no previous prototype for =E2=
=80=98cper_estatus_check_header=E2=80=99 [-Wmissing-prototypes]
drivers/firmware/efi/cper.c:387:5: warning: no previous prototype for =E2=
=80=98cper_estatus_check=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/apei/apei-internal.h |    5 -----
 include/linux/cper.h              |    8 ++++++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei=
-internal.h
index 21ba34a..4ae847d 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -135,10 +135,5 @@ static inline u32 cper_estatus_len(struct acpi_gen=
eric_status *estatus)
 		return sizeof(*estatus) + estatus->data_length;
 }
=20
-void cper_estatus_print(const char *pfx,
-			const struct acpi_generic_status *estatus);
-int cper_estatus_check_header(const struct acpi_generic_status *estatu=
s);
-int cper_estatus_check(const struct acpi_generic_status *estatus);
-
 int apei_osc_setup(void);
 #endif
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 2fc0ec3..080f5f7 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -22,6 +22,14 @@
 #define LINUX_CPER_H
=20
 #include <linux/uuid.h>
+#include <linux/acpi.h>
+
+/* Prototype declaration of functions common between acpi and firmware=
 driver*/
+void cper_estatus_print(const char *pfx,
+		        const struct acpi_generic_status *estatus);
+int cper_estatus_check_header(const struct acpi_generic_status *estatu=
s);
+int cper_estatus_check(const struct acpi_generic_status *estatus);
+
=20
 /* CPER record signature and the size */
 #define CPER_SIG_RECORD				"CPER"
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
