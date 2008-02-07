From: Len Brown <lenb@kernel.org>
Subject: [PATCH 002/112] ACPI: document method tracing hooks
Date: Thu,  7 Feb 2008 04:33:24 -0500
Message-ID: <b4d2730a0dda91a43c81a02f5225f5d536cabb09.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753894AbYBGJfU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:20 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/00-INDEX                |    3 +++
 Documentation/acpi/method-tracing.txt |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/acpi/method-tracing.txt

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 299615d..161edbc 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -14,6 +14,7 @@ Following translations are available on the WWW:
 	- this file.
 ABI/
 	- info on kernel <-> userspace ABI and relative interface stability.
+
 BUG-HUNTING
 	- brute force method of doing binary search of patches to find bug.
 Changes
@@ -66,6 +67,8 @@ VGA-softcursor.txt
 	- how to change your VGA cursor from a blinking underscore.
 accounting/
 	- documentation on accounting and taskstats.
+acpi/
+	- info on ACPI-specific hooks in the kernel.
 aoe/
 	- description of AoE (ATA over Ethernet) along with config examples.
 applying-patches.txt
diff --git a/Documentation/acpi/method-tracing.txt b/Documentation/acpi/method-tracing.txt
new file mode 100644
index 0000000..f6efb1e
--- /dev/null
+++ b/Documentation/acpi/method-tracing.txt
@@ -0,0 +1,26 @@
+/sys/module/acpi/parameters/:
+
+trace_method_name
+	The AML method name that the user wants to trace
+
+trace_debug_layer
+	The temporary debug_layer used when tracing the method.
+	Using 0xffffffff by default if it is 0.
+
+trace_debug_level
+	The temporary debug_level used when tracing the method.
+	Using 0x00ffffff by default if it is 0.
+
+trace_state
+	The status of the tracing feature.
+
+	"enabled" means this feature is enabled
+	and the AML method is traced every time it's executed.
+
+	"1" means this feature is enabled and the AML method
+	will only be traced during the next execution.
+
+	"disabled" means this feature is disabled.
+	Users can enable/disable this debug tracing feature by
+	"echo string > /sys/module/acpi/parameters/trace_state".
+	"string" should be one of "enable", "disable" and "1".
-- 
1.5.4.23.gef5b9

