From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH v2] ACPI / bus: Only call dmi_check_system on X86
Date: Tue, 4 Sep 2018 14:55:26 +0200
Message-ID: <20180904145526.0abdc5bb@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Calling dmi_check_system() early only works on X86. Other
architectures initialize the DMI subsystem later so it's not
ready yet when ACPI itself gets initialized.

In the best case it results in a useless call to a function which
will do nothing. But depending on the dmi implementation, it could
also result in warnings. Best is to not call the function when it
can't work and isn't needed.

Additionally, if anyone ever needs to add non-x86 quirks, it would
surprisingly not work, so document the limitation to avoid confusion.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: cce4f632db20 ("ACPI: fix early DSDT dmi check warnings on ia64")
Cc: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
Changes since v1:
 * Rebased on top of v4.19-rc2 to avoid conflicts with recent ACPI
   changes.
 * Fix typo in comment.

 drivers/acpi/bus.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- linux-4.19-rc2.orig/drivers/acpi/bus.c	2018-09-02 23:37:30.000000000 +0200
+++ linux-4.19-rc2/drivers/acpi/bus.c	2018-09-04 10:34:34.995013240 +0200
@@ -35,11 +35,11 @@
 #include <linux/delay.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
+#include <linux/dmi.h>
 #endif
 #include <linux/acpi_iort.h>
 #include <linux/pci.h>
 #include <acpi/apei.h>
-#include <linux/dmi.h>
 #include <linux/suspend.h>
 
 #include "internal.h"
@@ -82,10 +82,6 @@ static const struct dmi_system_id dsdt_d
 	},
 	{}
 };
-#else
-static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
-	{}
-};
 #endif
 
 /* --------------------------------------------------------------------------
@@ -1033,11 +1029,16 @@ void __init acpi_early_init(void)
 
 	acpi_permanent_mmap = true;
 
+#ifdef CONFIG_X86
 	/*
 	 * If the machine falls into the DMI check table,
-	 * DSDT will be copied to memory
+	 * DSDT will be copied to memory.
+	 * Note that calling dmi_check_system here on other architectures
+	 * would not be OK because only x86 initializes dmi early enough.
+	 * Thankfully only x86 systems need such quirks for now.
 	 */
 	dmi_check_system(dsdt_dmi_table);
+#endif
 
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {


-- 
Jean Delvare
SUSE L3 Support
