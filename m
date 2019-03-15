From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v1 4/4] PCI/ACPI: Advertise HPX type 3 support via _OSC
Date: Fri, 15 Mar 2019 14:29:40 -0500
Message-ID: <20190315192947.13807-1-mr.nuke.me@gmail.com>
References: <20190307213834.5914-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307213834.5914-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

_OSC now has a way to inform firmware that OS has the capability to
interpret HPX type 3 tables. Since ACPI 6.3 deprecated _OSC specifics,
these are now part of the PCI Firmware Specification.

The following is the document describing the changes:
ECN:	_HPX and PCIe Completion Timeout related _OSC Enhancements
Date:	September 12, 2018
Affected Document: PCI Firmware Specification, Rev. 3.2

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

This patch is designed to go on top of the following series
"PCI: ACPI: Implement support for _HPX Type 3 tables"
	https://lkml.org/lkml/2019/3/7/790

Although the patch can technically be applied independently, it
doesn't make sense without the rest of the series.

The HPX3 capability bit, to my understanding, is designed to be
informational. i.e. Setting or not setting it would not affect whether
firmware would export HPX3 tables. It may have implications in FFS
systems, where FW might need to make sure things like the completion
timeout value is set correctly throughout the tree.

My understanding is that firmware will prefer to set these with HPX3,
in lieu of firing up SMM on hotplug and other events. Firmware can use
the HPX3 support bit to know how to proceed.

 drivers/acpi/pci_root.c | 2 ++
 include/linux/acpi.h    | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 707aafc7c2aa..0bee23893297 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -145,6 +145,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
 	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
 	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
 	{ OSC_PCI_MSI_SUPPORT, "MSI" },
+	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-type3" },
 };
 
 static struct pci_osc_bit_struct pci_osc_control_bit[] = {
@@ -446,6 +447,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	 * PCI domains, so we indicate this in _OSC support capabilities.
 	 */
 	support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
+	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
 	if (pci_ext_cfg_avail())
 		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
 	if (pcie_aspm_support_enabled())
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f20b69a..028c138b9082 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -508,7 +508,8 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
 #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
 #define OSC_PCI_MSI_SUPPORT			0x00000010
-#define OSC_PCI_SUPPORT_MASKS			0x0000001f
+#define OSC_PCI_HPX_TYPE_3_SUPPORT		0x00000100
+#define OSC_PCI_SUPPORT_MASKS			0x0000011f
 
 /* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
 #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	0x00000001
-- 
2.19.2
