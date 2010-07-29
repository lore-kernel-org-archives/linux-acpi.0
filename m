From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] acpi ec: Fix possible double io port registration
Date: Thu, 29 Jul 2010 22:08:44 +0200
Message-ID: <1280434125-11943-2-git-send-email-trenn@suse.de>
References: <1280434125-11943-1-git-send-email-trenn@suse.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1280434125-11943-1-git-send-email-trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, akpm@linux-foundation.org, Thomas Renninger <trenn@suse.de>
List-Id: linux-acpi@vger.kernel.org

which will result in a harmless but ugly WARN message on
some machines.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: mjg59@srcf.ucam.org
CC: platform-driver-x86@vger.kernel.org
CC: linux-acpi@vger.kernel.org
CC: astarikovskiy@suse.de
CC: akpm@linux-foundation.org
---
 drivers/acpi/ec.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 265a99c..1fa0aaf 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -818,6 +818,12 @@ static int acpi_ec_add(struct acpi_device *device)
 	if (!first_ec)
 		first_ec = ec;
 	device->driver_data = ec;
+
+	WARN(!request_region(ec->data_addr, 1, "EC data"),
+	     "Could not request EC data io port 0x%lx", ec->data_addr);
+	WARN(!request_region(ec->command_addr, 1, "EC cmd"),
+	     "Could not request EC cmd io port 0x%lx", ec->command_addr);
+
 	pr_info(PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx\n",
 			  ec->gpe, ec->command_addr, ec->data_addr);
 
@@ -844,6 +850,8 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 		kfree(handler);
 	}
 	mutex_unlock(&ec->lock);
+	release_region(ec->data_addr, 1);
+	release_region(ec->command_addr, 1);
 	device->driver_data = NULL;
 	if (ec == first_ec)
 		first_ec = NULL;
@@ -864,18 +872,10 @@ ec_parse_io_ports(struct acpi_resource *resource, void *context)
 	 * the second address region returned is the status/command
 	 * port.
 	 */
-	if (ec->data_addr == 0) {
+	if (ec->data_addr == 0)
 		ec->data_addr = resource->data.io.minimum;
-		WARN(!request_region(ec->data_addr, 1, "EC data"),
-		     "Could not request EC data io port %lu",
-		     ec->data_addr);
-	}
-	else if (ec->command_addr == 0) {
+	else if (ec->command_addr == 0)
 		ec->command_addr = resource->data.io.minimum;
-		WARN(!request_region(ec->command_addr, 1, "EC command"),
-		     "Could not request EC command io port %lu",
-		     ec->command_addr);
-	}
 	else
 		return AE_CTRL_TERMINATE;
 
-- 
1.6.3
