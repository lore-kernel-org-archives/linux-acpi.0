From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4]An implementation for binding PCI device with ACPI
 device
Date: Wed, 05 Jan 2005 10:50:55 +0800
Message-ID: <1104893450.5550.131.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-sK70/UqPLp/43NSJvM/9"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-sK70/UqPLp/43NSJvM/9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
This is an implementation for binding ACPI devices with PCI devices.

Thanks,
Shaohua

Signed-off-by: Li Shaohua<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

 2.5-root/drivers/pci/pci-acpi.c |   46 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+)

diff -puN drivers/pci/pci-acpi.c~bind-acpi-pci drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~bind-acpi-pci	2005-01-05 09:57:26.863944152 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-05 09:57:26.866943696 +0800
@@ -207,3 +207,49 @@ acpi_status pci_osc_control_set(u32 flag
 	return status;
 }
 EXPORT_SYMBOL(pci_osc_control_set);
+
+/* ACPI bus type */
+int pci_acpi_bind_device(struct device *dev, acpi_handle *handle)
+{
+	struct pci_dev * pci_dev;
+	acpi_integer	addr;
+
+	pci_dev = to_pci_dev(dev);
+	/* Please ref to ACPI spec for the syntax of _ADR */
+	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
+	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
+}
+
+static int pci_acpi_bind_root_bridge(struct device *dev, acpi_handle *handle)
+{
+	int num;
+	unsigned int seg, bus;
+
+	num = sscanf(dev->bus_id, "pci%04x:%02x", &seg, &bus);
+	if (num != 2)
+		return -ENODEV;
+	*handle = acpi_get_pci_rootbridge_handle(seg, bus);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
+}
+
+static struct acpi_bus_type pci_acpi_bus = {
+	.bus = &pci_bus_type,
+	.find_device = pci_acpi_bind_device,
+	.find_bridge = pci_acpi_bind_root_bridge,
+};
+
+static int __init pci_acpi_init(void)
+{
+	int ret;
+
+	ret = register_acpi_bus_type(&pci_acpi_bus);
+	if (ret)
+		return 0;
+	return 0;
+}
+arch_initcall(pci_acpi_init);
_


--=-sK70/UqPLp/43NSJvM/9
Content-Disposition: attachment; filename=p00002_bind-acpi-pci.patch
Content-Type: text/x-patch; name=p00002_bind-acpi-pci.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


An implementation for binding ACPI devices with PCI devices.

---

 2.5-root/drivers/pci/pci-acpi.c |   46 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+)

diff -puN drivers/pci/pci-acpi.c~bind-acpi-pci drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~bind-acpi-pci	2005-01-05 09:57:26.863944152 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-05 09:57:26.866943696 +0800
@@ -207,3 +207,49 @@ acpi_status pci_osc_control_set(u32 flag
 	return status;
 }
 EXPORT_SYMBOL(pci_osc_control_set);
+
+/* ACPI bus type */
+int pci_acpi_bind_device(struct device *dev, acpi_handle *handle)
+{
+	struct pci_dev * pci_dev;
+	acpi_integer	addr;
+
+	pci_dev = to_pci_dev(dev);
+	/* Please ref to ACPI spec for the syntax of _ADR */
+	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
+	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
+}
+
+static int pci_acpi_bind_root_bridge(struct device *dev, acpi_handle *handle)
+{
+	int num;
+	unsigned int seg, bus;
+
+	num = sscanf(dev->bus_id, "pci%04x:%02x", &seg, &bus);
+	if (num != 2)
+		return -ENODEV;
+	*handle = acpi_get_pci_rootbridge_handle(seg, bus);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
+}
+
+static struct acpi_bus_type pci_acpi_bus = {
+	.bus = &pci_bus_type,
+	.find_device = pci_acpi_bind_device,
+	.find_bridge = pci_acpi_bind_root_bridge,
+};
+
+static int __init pci_acpi_init(void)
+{
+	int ret;
+
+	ret = register_acpi_bus_type(&pci_acpi_bus);
+	if (ret)
+		return 0;
+	return 0;
+}
+arch_initcall(pci_acpi_init);
_

--=-sK70/UqPLp/43NSJvM/9--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
