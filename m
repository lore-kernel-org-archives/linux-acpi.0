From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4]An ACPI callback for pci_set_power_state
Date: Wed, 05 Jan 2005 10:51:27 +0800
Message-ID: <1104893456.5550.135.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HonJR+DY4pY3ZBYHtV7J"
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


--=-HonJR+DY4pY3ZBYHtV7J
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
This is an ACPI callback for pci_set_power_state. Besides setting PCI
config space, changing device's power state sometimes requires to power
on device's power source and to invoke other firmware methods.

Thanks,
Shaohua

SIgned-off-by: Li Shaohua<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

 2.5-root/drivers/acpi/bus.c     |    8 +++++++-
 2.5-root/drivers/pci/pci-acpi.c |   11 +++++++++++
 2.5-root/drivers/pci/pci.c      |   11 +++++++++--
 2.5-root/drivers/pci/pci.h      |    1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/bus.c~acpi-pci-set-power-state-callback drivers/acpi/bus.c
--- 2.5/drivers/acpi/bus.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.464923888 +0800
+++ 2.5-root/drivers/acpi/bus.c	2005-01-05 09:58:06.473922520 +0800
@@ -212,6 +212,12 @@ acpi_bus_set_power (
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Device is not power manageable\n"));
 		return_VALUE(-ENODEV);
 	}
