From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / dock: Use acpi_device_enumerated() to check if dock is present
Date: Sat, 08 Feb 2014 16:17:10 +0100
Message-ID: <11510342.Z0olNXfrHj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60532 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751760AbaBHPCg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Feb 2014 10:02:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 202317a573b2 (ACPI / scan: Add acpi_device objects for
all device nodes in the namespace) acpi_bus_get_device() will always
return 0 for dock devices in dock_notify(), so the dock station
docking code under ACPI_NOTIFY_DEVICE_CHECK will never be executed
and docking will not work as a result of that.

Fix the problem by making dock_notify() use acpi_device_enumerated()
to check the presence of the device instead of checking the return
value of acpi_bus_get_device().

Fixes: 202317a573b2 (ACPI / scan: Add acpi_device objects for all device nodes in the namespace)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Hi All,

If I'm not mistaken, ACPI dock station docking is broken in 3.14-rc1 and this
patch should fix it.

Can anyone who happens to own a dock station with ACPI-based dock/undock
signaling verify this for me, please?

Rafael

---
 drivers/acpi/dock.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c
+++ linux-pm/drivers/acpi/dock.c
@@ -609,7 +609,7 @@ static int handle_eject_request(struct d
 static void dock_notify(struct dock_station *ds, u32 event)
 {
 	acpi_handle handle = ds->handle;
-	struct acpi_device *ad;
+	struct acpi_device *adev = NULL;
 	int surprise_removal = 0;
 
 	/*
@@ -632,7 +632,8 @@ static void dock_notify(struct dock_stat
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		if (!dock_in_progress(ds) && acpi_bus_get_device(handle, &ad)) {
+		acpi_bus_get_device(handle, &adev);
+		if (!dock_in_progress(ds) && !acpi_device_enumerated(adev)) {
 			begin_dock(ds);
 			dock(ds);
 			if (!dock_present(ds)) {

