From: yakui.zhao@intel.com
Subject: [RFC PATCH 3/4] IPMI: Add the document description of ipmi_get_smi_info
Date: Fri, 22 Oct 2010 17:10:40 +0800
Message-ID: <1287738641-11490-4-git-send-email-yakui.zhao@intel.com>
References: <1287738641-11490-1-git-send-email-yakui.zhao@intel.com>
 <1287738641-11490-2-git-send-email-yakui.zhao@intel.com>
 <1287738641-11490-3-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:27822 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704Ab0JVJPo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Oct 2010 05:15:44 -0400
In-Reply-To: <1287738641-11490-3-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: openipmi-developer@lists.sourceforge.net, linux-acpi@vger.kernel.org
Cc: minyard@acm.org, lenb@kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Add the document description about how to use ipmi_get_smi_info.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 Documentation/IPMI.txt |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/Documentation/IPMI.txt b/Documentation/IPMI.txt
index 69dd29e..0b8aecc 100644
--- a/Documentation/IPMI.txt
+++ b/Documentation/IPMI.txt
@@ -533,6 +533,43 @@ completion during sending a panic event.
 Other Pieces
 ------------
 
+Get the detailed info related with the IPMI device
+--------
+The IPMI smi_watcher will be used to catch the IPMI interface as they come or go.
+In order to communicate with the correct IPMI device, it should be confirmed
+ whether it is what we wanted especially on the system with multiple IPMI
+devices. But the new_smi callback function of smi_watcher provides very
+limited info(only the interface number and dev pointer) and there is no
+detailed info about the low level interface. For example: which mechansim
+registers the IPMI interface(ACPI, PCI, DMI and so on).
+    The function of ipmi_get_smi_info is added to get the
+detailed info of IPMI device. The following is the struct definition of
+ipmi_smi_info(Now only ACPI info is defined. If the info is required for
+other IPMI device type, please add it) .
+     struct ipmi_smi_info{
+        enum ipmi_addr_src addr_src;
+        struct device *dev;
+        union {
+                /*
+                 * Now only SI_ACPI info is provided. If the info is required
+                 * for other type, please add it
+                 */
+#ifdef CONFIG_ACPI
+                struct {
+                        void *acpi_handle;
+                } acpi_info;
+#endif
+        } smi_info;
+};
+
+	The following is the definition of ipmi_get_smi_info.
+	extern int ipmi_get_smi_info(int if_num, enum ipmi_addr_src type,
+		struct ipmi_smi_info **data);
+	It is noted that the returned smi_data is not the dynamically
+allocated memory. It is only the pointer of the corresponding info stored
+in IPMI device. In such case the caller don't try to free the corresponding
+memory.
+
 Watchdog
 --------
 
-- 
1.5.4.5

