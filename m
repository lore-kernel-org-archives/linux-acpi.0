From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/11] SFI: Simple Firmware Interface - MAINTAINERS, Kconfig
Date: Fri, 14 Aug 2009 16:38:10 -0400
Message-ID: <792b9487f859c9fa3756adafa7ad1778c0c46e99.1250281826.git.len.brown@intel.com>
References: <1250282295-25216-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:60781 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbZHNUk2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 16:40:28 -0400
In-reply-to: <1250282295-25216-1-git-send-email-lenb@kernel.org>
In-reply-to: <0763223ab0ef5c0016b7a179c1acccaabbefea02.1250281826.git.len.brown@intel.com>
References: <0763223ab0ef5c0016b7a179c1acccaabbefea02.1250281826.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

CONFIG_SFI=y enables the kernel to boot and run optimally
on platforms that support the Simple Firmware Interface.

Thanks to Jacob Pan for prototyping the initial Linux SFI support,
and to Feng Tang for Linux bring-up and debug both in emulation
and on Moorestown hardware.

See http://simplefirmware.org for more information on SFI.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS         |   12 ++++++++++++
 drivers/sfi/Kconfig |   17 +++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 drivers/sfi/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index b1114cf..d6d6fc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4561,6 +4561,18 @@ L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	drivers/pci/hotplug/shpchp*
 
+SIMPLE FIRMWARE INTERFACE (SFI)
+P:	Len Brown
+M:	lenb@kernel.org
+L:	sfi-devel@simplefirmware.org
+W:	http://simplefirmware.org/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
+S:	Supported
+F:	arch/x86/kernel/*sfi*
+F:	drivers/sfi/
+F:	include/linux/sfi*.h
+
+
 SIMTEC EB110ATX (Chalice CATS)
 P:	Ben Dooks
 M:	Vincent Sanders <support@simtec.co.uk>
diff --git a/drivers/sfi/Kconfig b/drivers/sfi/Kconfig
new file mode 100644
index 0000000..dd11512
--- /dev/null
+++ b/drivers/sfi/Kconfig
@@ -0,0 +1,17 @@
+#
+# SFI Configuration
+#
+
+menuconfig SFI
+	bool "SFI (Simple Firmware Interface) Support"
+	---help---
+	The Simple Firmware Interface (SFI) provides a lightweight method
+	for platform firmware to pass information to the operating system
+	via static tables in memory.  Kernel SFI support is required to
+	boot on SFI-only platforms.  Currently, all SFI-only platforms are
+	based on the 2nd generation Intel Atom processor platform,
+	code-named Moorestown.
+
+	For more information, see http://simplefirmware.org
+
+	Say 'Y' here to enable the kernel to boot on SFI-only platforms.
-- 
1.6.0.6

