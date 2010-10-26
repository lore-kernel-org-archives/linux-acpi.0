From: yakui.zhao@intel.com
Subject: [RFC PATCH 3/4] IPMI: Add the document description of ipmi_get_smi_info
Date: Tue, 26 Oct 2010 17:14:13 +0800
Message-ID: <1288084454-560-4-git-send-email-yakui.zhao@intel.com>
References: <1288084454-560-1-git-send-email-yakui.zhao@intel.com>
 <1288084454-560-2-git-send-email-yakui.zhao@intel.com>
 <1288084454-560-3-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24764 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755024Ab0JZJTV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Oct 2010 05:19:21 -0400
In-Reply-To: <1288084454-560-3-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: openipmi-developer@lists.sourceforge.net, linux-acpi@vger.kernel.org
Cc: minyard@acm.org, lenb@kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Add the document description about how to use ipmi_get_smi_info/
ipmi_put_smi_info.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 Documentation/IPMI.txt |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/Documentation/IPMI.txt b/Documentation/IPMI.txt
index 69dd29e..4683424 100644
--- a/Documentation/IPMI.txt
+++ b/Documentation/IPMI.txt
@@ -533,6 +533,47 @@ completion during sending a panic event.
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
+    The function of ipmi_get_smi_info/ipmi_put_smi_info is added to get the
+detailed info of IPMI device. The following is the struct definition of
+ipmi_smi_info(Now only ACPI info is defined. If the info is required for
+other IPMI address type, please add it).
+struct ipmi_smi_info{
+	enum ipmi_addr_src addr_src;
+	struct device *dev;
+	/*
+	 * The addr_info can provide more detailed info of one IPMI device.
+	 * Now only SI_ACPI info is provided. And it depends on the SI_ACPI
+	 * address type. If the info is required for other address type, please
+	 * add it.
+	 */
+	union {
+#ifdef CONFIG_ACPI
+		/* the acpi_info element is defined for the SI_ACPI
+		 * address type
+		 */
+		struct {
+			void *acpi_handle;
+		} acpi_info;
+#endif
+		u8 addr_data[8]; /* This is only to reserve 8 bytes space */
+	} addr_info;
+};
+	It is noted that the dev pointer is included in the above structure
+definition. In order to assure that the device is correctly accessed, the
+increment/decrement of the reference count is considered. The reference count
+is increased in the function of ipmi_get_smi_info while it is decreased in
+the function of ipmi_put_smi_info. In such case the ipmi_put_smi_info must be
+called after the ipmi_get_smi_info is called successfully.
+
 Watchdog
 --------
 
-- 
1.5.4.5

