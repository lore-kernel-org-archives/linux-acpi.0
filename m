From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / ia64 / sba_iommu: Restore the working initialization ordering
Date: Thu, 12 Jun 2014 01:34:06 +0200
Message-ID: <1484331.OIWg7ItM60@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64085 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752092AbaFKXQl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2014 19:16:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, =?ISO-8859-1?Q?=C9meric?= Maschino <emeric.maschino@gmail.com>

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 66345d5f79fc (ACPI / ia64 / sba_iommu: Use ACPI scan handler
for device discovery) changed the ordering of SBA (System Bus Adapter)
IOMMU initialization with respect to the PCI host bridge initialization
which broke things inadvertently, because the SBA IOMMU initialization
code has to run after the PCI host bridge has been initialized.

=46ix that by reworking the SBA IOMMU ACPI scan handler so that it
claims the discovered matching ACPI device objects without attempting
to initialize anything and move the entire SBA IOMMU initialization
to sba_init() that runs after the PCI bus has been enumerated.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D76691
=46ixes: 66345d5f79fc (ACPI / ia64 / sba_iommu: Use ACPI scan handler f=
or device discovery)
Reported-and-tested-by: =C3=89meric Maschino <emeric.maschino@gmail.com=
>
Cc: 3.11+ <stable@vger.kernel.org> # 3.11+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/ia64/hp/common/sba_iommu.c |   64 +++++++++++++++++++++++--------=
---------
 1 file changed, 37 insertions(+), 27 deletions(-)

Index: linux-pm/arch/ia64/hp/common/sba_iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/arch/ia64/hp/common/sba_iommu.c
+++ linux-pm/arch/ia64/hp/common/sba_iommu.c
@@ -242,7 +242,7 @@ struct ioc {
 	struct pci_dev	*sac_only_dev;
 };
=20
-static struct ioc *ioc_list;
+static struct ioc *ioc_list, *ioc_found;
 static int reserve_sba_gart =3D 1;
=20
 static SBA_INLINE void sba_mark_invalid(struct ioc *, dma_addr_t, size=
_t);
@@ -1809,20 +1809,13 @@ static struct ioc_iommu ioc_iommu_info[]
 	{ SX2000_IOC_ID, "sx2000", NULL },
 };
=20
-static struct ioc *
-ioc_init(unsigned long hpa, void *handle)
+static void ioc_init(unsigned long hpa, struct ioc *ioc)
 {
-	struct ioc *ioc;
 	struct ioc_iommu *info;
=20
-	ioc =3D kzalloc(sizeof(*ioc), GFP_KERNEL);
-	if (!ioc)
-		return NULL;
-
 	ioc->next =3D ioc_list;
 	ioc_list =3D ioc;
=20
-	ioc->handle =3D handle;
 	ioc->ioc_hpa =3D ioremap(hpa, 0x1000);
=20
 	ioc->func_id =3D READ_REG(ioc->ioc_hpa + IOC_FUNC_ID);
@@ -1863,8 +1856,6 @@ ioc_init(unsigned long hpa, void *handle
 		"%s %d.%d HPA 0x%lx IOVA space %dMb at 0x%lx\n",
 		ioc->name, (ioc->rev >> 4) & 0xF, ioc->rev & 0xF,
 		hpa, ioc->iov_size >> 20, ioc->ibase);
-
-	return ioc;
 }
=20
=20
@@ -2031,22 +2022,21 @@ sba_map_ioc_to_node(struct ioc *ioc, acp
 #endif
 }
=20
-static int
-acpi_sba_ioc_add(struct acpi_device *device,
-		 const struct acpi_device_id *not_used)
+static void acpi_sba_ioc_add(struct ioc *ioc)
 {
-	struct ioc *ioc;
+	acpi_handle handle =3D ioc->handle;
 	acpi_status status;
 	u64 hpa, length;
 	struct acpi_device_info *adi;
=20
-	status =3D hp_acpi_csr_space(device->handle, &hpa, &length);
+	ioc_found =3D ioc->next;
+	status =3D hp_acpi_csr_space(handle, &hpa, &length);
 	if (ACPI_FAILURE(status))
-		return 1;
+		goto err;
=20
-	status =3D acpi_get_object_info(device->handle, &adi);
+	status =3D acpi_get_object_info(handle, &adi);
 	if (ACPI_FAILURE(status))
-		return 1;
+		goto err;
=20
 	/*
 	 * For HWP0001, only SBA appears in ACPI namespace.  It encloses the =
PCI
@@ -2067,13 +2057,13 @@ acpi_sba_ioc_add(struct acpi_device *dev
 	if (!iovp_shift)
 		iovp_shift =3D 12;
=20
-	ioc =3D ioc_init(hpa, device->handle);
-	if (!ioc)
-		return 1;
-
+	ioc_init(hpa, ioc);
 	/* setup NUMA node association */
-	sba_map_ioc_to_node(ioc, device->handle);
-	return 0;
+	sba_map_ioc_to_node(ioc, handle);
+	return;
+
+ err:
+	kfree(ioc);
 }
=20
 static const struct acpi_device_id hp_ioc_iommu_device_ids[] =3D {
@@ -2081,9 +2071,26 @@ static const struct acpi_device_id hp_io
 	{"HWP0004", 0},
 	{"", 0},
 };
+
+static int acpi_sba_ioc_attach(struct acpi_device *device,
+			       const struct acpi_device_id *not_used)
+{
+	struct ioc *ioc;
+
+	ioc =3D kzalloc(sizeof(*ioc), GFP_KERNEL);
+	if (!ioc)
+		return -ENOMEM;
+
+	ioc->next =3D ioc_found;
+	ioc_found =3D ioc;
+	ioc->handle =3D device->handle;
+	return 1;
+}
+
+
 static struct acpi_scan_handler acpi_sba_ioc_handler =3D {
 	.ids	=3D hp_ioc_iommu_device_ids,
-	.attach	=3D acpi_sba_ioc_add,
+	.attach	=3D acpi_sba_ioc_attach,
 };
=20
 static int __init acpi_sba_ioc_init_acpi(void)
@@ -2118,9 +2125,12 @@ sba_init(void)
 #endif
=20
 	/*
-	 * ioc_list should be populated by the acpi_sba_ioc_handler's .attach=
()
+	 * ioc_found should be populated by the acpi_sba_ioc_handler's .attac=
h()
 	 * routine, but that only happens if acpi_scan_init() has already run=
=2E
 	 */
+	while (ioc_found)
+		acpi_sba_ioc_add(ioc_found);
+
 	if (!ioc_list) {
 #ifdef CONFIG_IA64_GENERIC
 		/*

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
