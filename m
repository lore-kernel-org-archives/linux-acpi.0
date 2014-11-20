From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v4] ACPICA/Events: Add support to ensure GPE is disabled by default for handlers.
Date: Thu, 20 Nov 2014 14:44:59 +0800
Message-ID: <ce3ab540463bc5d97e527f24ca7d7d82b2952fae.1416459350.git.lv.zheng@intel.com>
References: <20141119121615.GA2514@node.dhcp.inet.fi>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55000 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbaKTGpK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Nov 2014 01:45:10 -0500
In-Reply-To: <20141119121615.GA2514@node.dhcp.inet.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Kirill A. Shutemov" <kirill@shutemov.name>

On some platforms, GPE is not disabled by default after ACPI hardware is
enabled. This confuses GPE drivers. This patch adds support to disable GPE
by default for GPE handler drivers.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
---
 drivers/acpi/acpica/evxface.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-acpica/drivers/acpi/acpica/evxface.c
===================================================================
--- linux-acpica.orig/drivers/acpi/acpica/evxface.c
+++ linux-acpica/drivers/acpi/acpica/evxface.c
@@ -821,6 +821,14 @@ acpi_install_gpe_handler(acpi_handle gpe
 	    ~(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
 	gpe_event_info->flags |= (u8)(type | ACPI_GPE_DISPATCH_HANDLER);
 
+	/*
+	 * Make sure that the GPE is disabled by default for the GPE
+	 * handler driver. It is expected that the GPE handler driver
+	 * should invoke acpi_enable_gpe() after installing the GPE
+	 * handler.
+	 */
+	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
+
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 
 unlock_and_exit:
