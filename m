From: Yu Luming <luming.yu@gmail.com>
Subject: [patch 4/5] Add output class document
Date: Wed, 8 Nov 2006 00:54:52 +0800
Message-ID: <200611080054.53220.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:28370 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1753774AbWKGQz6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Nov 2006 11:55:58 -0500
Received: by nz-out-0102.google.com with SMTP id z3so1187127nzf
        for <linux-acpi@vger.kernel.org>; Tue, 07 Nov 2006 08:55:57 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>

Patch 4/5: add output class document

signed-off-by: Luming Yu <Luming.yu@intel.com>
---
 video-output.txt |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/video-output.txt b/Documentation/video-output.txt
new file mode 100644
index 0000000..cf0f3c2
--- /dev/null
+++ b/Documentation/video-output.txt
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
+method for 'state' with output sysfs class. The user interface under sysfs 
is:
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
