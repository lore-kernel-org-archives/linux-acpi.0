From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/6]ACPI based Physical CPU hotplug
Date: Wed, 8 Sep 2004 18:24:15 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040908182415.C7287@unix-os.sc.intel.com>
References: <44BDAFB888F59F408FAE3CC35AB47041B17999@orsmsx409>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <44BDAFB888F59F408FAE3CC35AB47041B17999@orsmsx409>; from anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Wed, Sep 08, 2004 at 06:10:50PM -0700
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: LHNS list <lhns-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI Developer <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This is the core eject support interface required to support user mode
agent initiated hot-removal.

---
Name:acpi_core_eject.patch
Status: Tested on 2.6.9-rc2-mm2
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Depends:acpi_core
Version: applies on 2.6.9-rc1-mm2

This patch support /sys/firmware/acpi/eject interface where in 
the ACPI device say "LSB0" can be ejected by echoing "\_SB.LSB0" > 
/sys/firmware/acpi/eject

The kernel when it receives an hardware sci eject request it simply passes this
to user mode agent and the agent in turn will offline all the child devices and
then echo's the ACPI device name onto /sys/firware/acpi/eject file and then the
kernel will then actually remove the device.

---

 linux-2.6.9-rc1-mm2-askeshav/drivers/acpi/scan.c |  141 +++++++++++++++++++++++
 1 files changed, 141 insertions(+)

diff -puN drivers/acpi/scan.c~acpi_core_eject drivers/acpi/scan.c
--- linux-2.6.9-rc1-mm2/drivers/acpi/scan.c~acpi_core_eject	2004-09-08 16:42:16.763594503 -0700
+++ linux-2.6.9-rc1-mm2-askeshav/drivers/acpi/scan.c	2004-09-08 16:42:16.848555439 -0700
@@ -2,6 +2,7 @@
  * scan.c - support for transforming the ACPI namespace into individual objects
  */
 
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
 
@@ -293,6 +294,141 @@ end:
 }
 
 /* --------------------------------------------------------------------------
+                              ACPI hotplug Eject support
+   -------------------------------------------------------------------------- */
+static ssize_t acpi_eject_store(struct subsystem *subsys, const char *buf, size_t count);
+static struct subsys_attribute acpi_eject_attr =
+	__ATTR(eject,0200,NULL,acpi_eject_store);
+
+/*
+ * evaluate _EJ0, detach driver, and remove from ACPI bus
+ */
+static int
+eject_operation(acpi_handle handle, int lockable)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	acpi_status status = AE_OK;
+
+	/*
+	 * TBD: evaluate _PS3?
+	 */
+
+	if (lockable) {
+		arg_list.count = 1;
+		arg_list.pointer = &arg;
+		arg.type = ACPI_TYPE_INTEGER;
+		arg.integer.value = 0;
+		acpi_evaluate_object(handle, "_LCK", &arg_list, NULL);
+	}
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+
+	/*
+	 * TBD: _EJD support.
+	 */
+
+	status = acpi_evaluate_object(handle, "_EJ0", &arg_list, NULL);
+	if (ACPI_FAILURE(status)) {
+		return(-ENODEV);
+	}
+
+	return(0);
+}
+
+static ssize_t
+acpi_eject_store(struct subsystem *subsys, const char *buf, size_t count)
+{
+	acpi_status status;
+	acpi_handle hlsb;
+	struct acpi_device *device = NULL;
+	int result;
+	int ret = count;
+
+	char *acpi_name;
+	char *p;
+	int islockable;
+	acpi_object_type	type = 0;
+
+	if (!count) {
+		return -EINVAL;
+	}
+
+	acpi_name = kmalloc(count+1, GFP_KERNEL);
+	if (!acpi_name) {
+		return -ENOMEM;
+	}
+
+	acpi_name[count] = '\0';
+	strncpy(acpi_name, buf, count);
+
+	for (p = acpi_name+(count-1); p >= acpi_name; --p) {
+		if (isspace(*p))
+			*p = '\0';
+		else
+			break;
+	}
+
+	status = acpi_get_handle(NULL, acpi_name, &hlsb);
+	if(ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	status = acpi_get_type(hlsb, &type);
+	if (ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	result = acpi_bus_get_device(hlsb, &device);
+	if (result) {
+		ret = -ENODEV;
+		goto err;
+	}
+#ifndef FORCE_EJECT
+	if (device->driver == NULL) {
+		ret = -ENODEV;
+		goto err;
+	}
+#endif
+	if (!device->flags.ejectable) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	islockable = device->flags.lockable;
+
+	/*
+	 * remove from ACPI bus.
+	 */
+	if (type == ACPI_BUS_TYPE_PROCESSOR)
+		acpi_bus_trim(device, 0);
+	else
+		acpi_bus_trim(device, 1);
+		
+
+	result = eject_operation(hlsb, islockable);
+	if (result) {
+		ret = -EBUSY;
+	}
+err:
+	kfree(acpi_name);
+	return ret;
+}
+
+
+static int __init register_acpi_eject(void)
+{
+	subsys_create_file(&acpi_subsys, &acpi_eject_attr);
+	return 0;
+}
+
+
+/* --------------------------------------------------------------------------
                               Performance Management
    -------------------------------------------------------------------------- */
 
@@ -1155,6 +1291,11 @@ static int __init acpi_scan_init(void)
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
 
+	/*
+	 * Register hotplug eject interface
+	 */
+	register_acpi_eject();
+
  Done:
 	return_VALUE(result);
 }
_


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
