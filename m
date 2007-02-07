From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/140] output: Add output class document
Date: Wed,  7 Feb 2007 13:50:28 -0500
Message-ID: <1170874393736-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:26840 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422720AbXBGSxP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:15 -0500
In-Reply-To: <1170874390715-git-send-email-lenb@kernel.org>
Message-Id: <b03637b8863159a4518cb0a9ab90577460fe3417.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Yu Luming <luming.yu@gmail.com>, Luming Yu <Luming.yu@intel.com>, Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>

From: Yu Luming <luming.yu@gmail.com>

Signed-off-by: Luming Yu <Luming.yu@intel.com>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/video-output.txt |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/video-output.txt

diff --git a/Documentation/video-output.txt b/Documentation/video-output.txt
new file mode 100644
index 0000000..e517011
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
-- 
1.5.0.rc3.39.gec804
