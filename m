From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / driver core: Store a device pointer in struct acpi_dev_node
Date: Mon, 11 Nov 2013 14:45:39 +0100
Message-ID: <1683079.zjqzsOAjXB@vostro.rjw.lan>
References: <3268437.YsusHvklcv@vostro.rjw.lan> <52803124.7000304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <52803124.7000304@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Luck, Tony" <tony.luck@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, November 11, 2013 09:21:40 AM Lan Tianyu wrote:
> On 2013=E5=B9=B411=E6=9C=8810=E6=97=A5 08:58, Rafael J. Wysocki wrote=
:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
> > Modify struct acpi_dev_node to contain a pointer to struct device
> > ambedded in the struct acpi_device associated with the given device
> > object (that is, its ACPI companion device) instead of an ACPI hand=
le
> > corresponding to that struct acpi_device.  Introduce two new macros
> > for manipulating that pointer in a CONFIG_ACPI-safe way,
> > ACPI_COMPANION() and ACPI_COMPANION_SET(), and rework the
> > ACPI_HANDLE() macro to take the above changes into account.
> > Drop the ACPI_HANDLE_SET() macro entirely and rework its users to
> > use ACPI_COMPANION_SET() instead.  For some of them who used to
> > pass the result of acpi_get_child() directly to ACPI_HANDLE_SET()
> > introduce a helper routine acpi_preset_companion() doing an
> > equivalent thing.
> >=20
> > The rationale for using a struct device pointer instead of a
> > struct acpi_device one as the member of struct acpi_dev_node is
> > that it allows device.h to avoid including linux/acpi.h which would
> > introduce quite a bit of compilation overhead for stuff that doesn'=
t
> > care about ACPI.
> > In turn, moving the macros to linux/acpi.h forces
> > the stuff that does care about ACPI to include that file as
> > appropriate anyway.
>=20
> How about declaring "struct acpi_device" in the device.h? This can he=
lp
> to use struct acpi_device without including linux/acpi.h.
>=20
> struct iommu_ops and struct iommu_group have been used by the same wa=
y
> in the device.h.

Yes, they are.  Well, that appears to work too.

Updated patch is appended.  It also contains some fixes for problems re=
ported
by the auto build system and it's been tested on x86-64 now, so it shou=
ld be
reasonably close to final.

Thanks,
Rafael


---
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / driver core: Store an ACPI device pointer in struct acp=
i_dev_node

Modify struct acpi_dev_node to contain a pointer to struct acpi_device
associated with the given device object (that is, its ACPI companion
device) instead of an ACPI handle corresponding to it.  Introduce two
new macros for manipulating that pointer in a CONFIG_ACPI-safe way,
ACPI_COMPANION() and ACPI_COMPANION_SET(), and rework the
ACPI_HANDLE() macro to take the above changes into account.
Drop the ACPI_HANDLE_SET() macro entirely and rework its users to
use ACPI_COMPANION_SET() instead.  For some of them who used to
pass the result of acpi_get_child() directly to ACPI_HANDLE_SET()
introduce a helper routine acpi_preset_companion() doing an
equivalent thing.

The main motivation for doing this is that there are things
represented by struct acpi_device objects that don't have valid
ACPI handles (so called fixed ACPI hardware features, such as
power and sleep buttons) and we would like to create platform
device objects for them and "glue" them to their ACPI companions
in the usual way (which currently is impossible due to the
lack of valid ACPI handles).  However, there are more reasons
why it may be useful.

=46irst, struct acpi_device pointers allow of much better type checking
than void pointers which are ACPI handles, so it should be more
difficult to write buggy code using modified struct acpi_dev_node
and the new macros.  Second, the change should help to reduce (over
time) the number of places in which the result of ACPI_HANDLE() is
passed to acpi_bus_get_device() in order to obtain a pointer to the
struct acpi_device associated with the given "physical" device,
because now that pointer is returned by ACPI_COMPANION() directly.
=46inally, the change should make it easier to write generic code that
will build both for CONFIG_ACPI set and unset without adding explicit
compiler directives to it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/ia64/hp/common/sba_iommu.c              |    2 -
 arch/ia64/include/asm/pci.h                  |    2 -
 arch/ia64/pci/pci.c                          |    6 +--
 arch/ia64/sn/kernel/io_acpi_init.c           |    4 +-
 arch/x86/include/asm/pci.h                   |    2 -
 arch/x86/pci/acpi.c                          |    4 +-
 drivers/acpi/acpi_platform.c                 |    2 -
 drivers/acpi/device_pm.c                     |    6 ---
 drivers/acpi/glue.c                          |   47 +++++++++++++-----=
