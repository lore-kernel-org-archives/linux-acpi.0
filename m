From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 2/3] ACPI: Add Error Disconnect Recover (EDR) ACPI notifier support
Date: Thu, 28 Feb 2019 12:49:48 -0800
Message-ID: <5229ccc3bbb1792ba625b7c54f5ad6f101826454.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com, ruscur@russell.cc
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, keith.busch@intel.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per ACPI spec r6.3, sec 6.3.5, Error Disconnect Recover
notification can be used to notify OSPM of asynchronous removal
of devices for error containment purposes. OSPM can use this
notification to invalidate software states of disconnected child
devices in the bus and also optionally can attempt recover the child
devices.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/acpica/utdecode.c | 3 ++-
 drivers/acpi/bus.c             | 5 ++++-
 include/acpi/actypes.h         | 3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index dad02b821e19..40d36c6661f1 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -431,7 +431,8 @@ static const char *acpi_gbl_generic_notify[ACPI_GENERIC_NOTIFY_MAX + 1] = {
 								/* Reserved in ACPI 6.0 */
 	/* 0D */ "System Resource Affinity Update",
 								/* 0E */ "Heterogeneous Memory Attributes Update"
-								/* ACPI 6.2 */
+	/* 0F */ "Error Disconnect Recover",
+	/* ACPI 6.3 */
 };
 
 static const char *acpi_gbl_device_notify[5] = {
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 147f6c7ea59c..aacf82162604 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -397,7 +397,10 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	case ACPI_NOTIFY_POWER_FAULT:
 		acpi_handle_err(handle, "Device has suffered a power fault\n");
 		break;
-
+	case ACPI_NOTIFY_ERROR_DISCONNECT:
+		acpi_handle_debug(handle,
+				  "ACPI_NOTIFY_ERROR_DISCONNECT event\n");
+		break;
 	default:
 		acpi_handle_debug(handle, "Unknown event type 0x%x\n", type);
 		break;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 2590627dbfcc..40ad91b06f02 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -617,8 +617,9 @@ typedef u64 acpi_integer;
 #define ACPI_NOTIFY_SHUTDOWN_REQUEST    (u8) 0x0C
 #define ACPI_NOTIFY_AFFINITY_UPDATE     (u8) 0x0D
 #define ACPI_NOTIFY_MEMORY_UPDATE       (u8) 0x0E
+#define ACPI_NOTIFY_ERROR_DISCONNECT    (u8) 0x0F
 
-#define ACPI_GENERIC_NOTIFY_MAX         0x0E
+#define ACPI_GENERIC_NOTIFY_MAX         0x0F
 #define ACPI_SPECIFIC_NOTIFY_MAX        0x84
 
 /*
-- 
2.20.1