+	/*
+	 * Get device's current power state if it's unknown
+	 * This means device power state isn't initialized or previous setting failed
+	 */
+	if (device->power.state == ACPI_STATE_UNKNOWN)
+		acpi_bus_get_power(device->handle, &device->power.state);
 	if (state == device->power.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n", state));
 		return_VALUE(0);
@@ -231,7 +237,7 @@ acpi_bus_set_power (
 	 * On transitions to a high-powered state we first apply power (via
 	 * power resources) then evalute _PSx.  Conversly for transitions to
 	 * a lower-powered state.
-	 */ 
+	 */
 	if (state < device->power.state) {
 		if (device->power.flags.power_resources) {
 			result = acpi_power_transition(device, state);
diff -puN drivers/pci/pci-acpi.c~acpi-pci-set-power-state-callback drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.466923584 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-05 09:58:06.472922672 +0800
@@ -226,6 +226,16 @@ static int acpi_get_suspend_state(struct
 	return -ENODEV;
 }
 
+static int acpi_set_power_state(struct pci_dev *dev, int state)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	if (!handle)
+		return -ENODEV;
+	return acpi_bus_set_power(handle, state);
+}
+
+
 /* ACPI bus type */
 int pci_acpi_bind_device(struct device *dev, acpi_handle *handle)
 {
@@ -269,6 +279,7 @@ static int __init pci_acpi_init(void)
 	if (ret)
 		return 0;
 	platform_pci_get_suspend_state = acpi_get_suspend_state;
+	platform_pci_set_power_state = acpi_set_power_state;
 	return 0;
 }
 arch_initcall(pci_acpi_init);
diff -puN drivers/pci/pci.c~acpi-pci-set-power-state-callback drivers/pci/pci.c
--- 2.5/drivers/pci/pci.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.467923432 +0800
+++ 2.5-root/drivers/pci/pci.c	2005-01-05 09:58:06.473922520 +0800
@@ -240,7 +240,7 @@ pci_find_parent_resource(const struct pc
  * -EIO if device does not support PCI PM.
  * 0 if we can successfully change the power state.
  */
-
+int (*platform_pci_set_power_state)(struct pci_dev *, int) = NULL;
 int
 pci_set_power_state(struct pci_dev *dev, int state)
 {
@@ -294,8 +294,15 @@ pci_set_power_state(struct pci_dev *dev,
 		msleep(10);
 	else if(state == 2 || dev->current_state == 2)
 		udelay(200);
-	dev->current_state = state;
 
+	/*
+	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
+	 * Firmware method after natice method ?
+	 */
+	if (platform_pci_set_power_state)
+		platform_pci_set_power_state(dev, state);
+
+	dev->current_state = state;
 	return 0;
 }
 
diff -puN drivers/pci/pci.h~acpi-pci-set-power-state-callback drivers/pci/pci.h
--- 2.5/drivers/pci/pci.h~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.469923128 +0800
+++ 2.5-root/drivers/pci/pci.h	2005-01-05 09:58:06.473922520 +0800
@@ -13,6 +13,7 @@ extern int pci_bus_alloc_resource(struct
 				  void *alignf_data);
 /* Firmware callbacks */
 extern int (*platform_pci_get_suspend_state)(struct device *dev, u32 state);
+extern int (*platform_pci_set_power_state)(struct pci_dev *dev, int state);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
_


--=-HonJR+DY4pY3ZBYHtV7J
Content-Disposition: attachment; filename=p00004_acpi-pci-set-power-state-callback.patch
Content-Type: text/x-patch; name=p00004_acpi-pci-set-power-state-callback.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


An ACPI callback for PCI set power state

---

 2.5-root/drivers/acpi/bus.c     |    8 +++++++-
 2.5-root/drivers/pci/pci-acpi.c |   11 +++++++++++
 2.5-root/drivers/pci/pci.c      |   11 +++++++++--
 2.5-root/drivers/pci/pci.h      |    1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/bus.c~acpi-pci-set-power-state-callback drivers/acpi/bus.c
--- 2.5/drivers/acpi/bus.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.464923888 +0800
+++ 2.5-root/drivers/acpi/bus.c	2005-01-05 09:58:06.473922520 +0800
@@ -212,6 +212,12 @@ acpi_bus_set_power (
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Device is not power manageable\n"));
 		return_VALUE(-ENODEV);
 	}
+	/*
+	 * Get device's current power state if it's unknown
+	 * This means device power state isn't initialized or previous setting failed
+	 */
+	if (device->power.state == ACPI_STATE_UNKNOWN)
+		acpi_bus_get_power(device->handle, &device->power.state);
 	if (state == device->power.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n", state));
 		return_VALUE(0);
@@ -231,7 +237,7 @@ acpi_bus_set_power (
 	 * On transitions to a high-powered state we first apply power (via
 	 * power resources) then evalute _PSx.  Conversly for transitions to
 	 * a lower-powered state.
-	 */ 
+	 */
 	if (state < device->power.state) {
 		if (device->power.flags.power_resources) {
 			result = acpi_power_transition(device, state);
diff -puN drivers/pci/pci-acpi.c~acpi-pci-set-power-state-callback drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.466923584 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-05 09:58:06.472922672 +0800
@@ -226,6 +226,16 @@ static int acpi_get_suspend_state(struct
 	return -ENODEV;
 }
 
+static int acpi_set_power_state(struct pci_dev *dev, int state)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	if (!handle)
+		return -ENODEV;
+	return acpi_bus_set_power(handle, state);
+}
+
+
 /* ACPI bus type */
 int pci_acpi_bind_device(struct device *dev, acpi_handle *handle)
 {
@@ -269,6 +279,7 @@ static int __init pci_acpi_init(void)
 	if (ret)
 		return 0;
 	platform_pci_get_suspend_state = acpi_get_suspend_state;
+	platform_pci_set_power_state = acpi_set_power_state;
 	return 0;
 }
 arch_initcall(pci_acpi_init);
diff -puN drivers/pci/pci.c~acpi-pci-set-power-state-callback drivers/pci/pci.c
--- 2.5/drivers/pci/pci.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.467923432 +0800
+++ 2.5-root/drivers/pci/pci.c	2005-01-05 09:58:06.473922520 +0800
@@ -240,7 +240,7 @@ pci_find_parent_resource(const struct pc
  * -EIO if device does not support PCI PM.
  * 0 if we can successfully change the power state.
  */
-
+int (*platform_pci_set_power_state)(struct pci_dev *, int) = NULL;
 int
 pci_set_power_state(struct pci_dev *dev, int state)
 {
@@ -294,8 +294,15 @@ pci_set_power_state(struct pci_dev *dev,
 		msleep(10);
 	else if(state == 2 || dev->current_state == 2)
 		udelay(200);
-	dev->current_state = state;
 
+	/*
+	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
+	 * Firmware method after natice method ?
+	 */
+	if (platform_pci_set_power_state)
+		platform_pci_set_power_state(dev, state);
+
+	dev->current_state = state;
 	return 0;
 }
 
diff -puN drivers/pci/pci.h~acpi-pci-set-power-state-callback drivers/pci/pci.h
--- 2.5/drivers/pci/pci.h~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.469923128 +0800
+++ 2.5-root/drivers/pci/pci.h	2005-01-05 09:58:06.473922520 +0800
@@ -13,6 +13,7 @@ extern int pci_bus_alloc_resource(struct
 				  void *alignf_data);
 /* Firmware callbacks */
 extern int (*platform_pci_get_suspend_state)(struct device *dev, u32 state);
+extern int (*platform_pci_set_power_state)(struct pci_dev *dev, int state);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
_

--=-HonJR+DY4pY3ZBYHtV7J--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