---------
 drivers/ata/libata-acpi.c                    |    4 +-
 drivers/base/platform.c                      |    4 +-
 drivers/gpu/drm/radeon/radeon_atpx_handler.c |    3 -
 drivers/hid/i2c-hid/i2c-hid.c                |    2 -
 drivers/i2c/i2c-core.c                       |    4 +-
 drivers/ide/ide-acpi.c                       |    3 -
 drivers/mmc/core/sdio_bus.c                  |    3 -
 drivers/pci/hotplug/sgi_hotplug.c            |    4 +-
 drivers/spi/spi.c                            |    2 -
 include/acpi/acpi_bus.h                      |    2 -
 include/linux/acpi.h                         |   15 ++++++++
 include/linux/device.h                       |   12 +-----
 21 files changed, 67 insertions(+), 66 deletions(-)

Index: linux-pm/include/linux/device.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -623,9 +623,11 @@ struct device_dma_parameters {
 	unsigned long segment_boundary_mask;
 };
=20
+struct acpi_device;
+
 struct acpi_dev_node {
 #ifdef CONFIG_ACPI
-	void	*handle;
+	struct acpi_device *companion;
 #endif
 };
=20
@@ -769,14 +771,6 @@ static inline struct device *kobj_to_dev
 	return container_of(kobj, struct device, kobj);
 }
=20
-#ifdef CONFIG_ACPI
-#define ACPI_HANDLE(dev)	((dev)->acpi_node.handle)
-#define ACPI_HANDLE_SET(dev, _handle_)	(dev)->acpi_node.handle =3D (_h=
andle_)
-#else
-#define ACPI_HANDLE(dev)	(NULL)
-#define ACPI_HANDLE_SET(dev, _handle_)	do { } while (0)
-#endif
-
 /* Get the wakeup routines, which depend on struct device */
 #include <linux/pm_wakeup.h>
=20
Index: linux-pm/include/acpi/acpi_bus.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -431,9 +431,9 @@ static inline acpi_handle acpi_get_child
 {
 	return acpi_find_child(handle, addr, false);
 }
+void acpi_preset_companion(struct device *dev, acpi_handle parent, u64=
 addr);
 int acpi_is_root_bridge(acpi_handle);
 struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle);
-#define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)ACPI_HANDLE(dev))
=20
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int state=
);
 int acpi_disable_wakeup_device_power(struct acpi_device *dev);
Index: linux-pm/include/linux/acpi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -44,6 +44,15 @@
 #include <acpi/acpi_numa.h>
 #include <asm/acpi.h>
=20
+static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
+{
+	return adev ? adev->handle : NULL;
+}
+
+#define ACPI_COMPANION(dev)		((dev)->acpi_node.companion)
+#define ACPI_COMPANION_SET(dev, adev)	ACPI_COMPANION(dev) =3D (adev)
+#define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
+
 enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC =3D 0,
 	ACPI_IRQ_MODEL_IOAPIC,
@@ -407,6 +416,10 @@ static inline bool acpi_driver_match_dev
=20
 #define acpi_disabled 1
=20
+#define ACPI_COMPANION(dev)		(NULL)
+#define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
+#define ACPI_HANDLE(dev)		(NULL)
+
 static inline void acpi_early_init(void) { }
=20
 static inline int early_acpi_boot_init(void)
@@ -475,6 +488,8 @@ static inline bool acpi_driver_match_dev
=20
 #endif	/* !CONFIG_ACPI */
=20
+#define DEVICE_ACPI_HANDLE(dev)	ACPI_HANDLE(dev)
+
 #ifdef CONFIG_ACPI
 void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
 			       u32 pm1a_ctrl,  u32 pm1b_ctrl));
Index: linux-pm/arch/ia64/include/asm/pci.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/arch/ia64/include/asm/pci.h
+++ linux-pm/arch/ia64/include/asm/pci.h
@@ -95,7 +95,7 @@ struct iospace_resource {
 };
