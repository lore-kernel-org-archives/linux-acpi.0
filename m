From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v1 3/3] PCI / ACPI: Implement Type 3 _HPX record
Date: Fri,  8 Feb 2019 10:24:13 -0600
Message-ID: <20190208162414.3996-4-mr.nuke.me@gmail.com>
References: <20190208162414.3996-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208162414.3996-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

_HPX Type 3 is intended to be more generic and allow configuration of
settings not possible with Type 2 tables. For example, FW could ensure
that the completion timeout value is set accordingly throughout the PCI
tree.

Implement support for _HPX3 tables.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pci-acpi.c      |  63 ++++++++++++++++++++
 drivers/pci/probe.c         | 114 ++++++++++++++++++++++++++++++++++++
 include/linux/pci_hotplug.h |  56 ++++++++++++++++++
 3 files changed, 233 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 95f4f86d2f34..03e02dd6c1d9 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -216,6 +216,64 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
+static void parse_hpx3_register(struct hpx_type3 *hpx3_reg,
+				union acpi_object *reg_fields)
+{
+	hpx3_reg->device_type            = reg_fields[0].integer.value;
+	hpx3_reg->function_type          = reg_fields[1].integer.value;
+	hpx3_reg->config_space_location  = reg_fields[2].integer.value;
+	hpx3_reg->pci_exp_cap_id         = reg_fields[3].integer.value;
+	hpx3_reg->pci_exp_cap_ver        = reg_fields[4].integer.value;
+	hpx3_reg->pci_exp_vendor_id      = reg_fields[5].integer.value;
+	hpx3_reg->dvsec_id               = reg_fields[6].integer.value;
+	hpx3_reg->dvsec_rev              = reg_fields[7].integer.value;
+	hpx3_reg->match_offset           = reg_fields[8].integer.value;
+	hpx3_reg->match_mask_and         = reg_fields[9].integer.value;
+	hpx3_reg->match_value            = reg_fields[10].integer.value;
+	hpx3_reg->reg_offset             = reg_fields[11].integer.value;
+	hpx3_reg->reg_mask_and           = reg_fields[12].integer.value;
+	hpx3_reg->reg_mask_or            = reg_fields[13].integer.value;
+}
+
+static acpi_status program_type3_hpx_record(struct pci_dev *dev,
+					   union acpi_object *record,
+					   const struct hotplug_program_ops *hp_ops)
+{
+	union acpi_object *fields = record->package.elements;
+	u32 desc_count, expected_length, revision;
+	union acpi_object *reg_fields;
+	struct hpx_type3 hpx3;
+	int i;
+
+	revision = fields[1].integer.value;
+	switch (revision) {
+	case 1:
+		desc_count = fields[2].integer.value;
+		expected_length = 3 + desc_count * 14;
+
+		if (record->package.count != expected_length)
+			return AE_ERROR;
+
+		for (i = 2; i < expected_length; i++)
+			if (fields[i].type != ACPI_TYPE_INTEGER)
+				return AE_ERROR;
+
+		for (i = 0; i < desc_count; i++) {
+			reg_fields = fields + 3 + i * 14;
+			parse_hpx3_register(&hpx3, reg_fields);
+			hp_ops->program_type3(dev, &hpx3);
+		}
+
+		break;
+	default:
+		printk(KERN_WARNING
+			"%s: Type 3 Revision %d record not supported\n",
+			__func__, revision);
+		return AE_ERROR;
+	}
+	return AE_OK;
+}
+
 static acpi_status acpi_run_hpx(struct pci_dev *dev, acpi_handle handle,
 				const struct hotplug_program_ops *hp_ops)
 {
@@ -275,6 +333,11 @@ static acpi_status acpi_run_hpx(struct pci_dev *dev, acpi_handle handle,
 				goto exit;
 			hp_ops->program_type2(dev, &hpx2);
 			break;
+		case 3:
+			status = program_type3_hpx_record(dev, record, hp_ops);
+			if (ACPI_FAILURE(status))
+				goto exit;
+			break;
 		default:
 			printk(KERN_ERR "%s: Type %d record not supported\n",
 			       __func__, type);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 527c209f0c94..5f3b6b1cd762 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1979,6 +1979,119 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
+static u16 hpx3_device_type(struct pci_dev *dev)
+{
+	u16 pcie_type = pci_pcie_type(dev);
+	const int pcie_to_hpx3_type[] = {
+		[PCI_EXP_TYPE_ENDPOINT]    = HPX_TYPE_ENDPOINT,
+		[PCI_EXP_TYPE_LEG_END]     = HPX_TYPE_LEG_END,
+		[PCI_EXP_TYPE_RC_END]      = HPX_TYPE_RC_END,
+		[PCI_EXP_TYPE_RC_EC]       = HPX_TYPE_RC_EC,
+		[PCI_EXP_TYPE_ROOT_PORT]   = HPX_TYPE_ROOT_PORT,
+		[PCI_EXP_TYPE_UPSTREAM]    = HPX_TYPE_UPSTREAM,
+		[PCI_EXP_TYPE_DOWNSTREAM]  = HPX_TYPE_DOWNSTREAM,
+		[PCI_EXP_TYPE_PCI_BRIDGE]  = HPX_TYPE_PCI_BRIDGE,
+		[PCI_EXP_TYPE_PCIE_BRIDGE] = HPX_TYPE_PCIE_BRIDGE,
+	};
+
+	if (pcie_type >= ARRAY_SIZE(pcie_to_hpx3_type))
+		return 0;
+
+	return pcie_to_hpx3_type[pcie_type];
+}
+
+static u8 hpx3_function_type(struct pci_dev *dev)
+{
+	if (dev->is_virtfn)
+		return HPX_FN_SRIOV_VIRT;
+	else if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV) > 0)
+		return HPX_FN_SRIOV_PHYS;
+	else
+		return HPX_FN_NORMAL;
+}
+
+static bool hpx3_cap_ver_matches(u8 pcie_cap_id, u8 hpx3_cap_id)
+{
+	u8 cap_ver = hpx3_cap_id & 0xf;
+
+	if ((hpx3_cap_id & BIT(4)) && cap_ver >= pcie_cap_id)
+		return true;
+	else if (cap_ver == pcie_cap_id)
+		return true;
+
+	return false;
+}
+
+static void program_hpx_type3_register(struct pci_dev *dev,
+				       const struct hpx_type3 *reg)
+{
+	u32 match_reg, write_reg, header, orig_value;
+	u16 pos;
+
+	if (!(hpx3_device_type(dev) & reg->device_type))
+		return;
+
+	if (!(hpx3_function_type(dev) & reg->function_type))
+		return;
+
+	switch (reg->config_space_location) {
+	case HPX_CFG_PCICFG:
+		pos = 0;
+		break;
+	case HPX_CFG_PCIE_CAP:
+		pos = pci_find_capability(dev, reg->pci_exp_cap_id);
+		if (pos == 0)
+			return;
+
+		break;
+	case HPX_CFG_PCIE_CAP_EXT:
+		pos = pci_find_ext_capability(dev, reg->pci_exp_cap_id);
+		if (pos == 0)
+			return;
+
+		pci_read_config_dword(dev, pos, &header);
+		if (!hpx3_cap_ver_matches(PCI_EXT_CAP_VER(header),
+					  reg->pci_exp_cap_ver))
+			return;
+
+		break;
+	case HPX_CFG_VEND_CAP:	/* Fall through */
+	case HPX_CFG_DVSEC:	/* Fall through */
+	default:
+		pci_warn(dev, "Encontered _HPX type 3 with unsupported config space location");
+		return;
+	}
+
+	pci_read_config_dword(dev, pos + reg->match_offset, &match_reg);
+
+	if ((match_reg & reg->match_mask_and) != reg->match_value)
+		return;
+
+	pci_read_config_dword(dev, pos + reg->reg_offset, &write_reg);
+	orig_value = write_reg;
+	write_reg &= reg->reg_mask_and;
+	write_reg |= reg->reg_mask_or;
+
+	if (orig_value == write_reg)
+		return;
+
+	pci_write_config_dword(dev, pos + reg->reg_offset, write_reg);
+
+	pci_dbg(dev, "Applied _HPX3 at [0x%x]: 0x%08x -> 0x%08x",
+		pos, orig_value, write_reg);
+}
+
+static void program_hpx_type3(struct pci_dev *dev, struct hpx_type3 *hpx3)
+{
+	if (!hpx3)
+		return;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	program_hpx_type3_register(dev, hpx3);
+}
+
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 {
 	struct pci_host_bridge *host;
@@ -2135,6 +2248,7 @@ static void pci_configure_device(struct pci_dev *dev)
 		.program_type0 = program_hpp_type0,
 		.program_type1 = program_hpp_type1,
 		.program_type2 = program_hpp_type2,
+		.program_type3 = program_hpx_type3,
 	};
 
 	pci_configure_mps(dev);
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index c85378edf235..24409dccb7cf 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -124,10 +124,66 @@ struct hpp_type2 {
 	u32 sec_unc_err_mask_or;
 };
 
