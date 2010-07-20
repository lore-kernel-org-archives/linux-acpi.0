From: akpm@linux-foundation.org
Subject: [patch 22/26] acer-wmi: fix memory leaks in WMID_set_capabilities and get_wmid_devices
Date: Tue, 20 Jul 2010 15:19:52 -0700
Message-ID: <201007202219.o6KMJqnl021089@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, carlos@strangeworlds.co.uk, mjg@redhat.com
List-Id: linux-acpi@vger.kernel.org

From: Axel Lin <axel.lin@gmail.com>

When acpi_evaluate_object() is passed ACPI_ALLOCATE_BUFFER, the caller
must kfree the returned buffer if AE_OK is returned.

The callers of wmi_query_block() pass ACPI_ALLOCATE_BUFFER, and thus must
check its return value before accessing or kfree() on the buffer.

This patch adds a missing kfree(out.pointer) before exit
WMID_set_capabilities() and get_wmid_devices().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acer-wmi.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff -puN drivers/platform/x86/acer-wmi.c~acer-wmi-fix-memory-leaks-in-wmid_set_capabilities-and-get_wmid_devices drivers/platform/x86/acer-wmi.c
--- a/drivers/platform/x86/acer-wmi.c~acer-wmi-fix-memory-leaks-in-wmid_set_capabilities-and-get_wmid_devices
+++ a/drivers/platform/x86/acer-wmi.c
@@ -772,6 +772,7 @@ static acpi_status WMID_set_capabilities
 		obj->buffer.length == sizeof(u32)) {
 		devices = *((u32 *) obj->buffer.pointer);
 	} else {
+		kfree(out.pointer);
 		return AE_ERROR;
 	}
 
@@ -788,6 +789,7 @@ static acpi_status WMID_set_capabilities
 	if (!(devices & 0x20))
 		max_brightness = 0x9;
 
+	kfree(out.pointer);
 	return status;
 }
 
@@ -1094,6 +1096,7 @@ static u32 get_wmid_devices(void)
 	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *obj;
 	acpi_status status;
+	u32 devices = 0;
 
 	status = wmi_query_block(WMID_GUID2, 1, &out);
 	if (ACPI_FAILURE(status))
@@ -1102,10 +1105,11 @@ static u32 get_wmid_devices(void)
 	obj = (union acpi_object *) out.pointer;
 	if (obj && obj->type == ACPI_TYPE_BUFFER &&
 		obj->buffer.length == sizeof(u32)) {
-		return *((u32 *) obj->buffer.pointer);
-	} else {
-		return 0;
+		devices = *((u32 *) obj->buffer.pointer);
 	}
+
+	kfree(out.pointer);
+	return devices;
 }
 
 /*
_
