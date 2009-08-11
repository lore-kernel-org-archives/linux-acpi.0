From: Mark Langsdorf <mark.langsdorf@amd.com>
Subject: [PATCH][ACPI] AC/DC notifier
Date: Tue, 11 Aug 2009 15:15:42 -0500
Message-ID: <200908111515.42635.mark.langsdorf@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932130AbZHKUJz@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.tippett@amd.com, samuel.li@amd.com
List-Id: linux-acpi@vger.kernel.org

Add an ACPI event notifier for AC/DC connect/disconnect events.

Signed-off-by: Mark Langsdorf <mark.langsdorf@amd.com>

---
 drivers/acpi/ac.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 0df8fcb..656b903 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -243,6 +243,7 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  dev_name(&device->dev), event,
 						  (u32) ac->state);
+		acpi_notifier_call_chain(device, event, (u32) ac->state);
 #ifdef CONFIG_ACPI_SYSFS_POWER
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
 #endif
-- 
1.6.0.2