+/*
+ * PCI Express Setting Record (Type 3)
+ * Should be good for another thirteen years until we need to handle some
+ * situation we didn't think of today.
+ */
+struct hpx_type3 {
+	u16 device_type;
+	u16 function_type;
+	u16 config_space_location;
+	u16 pci_exp_cap_id;
+	u16 pci_exp_cap_ver;
+	u16 pci_exp_vendor_id;
+	u16 dvsec_id;
+	u16 dvsec_rev;
+	u16 match_offset;
+	u32 match_mask_and;
+	u32 match_value;
+	u16 reg_offset;
+	u32 reg_mask_and;
+	u32 reg_mask_or;
+	struct list_head list;
+};
+
 struct hotplug_program_ops {
 	void (*program_type0)(struct pci_dev *dev, struct hpp_type0 *hpp);
 	void (*program_type1)(struct pci_dev *dev, struct hpp_type1 *hpp);
 	void (*program_type2)(struct pci_dev *dev, struct hpp_type2 *hpp);
+	void (*program_type3)(struct pci_dev *dev, struct hpx_type3 *hpp);
+};
+
+/*
+ * ACPI: The world leader in _almost_ getting bitfields right
+ * Would be nice if these matched the PCI_EXP_FLAGS_TYPE, but that would have
+ * made things too simple, and would actually have made sense. Can't have that!
+ */
+enum hpx_type3_dev_type {
+	HPX_TYPE_ENDPOINT	= BIT(0),
+	HPX_TYPE_LEG_END	= BIT(1),
+	HPX_TYPE_RC_END		= BIT(2),
+	HPX_TYPE_RC_EC		= BIT(3),
+	HPX_TYPE_ROOT_PORT	= BIT(4),
+	HPX_TYPE_UPSTREAM	= BIT(5),
+	HPX_TYPE_DOWNSTREAM	= BIT(6),
+	HPX_TYPE_PCI_BRIDGE	= BIT(7),
+	HPX_TYPE_PCIE_BRIDGE	= BIT(8),
+};
+
+enum hpx_type3_fn_type {
+	HPX_FN_NORMAL		= BIT(0),
+	HPX_FN_SRIOV_PHYS	= BIT(1),
+	HPX_FN_SRIOV_VIRT	= BIT(2),
+};
+
+enum hpx_type3_cfg_loc {
+	HPX_CFG_PCICFG		= 0,
+	HPX_CFG_PCIE_CAP	= 1,
+	HPX_CFG_PCIE_CAP_EXT	= 2,
+	HPX_CFG_VEND_CAP	= 3,
+	HPX_CFG_DVSEC		= 4,
+	HPX_CFG_MAX,
 };
 
 #ifdef CONFIG_ACPI
-- 
2.19.2
