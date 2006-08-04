From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: [PATCH](memory hotplug) remove useless message at boot time from 2.6.18-rc3.
Date: Fri, 04 Aug 2006 21:37:34 +0900
Message-ID: <20060804213230.D5D4.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161192AbWHDMiZ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@osdl.org
Cc: keith mannthey <kmannth@us.ibm.com>, ACPI-ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

This is to remove noisy useless message at boot time from 2.6.18-rc3.
(-mm doesn't shows this message. I don't know why.)

The message is a ton of 
"ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device"

It is showed by acpi_memory_register_notify_handler() which
is called by acpi_walk_namespace().

acpi_walk_namespace() parses all of ACPI's namespace and 
executes acpi_memory_register_notify_handler(). So, it is called for
all of the device which is defined in namespace. Even if
the parsing device is not memory, it is normal route.
So, this message is useless.

I tested this patch for 2.6.18-rc3 on my box with hot-add emulation.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
------

 drivers/acpi/acpi_memhotplug.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

Index: hotmemtest1/drivers/acpi/acpi_memhotplug.c
===================================================================
--- hotmemtest1.orig/drivers/acpi/acpi_memhotplug.c	2006-08-03 20:00:58.000000000 +0900
+++ hotmemtest1/drivers/acpi/acpi_memhotplug.c	2006-08-04 21:06:52.000000000 +0900
@@ -487,10 +487,8 @@ acpi_memory_register_notify_handler(acpi
 
 
 	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
+	if (ACPI_FAILURE(status))
 		return AE_OK;	/* continue */
-	}
 
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 					     acpi_memory_device_notify, NULL);
@@ -506,10 +504,8 @@ acpi_memory_deregister_notify_handler(ac
 
 
 	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
+	if (ACPI_FAILURE(status))
 		return AE_OK;	/* continue */
-	}
 
 	status = acpi_remove_notify_handler(handle,
 					    ACPI_SYSTEM_NOTIFY,

-- 
Yasunori Goto 
