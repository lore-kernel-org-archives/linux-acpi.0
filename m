From: "Thomas, Sujith" <sujith.thomas@intel.com>
Subject: [PATCH]1/3 intel_menlow:Adding comment for GTHS legal values
Date: Wed, 5 Nov 2008 16:15:13 +0530
Message-ID: <7D0189F5BE1DF549A570B212D1D5612182AF02@bgsmsx412.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:20250 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbYKEKqy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 05:46:54 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Documentation of legal values for GTHS
To be patched over Rui's 09/11 bug fix patch

Signed-off-by: Sujith Thomas <sujith.thomas@intel.com>
---
 drivers/misc/intel_menlow.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6.27/drivers/misc/intel_menlow.c
===================================================================
--- linux-2.6.27.orig/drivers/misc/intel_menlow.c
+++ linux-2.6.27/drivers/misc/intel_menlow.c
@@ -52,6 +52,11 @@ MODULE_LICENSE("GPL");
 #define MEMORY_ARG_CUR_BANDWIDTH 1
 #define MEMORY_ARG_MAX_BANDWIDTH 0
 
+/*
+ * GTHS returning 'n' would mean that [0,n-1] states are supported
+ * In that case max_cstate would be n-1
+ * GTHS returning '0' would mean that no bandwidth control states are
supported
+ */
 static int memory_get_int_max_bandwidth(struct thermal_cooling_device
*cdev,
 					unsigned long *max_state)
 {
