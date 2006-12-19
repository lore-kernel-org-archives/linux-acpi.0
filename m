From: akpm@osdl.org
Subject: [patch 12/19] Add output class document
Date: Tue, 19 Dec 2006 12:56:18 -0800
Message-ID: <200612192056.kBJKuIBp010041@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:34484 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932950AbWLSU47 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 15:56:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, luming.yu@gmail.com, Luming.yu@intel.com, adaplas@pol.net, greg@kroah.com, len.brown@intel.com

From: Yu Luming <luming.yu@gmail.com>

Add output class document

Signed-off-by: Luming Yu <Luming.yu@intel.com>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/video-output.txt |   34 +++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+)

diff -puN /dev/null Documentation/video-output.txt
--- /dev/null
+++ a/Documentation/video-output.txt
@@ -0,0 +1,34 @@
+
+		Video Output Switcher Control
+		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+		2006 luming.yu@intel.com
+
+The output sysfs class driver provides an abstract video output layer that
+can be used to hook platform specific methods to enable/disable video output
+device through common sysfs interface. For example, on my IBM ThinkPad T42
+laptop, The ACPI video driver registered its output devices and read/write
+method for 'state' with output sysfs class. The user interface under sysfs is:
+
+linux:/sys/class/video_output # tree .
+.
+|-- CRT0
+|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+|   |-- state
+|   |-- subsystem -> ../../../class/video_output
+|   `-- uevent
+|-- DVI0
+|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+|   |-- state
+|   |-- subsystem -> ../../../class/video_output
+|   `-- uevent
+|-- LCD0
+|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+|   |-- state
+|   |-- subsystem -> ../../../class/video_output
+|   `-- uevent
+`-- TV0
+   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+   |-- state
+   |-- subsystem -> ../../../class/video_output
+   `-- uevent
+
_
