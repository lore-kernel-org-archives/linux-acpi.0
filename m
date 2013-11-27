From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH] ACPI / PCI / hotplug: Avoid warning when _ADR not present
Date: Wed, 27 Nov 2013 13:33:09 -0700
Message-ID: <1385584389-22461-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: rjw@rjwysocki.net, bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

acpiphp_enumerate_slots() walks ACPI namenamespace under
a PCI host bridge with callback register_slot().
register_slot() evaluates _ADR for all the device objects
and emits a warning message for any error.  Some platforms
have _HID device objects (such as HPET and IPMI), which
trigger unnecessary warning messages.

This patch avoids emitting a warning message when a target
device object does not have _ADR.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
Patch is based on Linus's tree (3.13-rc1).
---
 drivers/pci/hotplug/acpiphp_glue.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 1cf605f..438a4d0 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -279,7 +279,9 @@ static acpi_status register_slot(acpi_handle handle, u32 lvl, void *data,
 
 	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_warn(handle, "can't evaluate _ADR (%#x)\n", status);
+		if (status != AE_NOT_FOUND)
+			acpi_handle_warn(handle,
+				"can't evaluate _ADR (%#x)\n", status);
 		return AE_OK;
 	}
 
