From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 05/14] ACPI: Write OSC_PCI_CONTROL_MASKS like
 OSC_PCI_SUPPORT_MASKS
Date: Fri, 06 Sep 2013 11:14:02 -0600
Message-ID: <20130906171402.11482.40109.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

We write OSC_PCI_SUPPORT_MASKS as a simple 0x1f, so do the same
for OSC_PCI_CONTROL_MASKS.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/acpi.h |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 94e5bca..7bda6a2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -338,12 +338,7 @@ extern bool osc_sb_apei_support_acked;
 #define OSC_PCI_EXPRESS_PME_CONTROL		0x00000004
 #define OSC_PCI_EXPRESS_AER_CONTROL		0x00000008
 #define OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL	0x00000010
-
-#define OSC_PCI_CONTROL_MASKS 	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL | 	\
-				OSC_SHPC_NATIVE_HP_CONTROL | 		\
-				OSC_PCI_EXPRESS_PME_CONTROL |		\
-				OSC_PCI_EXPRESS_AER_CONTROL |		\
-				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
+#define OSC_PCI_CONTROL_MASKS			0x0000001f
 
 extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
 					     u32 *mask, u32 req);