=20
 struct pci_controller {
-	void *acpi_handle;
+	struct acpi_device *companion;
 	void *iommu;
 	int segment;
 	int node;		/* nearest node with memory or -1 for global allocation */
Index: linux-pm/arch/ia64/pci/pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/arch/ia64/pci/pci.c
+++ linux-pm/arch/ia64/pci/pci.c
@@ -436,9 +436,9 @@ struct pci_bus *pci_acpi_scan_root(struc
 	if (!controller)
 		return NULL;
=20
-	controller->acpi_handle =3D device->handle;
+	controller->companion =3D device;
=20
-	pxm =3D acpi_get_pxm(controller->acpi_handle);
+	pxm =3D acpi_get_pxm(device->handle);
 #ifdef CONFIG_NUMA
 	if (pxm >=3D 0)
 		controller->node =3D pxm_to_node(pxm);
@@ -489,7 +489,7 @@ int pcibios_root_bridge_prepare(struct p
 {
 	struct pci_controller *controller =3D bridge->bus->sysdata;
=20
-	ACPI_HANDLE_SET(&bridge->dev, controller->acpi_handle);
+	ACPI_COMPANION_SET(&bridge->dev, controller->companion);
 	return 0;
 }
=20
Index: linux-pm/arch/ia64/hp/common/sba_iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/arch/ia64/hp/common/sba_iommu.c
+++ linux-pm/arch/ia64/hp/common/sba_iommu.c
@@ -1992,7 +1992,7 @@ sba_connect_bus(struct pci_bus *bus)
 	if (PCI_CONTROLLER(bus)->iommu)
 		return;
=20
-	handle =3D PCI_CONTROLLER(bus)->acpi_handle;
+	handle =3D acpi_device_handle(PCI_CONTROLLER(bus)->companion);
 	if (!handle)
 		return;
=20
Index: linux-pm/arch/ia64/sn/kernel/io_acpi_init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/arch/ia64/sn/kernel/io_acpi_init.c
+++ linux-pm/arch/ia64/sn/kernel/io_acpi_init.c
@@ -132,7 +132,7 @@ sn_get_bussoft_ptr(struct pci_bus *bus)
 	struct acpi_resource_vendor_typed *vendor;
=20
=20
-	handle =3D PCI_CONTROLLER(bus)->acpi_handle;
+	handle =3D acpi_device_handle(PCI_CONTROLLER(bus)->companion);
 	status =3D acpi_get_vendor_resource(handle, METHOD_NAME__CRS,
 					  &sn_uuid, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -360,7 +360,7 @@ sn_acpi_get_pcidev_info(struct pci_dev *
 	acpi_status status;
 	struct acpi_buffer name_buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
=20
-	rootbus_handle =3D PCI_CONTROLLER(dev)->acpi_handle;
+	rootbus_handle =3D acpi_device_handle(PCI_CONTROLLER(dev)->companion)=
;
         status =3D acpi_evaluate_integer(rootbus_handle, METHOD_NAME__=
SEG, NULL,
                                        &segment);
         if (ACPI_SUCCESS(status)) {
Index: linux-pm/arch/x86/include/asm/pci.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/arch/x86/include/asm/pci.h
+++ linux-pm/arch/x86/include/asm/pci.h
@@ -15,7 +15,7 @@ struct pci_sysdata {
 	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
 #ifdef CONFIG_ACPI
-	void		*acpi;		/* ACPI-specific data */
+	struct acpi_device *companion;	/* ACPI companion device */
 #endif
 #ifdef CONFIG_X86_64
 	void		*iommu;		/* IOMMU private data */
Index: linux-pm/arch/x86/pci/acpi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/arch/x86/pci/acpi.c
+++ linux-pm/arch/x86/pci/acpi.c
@@ -518,7 +518,7 @@ struct pci_bus *pci_acpi_scan_root(struc
 	sd =3D &info->sd;
 	sd->domain =3D domain;
 	sd->node =3D node;
-	sd->acpi =3D device->handle;
+	sd->companion =3D device;
 	/*
 	 * Maybe the desired pci bus has been already scanned. In such case
 	 * it is unnecessary to scan the pci bus with the given domain,busnum=
=2E
@@ -589,7 +589,7 @@ int pcibios_root_bridge_prepare(struct p
 {
 	struct pci_sysdata *sd =3D bridge->bus->sysdata;
=20
-	ACPI_HANDLE_SET(&bridge->dev, sd->acpi);
+	ACPI_COMPANION_SET(&bridge->dev, sd->companion);
 	return 0;
 }
=20
Index: linux-pm/drivers/acpi/glue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -197,30 +197,27 @@ static void acpi_physnode_link_name(char
=20
 int acpi_bind_one(struct device *dev, acpi_handle handle)
 {
-	struct acpi_device *acpi_dev;
-	acpi_status status;
+	struct acpi_device *acpi_dev =3D NULL;
 	struct acpi_device_physical_node *physical_node, *pn;
 	char physical_node_name[PHYSICAL_NODE_NAME_SIZE];
 	struct list_head *physnode_list;
 	unsigned int node_id;
 	int retval =3D -EINVAL;
=20
-	if (ACPI_HANDLE(dev)) {
+	if (ACPI_COMPANION(dev)) {
 		if (handle) {
-			dev_warn(dev, "ACPI handle is already set\n");
+			dev_warn(dev, "ACPI companion already set\n");
 			return -EINVAL;
 		} else {
-			handle =3D ACPI_HANDLE(dev);
+			acpi_dev =3D ACPI_COMPANION(dev);
 		}
+	} else {
+		acpi_bus_get_device(handle, &acpi_dev);
 	}
-	if (!handle)
+	if (!acpi_dev)
 		return -EINVAL;
=20
 	get_device(dev);
-	status =3D acpi_bus_get_device(handle, &acpi_dev);
-	if (ACPI_FAILURE(status))
-		goto err;
-
 	physical_node =3D kzalloc(sizeof(*physical_node), GFP_KERNEL);
 	if (!physical_node) {
 		retval =3D -ENOMEM;
@@ -242,7 +239,7 @@ int acpi_bind_one(struct device *dev, ac
=20
 			dev_warn(dev, "Already associated with ACPI node\n");
 			kfree(physical_node);
-			if (ACPI_HANDLE(dev) !=3D handle)
+			if (ACPI_COMPANION(dev) !=3D acpi_dev)
 				goto err;
=20
 			put_device(dev);
@@ -259,8 +256,8 @@ int acpi_bind_one(struct device *dev, ac
 	list_add(&physical_node->node, physnode_list);
 	acpi_dev->physical_node_count++;
=20
-	if (!ACPI_HANDLE(dev))
-		ACPI_HANDLE_SET(dev, acpi_dev->handle);
+	if (!ACPI_COMPANION(dev))
+		ACPI_COMPANION_SET(dev, acpi_dev);
=20
 	acpi_physnode_link_name(physical_node_name, node_id);
 	retval =3D sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
@@ -283,7 +280,7 @@ int acpi_bind_one(struct device *dev, ac
 	return 0;
=20
  err:
-	ACPI_HANDLE_SET(dev, NULL);
+	ACPI_COMPANION_SET(dev, NULL);
 	put_device(dev);
 	return retval;
 }
@@ -291,19 +288,12 @@ EXPORT_SYMBOL_GPL(acpi_bind_one);
=20
 int acpi_unbind_one(struct device *dev)
 {
+	struct acpi_device *acpi_dev =3D ACPI_COMPANION(dev);
 	struct acpi_device_physical_node *entry;
-	struct acpi_device *acpi_dev;
-	acpi_status status;
=20
-	if (!ACPI_HANDLE(dev))
+	if (!acpi_dev)
 		return 0;
=20
-	status =3D acpi_bus_get_device(ACPI_HANDLE(dev), &acpi_dev);
-	if (ACPI_FAILURE(status)) {
-		dev_err(dev, "Oops, ACPI handle corrupt in %s()\n", __func__);
-		return -EINVAL;
-	}
-
 	mutex_lock(&acpi_dev->physical_node_lock);
=20
 	list_for_each_entry(entry, &acpi_dev->physical_node_list, node)
@@ -316,7 +306,7 @@ int acpi_unbind_one(struct device *dev)
 			acpi_physnode_link_name(physnode_name, entry->node_id);
 			sysfs_remove_link(&acpi_dev->dev.kobj, physnode_name);
 			sysfs_remove_link(&dev->kobj, "firmware_node");
-			ACPI_HANDLE_SET(dev, NULL);
+			ACPI_COMPANION_SET(dev, NULL);
 			/* acpi_bind_one() increase refcnt by one. */
 			put_device(dev);
 			kfree(entry);
@@ -328,6 +318,15 @@ int acpi_unbind_one(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(acpi_unbind_one);
=20
+void acpi_preset_companion(struct device *dev, acpi_handle parent, u64=
 addr)
+{
+	struct acpi_device *adev;
+
+	if (!acpi_bus_get_device(acpi_get_child(parent, addr), &adev))
+		ACPI_COMPANION_SET(dev, adev);
+}
+EXPORT_SYMBOL_GPL(acpi_preset_companion);
+
 static int acpi_platform_notify(struct device *dev)
 {
 	struct acpi_bus_type *type =3D acpi_get_bus_type(dev);
Index: linux-pm/drivers/ata/libata-acpi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/ata/libata-acpi.c
+++ linux-pm/drivers/ata/libata-acpi.c
@@ -185,7 +185,7 @@ void ata_acpi_bind_port(struct ata_port
 	if (libata_noacpi || ap->flags & ATA_FLAG_ACPI_SATA || !host_handle)
 		return;
=20
-	ACPI_HANDLE_SET(&ap->tdev, acpi_get_child(host_handle, ap->port_no));
+	acpi_preset_companion(&ap->tdev, host_handle, ap->port_no);
=20
 	if (ata_acpi_gtm(ap, &ap->__acpi_init_gtm) =3D=3D 0)
 		ap->pflags |=3D ATA_PFLAG_INIT_GTM_VALID;
@@ -222,7 +222,7 @@ void ata_acpi_bind_dev(struct ata_device
 		parent_handle =3D port_handle;
 	}
=20
-	ACPI_HANDLE_SET(&dev->tdev, acpi_get_child(parent_handle, adr));
+	acpi_preset_companion(&dev->tdev, parent_handle, adr);
=20
 	register_hotplug_dock_device(ata_dev_acpi_handle(dev),
 				     &ata_acpi_dev_dock_ops, dev, NULL, NULL);
Index: linux-pm/drivers/base/platform.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/base/platform.c
+++ linux-pm/drivers/base/platform.c
@@ -432,7 +432,7 @@ struct platform_device *platform_device_
 		goto err_alloc;
=20
 	pdev->dev.parent =3D pdevinfo->parent;
-	ACPI_HANDLE_SET(&pdev->dev, pdevinfo->acpi_node.handle);
+	ACPI_COMPANION_SET(&pdev->dev, pdevinfo->acpi_node.companion);
=20
 	if (pdevinfo->dma_mask) {
 		/*
@@ -463,7 +463,7 @@ struct platform_device *platform_device_
 	ret =3D platform_device_add(pdev);
 	if (ret) {
 err:
-		ACPI_HANDLE_SET(&pdev->dev, NULL);
+		ACPI_COMPANION_SET(&pdev->dev, NULL);
 		kfree(pdev->dev.dma_mask);
=20
 err_alloc:
Index: linux-pm/drivers/acpi/acpi_platform.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/acpi/acpi_platform.c
+++ linux-pm/drivers/acpi/acpi_platform.c
@@ -111,7 +111,7 @@ int acpi_create_platform_device(struct a
 	pdevinfo.id =3D -1;
 	pdevinfo.res =3D resources;
 	pdevinfo.num_res =3D count;
-	pdevinfo.acpi_node.handle =3D adev->handle;
+	pdevinfo.acpi_node.companion =3D adev;
 	pdev =3D platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev)) {
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
Index: linux-pm/drivers/hid/i2c-hid/i2c-hid.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/hid/i2c-hid/i2c-hid.c
+++ linux-pm/drivers/hid/i2c-hid/i2c-hid.c
@@ -1012,7 +1012,7 @@ static int i2c_hid_probe(struct i2c_clie
 	hid->hid_get_raw_report =3D i2c_hid_get_raw_report;
 	hid->hid_output_raw_report =3D i2c_hid_output_raw_report;
 	hid->dev.parent =3D &client->dev;
-	ACPI_HANDLE_SET(&hid->dev, ACPI_HANDLE(&client->dev));
+	ACPI_COMPANION_SET(&hid->dev, ACPI_COMPANION(&client->dev));
 	hid->bus =3D BUS_I2C;
 	hid->version =3D le16_to_cpu(ihid->hdesc.bcdVersion);
 	hid->vendor =3D le16_to_cpu(ihid->hdesc.wVendorID);
Index: linux-pm/drivers/i2c/i2c-core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/i2c/i2c-core.c
+++ linux-pm/drivers/i2c/i2c-core.c
@@ -674,7 +674,7 @@ i2c_new_device(struct i2c_adapter *adap,
 	client->dev.bus =3D &i2c_bus_type;
 	client->dev.type =3D &i2c_client_type;
 	client->dev.of_node =3D info->of_node;
-	ACPI_HANDLE_SET(&client->dev, info->acpi_node.handle);
+	ACPI_COMPANION_SET(&client->dev, info->acpi_node.companion);
=20
 	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
 	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
@@ -1103,7 +1103,7 @@ static acpi_status acpi_i2c_add_device(a
 		return AE_OK;
=20
 	memset(&info, 0, sizeof(info));
-	info.acpi_node.handle =3D handle;
+	info.acpi_node.companion =3D adev;
 	info.irq =3D -1;
=20
 	INIT_LIST_HEAD(&resource_list);
Index: linux-pm/drivers/mmc/core/sdio_bus.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/mmc/core/sdio_bus.c
+++ linux-pm/drivers/mmc/core/sdio_bus.c
@@ -305,8 +305,7 @@ static void sdio_acpi_set_handle(struct
 	struct mmc_host *host =3D func->card->host;
 	u64 addr =3D (host->slotno << 16) | func->num;
=20
-	ACPI_HANDLE_SET(&func->dev,
-			acpi_get_child(ACPI_HANDLE(host->parent), addr));
+	acpi_preset_companion(&func->dev, ACPI_HANDLE(host->parent), addr);
 }
 #else
 static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
Index: linux-pm/drivers/spi/spi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/spi/spi.c
+++ linux-pm/drivers/spi/spi.c
@@ -1024,7 +1024,7 @@ static acpi_status acpi_spi_add_device(a
 		return AE_NO_MEMORY;
 	}
=20
-	ACPI_HANDLE_SET(&spi->dev, handle);
+	ACPI_COMPANION_SET(&spi->dev, adev);
 	spi->irq =3D -1;
=20
 	INIT_LIST_HEAD(&resource_list);
Index: linux-pm/drivers/acpi/device_pm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -22,16 +22,12 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
  */
=20
-#include <linux/device.h>
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
=20
-#include <acpi/acpi.h>
-#include <acpi/acpi_bus.h>
-#include <acpi/acpi_drivers.h>
-
 #include "internal.h"
=20
 #define _COMPONENT	ACPI_POWER_COMPONENT
Index: linux-pm/drivers/ide/ide-acpi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/ide/ide-acpi.c
+++ linux-pm/drivers/ide/ide-acpi.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2006 Hannes Reinecke
  */
=20
+#include <linux/acpi.h>
 #include <linux/ata.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -19,8 +20,6 @@
 #include <linux/dmi.h>
 #include <linux/module.h>
=20
-#include <acpi/acpi_bus.h>
-
 #define REGS_PER_GTF		7
=20
 struct GTM_buffer {
Index: linux-pm/drivers/pci/hotplug/sgi_hotplug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/pci/hotplug/sgi_hotplug.c
+++ linux-pm/drivers/pci/hotplug/sgi_hotplug.c
@@ -9,6 +9,7 @@
  * Work to add BIOS PROM support was completed by Mike Habeck.
  */
=20
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -29,7 +30,6 @@
 #include <asm/sn/sn_feature_sets.h>
 #include <asm/sn/sn_sal.h>
 #include <asm/sn/types.h>
-#include <linux/acpi.h>
 #include <asm/sn/acpi.h>
=20
 #include "../pci.h"
@@ -414,7 +414,7 @@ static int enable_slot(struct hotplug_sl
 		acpi_handle rethandle;
 		acpi_status ret;
=20
-		phandle =3D PCI_CONTROLLER(slot->pci_bus)->acpi_handle;
+		phandle =3D acpi_device_handle(PCI_CONTROLLER(slot->pci_bus)->compan=
ion);
=20
 		if (acpi_bus_get_device(phandle, &pdevice)) {
 			dev_dbg(&slot->pci_bus->self->dev,
Index: linux-pm/drivers/gpu/drm/radeon/radeon_atpx_handler.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ linux-pm/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -8,8 +8,7 @@
  */
 #include <linux/vga_switcheroo.h>
 #include <linux/slab.h>
-#include <acpi/acpi.h>
-#include <acpi/acpi_bus.h>
+#include <linux/acpi.h>
 #include <linux/pci.h>
=20
 #include "radeon_acpi.h"
