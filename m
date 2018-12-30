From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / power: Skip duplicate power-resources in PR tables
Date: Sun, 30 Dec 2018 18:25:00 +0100
Message-ID: <20181230172500.17189-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Some ACPI tables contain duplicate resources like this:

        Name (_PR0, Package (0x04)  // _PR0: Power Resources for D0
        {
            P28P,
            P18P,
            P18P,
            CLK4
        })

This causes a WARN_ON in sysfs_add_link_to_group because we end up
adding a link to the same acpi_device twice:

sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/808622C1:00/OVTI2680:00/power_resources_D0/LNXPOWER:0a'
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.12-301.fc29.x86_64 #1
Hardware name: Insyde CherryTrail/Type2 - Board Product Name, BIOS jumperx.T87.KFBNEEA02 04/13/2016
Call Trace:
 dump_stack+0x5c/0x80
 sysfs_warn_dup.cold.3+0x17/0x2a
 sysfs_do_create_link_sd.isra.2+0xa9/0xb0
 sysfs_add_link_to_group+0x30/0x50
 acpi_power_expose_list+0x74/0xa0
 acpi_power_add_remove_device+0x50/0xa0
 acpi_add_single_object+0x26b/0x5f0
 acpi_bus_check_add+0xc4/0x250
 ...

This commit makes acpi_extract_power_resources() check for duplicates and
simply skips them when found, fixing this.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/power.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 1b475bc1ae16..bc10a5efc1ba 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -131,6 +131,23 @@ void acpi_power_resources_list_free(struct list_head *list)
 	}
 }
 
+static bool acpi_power_resource_is_dup(union acpi_object *package,
+				       unsigned int start, unsigned int i)
+{
+	acpi_handle rhandle, dup;
+	unsigned int j;
+
+	/* Note the element types have already been checked in our caller */
+	rhandle = package->package.elements[i].reference.handle;
+	for (j = start; j < i; j++) {
+		dup = package->package.elements[j].reference.handle;
+		if (dup == rhandle)
+			return true;
+	}
+
+	return false;
+}
+
 int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
 				 struct list_head *list)
 {
@@ -150,6 +167,11 @@ int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
 			err = -ENODEV;
 			break;
 		}
+
+		/* Some ACPI tables contain duplicate resources, skip these */
+		if (acpi_power_resource_is_dup(package, start, i))
+			continue;
+
 		err = acpi_add_power_resource(rhandle);
 		if (err)
 			break;
-- 
2.20.1
