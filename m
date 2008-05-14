From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH 1/2] Add a list of processor objects to the ACPI core
Date: Wed, 14 May 2008 02:03:00 +0100
Message-ID: <20080514010300.GC21608@srcf.ucam.org>
References: <20080514010000.GB21608@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:57583 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1757534AbYENBDM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 May 2008 21:03:12 -0400
Content-Disposition: inline
In-Reply-To: <20080514010000.GB21608@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Add a convenience structure to the ACPI core that allows drivers to 
obtain the list of CPU devices. This is left in the core since the 
scanning is performed at boot time and the drivers may be built as 
modules.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

Am I missing a straightforward function to call from a driver that gives 
me the handles of all the objects of a specific type? There must be a 
better way of doing it than this :)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 6d85289..3b8d036 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -30,6 +30,9 @@ struct acpi_device_bus_id{
 	struct list_head node;
 };
 
+struct acpi_handle_list acpi_processor_list;
+EXPORT_SYMBOL(processor_list);
+
 /*
  * Creates hid/cid(s) string needed for modalias and uevent
  * e.g. on a device with hid:IBM0001 and cid:ACPI0001 you get:
@@ -1044,6 +1047,11 @@ static void acpi_device_set_id(struct acpi_device *device,
 		break;
 	case ACPI_BUS_TYPE_PROCESSOR:
 		hid = ACPI_PROCESSOR_HID;
+		if (acpi_processor_list.count < ACPI_MAX_HANDLES) {
+			acpi_processor_list.handles[acpi_processor_list.count]
+				=handle;
+			acpi_processor_list.count++;
+		}
 		break;
 	case ACPI_BUS_TYPE_SYSTEM:
 		hid = ACPI_SYSTEM_HID;

-- 
Matthew Garrett | mjg59@srcf.ucam.org
