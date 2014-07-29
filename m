From: Paul Bolle <pebolle@tiscali.nl>
Subject: ACPI / dock: ThinkPad X220: \_SB_.PCI0.LPC_.EC__.BAT1: Unable to
 dock!
Date: Tue, 29 Jul 2014 23:46:14 +0200
Message-ID: <1406670374.2406.27.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:54997 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbaG2VvX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Jul 2014 17:51:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Rubin Abdi <rubin@starset.net>, linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org

0) A ThinkPad X220 I use prints this error at the _first_ resume from
suspend (to ram):
    ACPI: \_SB_.PCI0.LPC_.EC__.BAT1: Unable to dock!

1) BAT1 is apparently a "battery bay". Rubin suggested that it is a
"slice" battery. I do not use a "slice" battery. (There are two other
possible docks according to the ACPI printks is get. An "ata bay" and a
"dock station". I don't use those either, but the kernel at least prints
no errors about them.)

2) I've peeked a bit at the DSDT of this machine. Its _WAK method
contains this line:
    \_SB.PCI0.LPC.EC.BATW (Arg0)

That BATW method is about 12 lines long. (Can I quote that in full?) It
ends with this snippet:
    If (XOr (Local0, Local1))
    {
        Store (Local1, [...])
        Notify (\_SB.PCI0.LPC.EC.BAT1, 0x01) // Device Check
    }

3) That ACPI_NOTIFY_DEVICE_CHECK for BAT1 apparently triggers this call
chain:
    acpi_bus_notify()
        acpi_hotplug_schedule()
            acpi_hotplug_work_fn()
                acpi_device_hotplug()
                    dock_notify()

4) Perhaps Lenovo needs to update the ACPI part of this laptop's
firmware. (I'm running the latest firmware.) Does Lenovo listen to
suggestions to update its firmware?

5) A workaround in the kernel _might_ be something utterly untested like
this:

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index d9339b442a4e..9e5856a6adfb 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -333,7 +333,7 @@ static void dock_event(struct dock_station *ds, u32 event, int num)
  *
  * Execute the _DCK method in response to an acpi event
  */
-static void handle_dock(struct dock_station *ds, int dock)
+static acpi_status handle_dock(struct dock_station *ds, int dock)
 {
 	acpi_status status;
 	struct acpi_object_list arg_list;
@@ -351,11 +351,12 @@ static void handle_dock(struct dock_station *ds, int dock)
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
 		acpi_handle_err(ds->handle, "Failed to execute _DCK (0x%x)\n",
 				status);
+	return status;
 }
 
-static inline void dock(struct dock_station *ds)
+static inline acpi_status dock(struct dock_station *ds)
 {
-	handle_dock(ds, 1);
+	return handle_dock(ds, 1);
 }
 
 static inline void undock(struct dock_station *ds)
@@ -471,8 +472,12 @@ int dock_notify(struct acpi_device *adev, u32 event)
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		if (!dock_in_progress(ds) && !acpi_device_enumerated(adev)) {
+			acpi_status status;
+
 			begin_dock(ds);
-			dock(ds);
+			status = dock(ds);
+			if (status == AE_NOT_FOUND)
+				break;
 			if (!dock_present(ds)) {
 				acpi_handle_err(handle, "Unable to dock!\n");
 				complete_dock(ds);

Please note that BAT1 does have a _EJ0 method but doesn't have a _DCK
method.

6) Any suggestions?


Paul Bolle

