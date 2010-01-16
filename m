From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/8] ACPI, APEI, Document for APEI
Date: Sat, 16 Jan 2010 02:34:16 -0500
Message-ID: <0be57be6c50fd0157058bb2e9d51b0848de2fb61.1263627201.git.len.brown@intel.com>
References: <1263627256-21501-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:39028 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab0APHe1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:34:27 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB00ES8X1896H0@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:34:21 -0600 (CST)
In-reply-to: <1263627256-21501-1-git-send-email-lenb@kernel.org>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1263627201.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1263627201.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <len.brown@intel.com>

From: Huang Ying <ying.huang@intel.com>

Add document for APEI, including kernel parameters and EINJ debug file
sytem interface.

Signed-off-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/acpi/apei/einj.txt    |   49 +++++++++++++++++++++++++++++++++++
 Documentation/kernel-parameters.txt |    5 +++
 2 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/acpi/apei/einj.txt

diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/acpi/apei/einj.txt
new file mode 100644
index 0000000..438ef33
--- /dev/null
+++ b/Documentation/acpi/apei/einj.txt
@@ -0,0 +1,49 @@
+			APEI Error INJection
+			~~~~~~~~~~~~~~~~~~~~
+
+EINJ provides a hardware error injection mechanism, it is very useful
+for debugging and testing of other APEI and RAS features.
+
+To use EINJ, make the following is enabled in your kernel
+configuration:
+
+CONFIG_DEBUG_FS
+CONFIG_ACPI_APEI
+CONFIG_ACPI_APEI_EINJ
+
+The user interface of EINJ is in debug file system, under the
+directory apei/einj. The following files are provided.
+
+- available_error_type
+  Read this file will return the error injection capability of the
+  platform, that is, which error types are supported. The error type
+  definition is as follow, the left field is the error type value, the
+  right field is error description.
+
+    0x00000001	Processor Correctable
+    0x00000002	Processor Uncorrectable non-fatal
+    0x00000004	Processor Uncorrectable fatal
+    0x00000008  Memory Correctable
+    0x00000010  Memory Uncorrectable non-fatal
+    0x00000020  Memory Uncorrectable fatal
+    0x00000040	PCI Express Correctable
+    0x00000080	PCI Express Uncorrectable fatal
+    0x00000100	PCI Express Uncorrectable non-fatal
+    0x00000200	Platform Correctable
+    0x00000400	Platform Uncorrectable non-fatal
+    0x00000800	Platform Uncorrectable fatal
+
+  The format of file contents are as above, except there are only the
+  available error type lines.
+
+- error_type
+  This file is used to set the error type value. The error type value
+  is defined in "available_error_type" description.
+
+- error_inject
+  Write any integer to this file to trigger the error
+  injection. Before this, please specify all necessary error
+  parameters.
+
+For more information about EINJ, please refer to ACPI specification
+version 4.0, section 17.5.
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5ba4d9d..7077cbb 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -338,6 +338,11 @@ and is between 256 and 4096 characters. It is defined in the file
 			not play well with APC CPU idle - disable it if you have
 			APC and your system crashes randomly.
 
+	apei.hest_disable= [ACPI]
+			Disable Hardware Error Source Table (HEST) support,
+			corresponding firmware-first mode error processing
+			logic will be disabled.
+
 	apic=		[APIC,X86-32] Advanced Programmable Interrupt Controller
 			Change the output verbosity whilst booting
 			Format: { quiet (default) | verbose | debug }
-- 
1.6.0.6

