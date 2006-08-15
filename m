From: akpm@osdl.org
Subject: [patch 14/14] acpi: memory hotplug: remove useless message at boot time
Date: Mon, 14 Aug 2006 22:37:32 -0700
Message-ID: <200608150537.k7F5bWIW011569@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:43402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965111AbWHOFks (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 01:40:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, y-goto@jp.fujitsu.com, luming.yu@intel.com

From: Yasunori Goto <y-goto@jp.fujitsu.com>

This is to remove noisy useless message at boot.  The message is a ton of
"ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device"

In my emulation, number of memory devices are not so many (only 6), but,
this messages are displayed 114 times.

It is showed by acpi_memory_register_notify_handler() which is called by
acpi_walk_namespace().

acpi_walk_namespace() parses all of ACPI's namespace and execute
acpi_memory_register_notify_handler().  So, it is called for all of the
device which is defined in namespace.  If the parsing device is not memory,
acpi_memhotplug ignores it due to "no match" and will parse next device. 
This is normal route.

But this message says it is exception. It is meaningless.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: "Yu, Luming" <luming.yu@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/acpi_memhotplug.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff -puN drivers/acpi/acpi_memhotplug.c~acpi-memory-hotplug-remove-useless-message-at-boot-time drivers/acpi/acpi_memhotplug.c
--- a/drivers/acpi/acpi_memhotplug.c~acpi-memory-hotplug-remove-useless-message-at-boot-time
+++ a/drivers/acpi/acpi_memhotplug.c
@@ -484,10 +484,8 @@ acpi_memory_register_notify_handler(acpi
 
 
 	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
+	if (ACPI_FAILURE(status))
 		return AE_OK;	/* continue */
-	}
 
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 					     acpi_memory_device_notify, NULL);
@@ -503,10 +501,8 @@ acpi_memory_deregister_notify_handler(ac
 
 
 	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
+	if (ACPI_FAILURE(status))
 		return AE_OK;	/* continue */
-	}
 
 	status = acpi_remove_notify_handler(handle,
 					    ACPI_SYSTEM_NOTIFY,
_
