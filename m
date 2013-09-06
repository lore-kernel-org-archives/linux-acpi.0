From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 04/14] ACPI: Remove unused OSC_PCI_NATIVE_HOTPLUG
Date: Fri, 06 Sep 2013 11:13:55 -0600
Message-ID: <20130906171355.11482.69220.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:35538 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab3IFRN6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2013 13:13:58 -0400
Received: by mail-yh0-f41.google.com with SMTP id f73so1326552yha.0
        for <linux-acpi@vger.kernel.org>; Fri, 06 Sep 2013 10:13:57 -0700 (PDT)
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

OSC_PCI_NATIVE_HOTPLUG is completely unused, so remove it.  No functional
change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/acpi.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 902cccf..94e5bca 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -345,9 +345,6 @@ extern bool osc_sb_apei_support_acked;
 				OSC_PCI_EXPRESS_AER_CONTROL |		\
 				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
 
-#define OSC_PCI_NATIVE_HOTPLUG	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL |	\
-				OSC_SHPC_NATIVE_HP_CONTROL)
-
 extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
 					     u32 *mask, u32 req);
 

