From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/12] SFI: Simple Firmware Interface - new MAINTAINERS entry
Date: Wed, 08 Jul 2009 00:13:47 -0400
Message-ID: <8e4a93858bce74ed3080dd607aa471023f1a2737.1247025117.git.len.brown@intel.com>
References: <1247026438-20891-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:43329 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbZGHEOF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jul 2009 00:14:05 -0400
In-reply-to: <1247026438-20891-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

CONFIG_SFI=y shall enable the kernel to boot and run optimally
on platforms that support the Simple Firmware Interface.

Thanks to Jacob Pan for prototyping the initial Linux SFI support,
and to Feng Tang for Linux bring-up and debug both in emulation
and on Moorestown hardware.

See http://simplefirmware.org for more information on SFI.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 381190c..2c03d31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5298,6 +5298,18 @@ L:	linux-pci@vger.kernel.org
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
 P:	Vincent Sanders
-- 
1.6.0.6

