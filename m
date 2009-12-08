From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 4/4] acpi, apei, Document for APEI
Date: Tue, 08 Dec 2009 15:55:17 +0800
Message-ID: <1260258917.13131.29.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18961 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755230AbZLHHzN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Dec 2009 02:55:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Add document for APEI, including kernel parameters and EINJ debug file
sytem interface.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 Documentation/acpi/apei/einj.txt    |   49 ++++++++++++++++++++++++++++++++++++
 Documentation/kernel-parameters.txt |    5 +++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/acpi/apei/einj.txt

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
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -338,6 +338,11 @@ and is between 256 and 4096 characters. 
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


