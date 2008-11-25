From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH (resend)] acpiphp: Identify more removable slots
Date: Tue, 25 Nov 2008 21:48:14 +0000
Message-ID: <20081125214814.GA17248@srcf.ucam.org>
References: <20081113235255.GA17709@srcf.ucam.org> <20081117134952.GA12932@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081117134952.GA12932@srcf.ucam.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com
List-Id: linux-acpi@vger.kernel.org

According to section 6.3.6 of the ACPI spec, the presence of an _RMV 
method that evaluates to 1 is sufficient to indicate that a slot is 
removable without needing an eject method. This patch refactors the 
ejectable slot detection code a little in order to flag these slots as 
ejectable and register them. Acpihp then binds to the expresscard slot 
on my HP test machine.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

The _LCK handling code requires some more cleanup and ideally some 
hardware that actually implements it

 drivers/pci/hotplug/acpiphp_glue.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 955aae4..e8cef99 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -74,7 +74,7 @@ static void handle_hotplug_event_func(acpi_handle handle, u32 type, void *contex
  * Ejectable slot should satisfy at least these conditions:
  *
  *  1. has _ADR method
- *  2. has _EJ0 method
+ *  2. has _EJ0 method or _RMV method
  *
  * optionally
  *
@@ -87,18 +87,25 @@ static int is_ejectable(acpi_handle handle)
 {
 	acpi_status status;
 	acpi_handle tmp;
+	unsigned long long removable;
 
 	status = acpi_get_handle(handle, "_ADR", &tmp);
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status))
 		return 0;
-	}
 
 	status = acpi_get_handle(handle, "_EJ0", &tmp);
-	if (ACPI_FAILURE(status)) {
-		return 0;
+	if (ACPI_SUCCESS(status))
+		return 1;
+
+	status = acpi_get_handle(handle, "_RMV", &tmp);
+	if (ACPI_SUCCESS(status)) {
+		status = acpi_evaluate_integer(handle, "_RMV", NULL,
+					       &removable);
+		if (ACPI_SUCCESS(status) && removable)
+			return 1;
 	}
 
-	return 1;
+	return 0;
 }
 
 
@@ -185,16 +192,10 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	unsigned long long adr, sun;
 	int device, function, retval;
 
-	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
-
-	if (ACPI_FAILURE(status))
-		return AE_OK;
-
-	status = acpi_get_handle(handle, "_EJ0", &tmp);
-
-	if (ACPI_FAILURE(status) && !(is_dock_device(handle)))
+	if (!is_ejectable(handle) && !is_dock_device(handle))
 		return AE_OK;
 
+	acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
 	device = (adr >> 16) & 0xffff;
 	function = adr & 0xffff;
 
@@ -205,7 +206,8 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	INIT_LIST_HEAD(&newfunc->sibling);
 	newfunc->handle = handle;
 	newfunc->function = function;
-	if (ACPI_SUCCESS(status))
+
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &tmp)))
 		newfunc->flags = FUNC_HAS_EJ0;
 
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_STA", &tmp)))

-- 
Matthew Garrett | mjg59@srcf.ucam.org
