From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH] acpi: device_sysfs: update sysfs documentation
Date: Wed, 14 Feb 2018 00:24:10 +0530
Message-ID: <20180213185410.GA27234@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-acpi@vger.kernel.org

Add documentation for two attributes - status and hrv in
Documentation/ABI/testing/sysfs-bus-acpi. Compiled from git logs and the
ACPI specification.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
index 7fa9cbc75344..89feb01d1d0d 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -56,3 +56,39 @@ Description:
 		Writing 1 to this attribute will trigger hot removal of
 		this device object.  This file exists for every device
 		object that has _EJ0 method.
+
+What:		/sys/bus/acpi/devices/.../status
+Date:		Jan, 2014
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		(RO) Displays the ACPI device status - enabled, disabled or
+		functioning or present, if the method _STA is present.
+
+		Return value is an integer containing a device status bitmap:
+
+		Bit [0] –  Set if the device is present.
+		Bit [1] –  Set if the device is enabled and decoding its
+		resources.
+		Bit [2] –  Set if the device should be shown in the UI.
+		Bit [3] –  Set if the device is functioning properly (cleared if
+		device failed its diagnostics).
+		Bit [4] –  Set if the battery is present.
+		Bits [31:5] –  Reserved (must be cleared)
+
+		If bit [0] is cleared, then bit 1 must also be cleared (a device
+		that is not present cannot be enabled).
+
+		Bit 0 can be clear (not present) with bit [3] set (device is
+		functional). This case is used to indicate a valid device for
+		which no device driver should be loaded.
+
+		More special cases are covered in the ACPI specification.
+
+What:		/sys/bus/acpi/devices/.../hrv
+Date:		Apr, 2016
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		(RO) Allows users to read the hardware version of non-PCI
+		hardware, if the _HRV control method is present. It is most
+		useful for non-PCI devices because lspci can list the hardware
+		version for PCI devices.
-- 
2.16.1
