From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Resend][PATCH] ACPICA: Store GPE register enable masks upfront
Date: Mon, 13 Apr 2015 23:10:06 +0200
Message-ID: <9660023.JG1EQJqKz1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Jim Bos <jim876@xs4all.nl>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, David Box <david.e.box@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is reported that ACPI interrupts do not work any more on
Dell Latitude D600 after commit c50f13c672df (ACPICA: Save
current masks of enabled GPEs after enable register writes).
The problem turns out to be related to the fact that the
enable_mask and enable_for_run GPE bit masks are not in
sync (in the absence of any system suspend/resume events)
for at least one GPE register on that machine.

Address this problem by writing the enable_for_run mask into
enable_mask as soon as enable_for_run is updated instead of
doing that only after the subsequent register write has
succeeded.  For consistency, update acpi_hw_gpe_enable_write()
to store the bit mask to be written into the GPE register
in enable_mask unconditionally before the write.

Since the ACPI_GPE_SAVE_MASK flag is not necessary any more after
that, drop it along with the symbols depending on it.

Reported-and-tested-by: Jim Bos <jim876@xs4all.nl>
Fixes: c50f13c672df (ACPICA: Save current masks of enabled GPEs after enable register writes)
Cc: 3.19+ <stable@vger.kernel.org> # 3.19+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evgpe.c |    5 +++--
 drivers/acpi/acpica/hwgpe.c |   11 ++++-------
 include/acpi/actypes.h      |    4 ----
 3 files changed, 7 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/acpica/hwgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwgpe.c
+++ linux-pm/drivers/acpi/acpica/hwgpe.c
@@ -89,6 +89,8 @@ u32 acpi_hw_get_gpe_register_bit(struct
  * RETURN:	Status
  *
  * DESCRIPTION: Enable or disable a single GPE in the parent enable register.
+ *              The enable_mask field of the involved GPE register must be
+ *              updated by the caller if necessary.
  *
  ******************************************************************************/
 
@@ -119,7 +121,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_even
 	/* Set or clear just the bit that corresponds to this GPE */
 
 	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info);
-	switch (action & ~ACPI_GPE_SAVE_MASK) {
+	switch (action) {
 	case ACPI_GPE_CONDITIONAL_ENABLE:
 
 		/* Only enable if the corresponding enable_mask bit is set */
@@ -149,9 +151,6 @@ acpi_hw_low_set_gpe(struct acpi_gpe_even
 	/* Write the updated enable mask */
 
 	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
-	if (ACPI_SUCCESS(status) && (action & ACPI_GPE_SAVE_MASK)) {
-		gpe_register_info->enable_mask = (u8)enable_mask;
-	}
 	return (status);
 }
 
@@ -286,10 +285,8 @@ acpi_hw_gpe_enable_write(u8 enable_mask,
 {
 	acpi_status status;
 
+	gpe_register_info->enable_mask = enable_mask;
 	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
-	if (ACPI_SUCCESS(status)) {
-		gpe_register_info->enable_mask = enable_mask;
-	}
 	return (status);
 }
 
Index: linux-pm/include/acpi/actypes.h
===================================================================
--- linux-pm.orig/include/acpi/actypes.h
+++ linux-pm/include/acpi/actypes.h
@@ -736,10 +736,6 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1
 #define ACPI_GPE_CONDITIONAL_ENABLE     2
-#define ACPI_GPE_SAVE_MASK              4
-
-#define ACPI_GPE_ENABLE_SAVE            (ACPI_GPE_ENABLE | ACPI_GPE_SAVE_MASK)
-#define ACPI_GPE_DISABLE_SAVE           (ACPI_GPE_DISABLE | ACPI_GPE_SAVE_MASK)
 
 /*
  * GPE info flags - Per GPE
Index: linux-pm/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evgpe.c
+++ linux-pm/drivers/acpi/acpica/evgpe.c
@@ -92,6 +92,7 @@ acpi_ev_update_gpe_enable_mask(struct ac
 		ACPI_SET_BIT(gpe_register_info->enable_for_run,
 			     (u8)register_bit);
 	}
+	gpe_register_info->enable_mask = gpe_register_info->enable_for_run;
 
 	return_ACPI_STATUS(AE_OK);
 }
@@ -123,7 +124,7 @@ acpi_status acpi_ev_enable_gpe(struct ac
 
 	/* Enable the requested GPE */
 
-	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE_SAVE);
+	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
 	return_ACPI_STATUS(status);
 }
 
@@ -202,7 +203,7 @@ acpi_ev_remove_gpe_reference(struct acpi
 		if (ACPI_SUCCESS(status)) {
 			status =
 			    acpi_hw_low_set_gpe(gpe_event_info,
-						ACPI_GPE_DISABLE_SAVE);
+						ACPI_GPE_DISABLE);
 		}
 
 		if (ACPI_FAILURE(status)) {
