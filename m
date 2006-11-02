From: Yu Luming <luming.yu@gmail.com>
Subject: [patch 4/6] Add output class document
Date: Thu, 2 Nov 2006 13:22:51 +0000 (UTC)
Message-ID: <200611042122.00950.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:63910 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752848AbWKBNWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Nov 2006 08:22:18 -0500
Received: by wx-out-0506.google.com with SMTP id s14so118173wxc
        for <linux-acpi@vger.kernel.org>; Thu, 02 Nov 2006 05:22:17 -0800 (PST)
Date: Sat, 4 Nov 2006 21:22:00 +0800
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>

Add output class document

signed-off-by =A0 Luming.yu@gmail.com
---
[patch 4/6] Add output class document
 video-output.txt |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/video-output.txt b/Documentation/video-outpu=
t.txt
new file mode 100644
index 0000000..71b1dba
--- /dev/null
+++ b/Documentation/video-output.txt
@@ -0,0 +1,34 @@
+
+		Video Output Switcher Control
+		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+		2006 luming.yu@gmail.com
+
+The output sysfs class driver is to provide video output abstract laye=
r that=20
+can be used to hook platform specific methods to enable/disable video =
output
+device through common sysfs interface. For example, on my IBM Thinkpad=
 T42=20
+aptop, acpi video driver registered its output devices and read/write =
method
+for state with output sysfs class. The user interface under sysfs is :
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
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
