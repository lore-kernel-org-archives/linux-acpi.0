From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Container.ko: Use kobject_hotplug() to notify user agent
Date: Wed, 10 Nov 2004 18:16:53 -0800
Message-ID: <20041110181653.A15383@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developer <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Len,
	Due to "hotplug_path" getting un-exported from mm3, the container code
was breaking and was asked to use kobject_hotplug to notify user agent.

So I have fixed the container driver to use kobject_hotplug().
This patch will fix the undefined "hotplug_path" warning.

Please apply.

---

 linux-2.6.10-rc1-mm4-askeshav/drivers/acpi/container.c |   52 -----------------
 1 files changed, 3 insertions(+), 49 deletions(-)

diff -puN drivers/acpi/container.c~container_u1_hotplug_path_fix drivers/acpi/container.c
--- linux-2.6.10-rc1-mm4/drivers/acpi/container.c~container_u1_hotplug_path_fix	2004-11-10 13:33:29.657947459 -0800
+++ linux-2.6.10-rc1-mm4-askeshav/drivers/acpi/container.c	2004-11-10 13:33:29.735095896 -0800
@@ -133,52 +133,6 @@ acpi_container_remove(struct acpi_device
 
 
 static int
-container_run_sbin_hotplug(struct acpi_device *device, char *action)
-{
-	char *argv[3], *envp[6], action_str[32];
-	int i, ret;
-	int len;
-	char pathname[ACPI_PATHNAME_MAX] = {0};
-	acpi_status status;
-	char *container_str;
-	struct acpi_buffer buffer = {ACPI_PATHNAME_MAX, pathname};
-
-	ACPI_FUNCTION_TRACE("container_run_sbin_hotplug");
-
-
-	status = acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
-	if (ACPI_FAILURE(status)) {
-		return(-ENODEV);
-	}
-
-	len = strlen("CONTAINER=") + strlen(pathname) + 1;
-	container_str = kmalloc(len, GFP_KERNEL);
-	if (!container_str)
-		return(-ENOMEM);
-
-	sprintf(container_str, "CONTAINER=%s",pathname);
-	sprintf(action_str, "ACTION=%s", action);
-
-	i = 0;
-	argv[i++] = hotplug_path;
-	argv[i++] = "container";
-	argv[i] = NULL;
-
-	i = 0;
-	envp[i++] = "HOME=/";
-	envp[i++] = "PATH=/sbin;/bin;/usr/sbin;/usr/bin";
-	envp[i++] = action_str;
-	envp[i++] = container_str;
-	envp[i++] = "PLATFORM=ACPI";
-	envp[i] = NULL;
-
-	ret = call_usermodehelper(argv[0], argv, envp, 0);
-
-	kfree(container_str);
-	return_VALUE(ret);
-}
-
-static int
 container_device_add(struct acpi_device **device, acpi_handle handle)
 {
 	acpi_handle phandle;
@@ -228,16 +182,16 @@ container_notify_cb(acpi_handle handle, 
 			if (ACPI_FAILURE(status) || !device) {
 				result = container_device_add(&device, handle);
 				if (!result)
-					container_run_sbin_hotplug(device, "add");
+					kobject_hotplug(&device->kobj, KOBJ_ONLINE);
 			} else {
 				/* device exist and this is a remove request */
-				container_run_sbin_hotplug(device, "remove");
+				kobject_hotplug(&device->kobj, KOBJ_OFFLINE);
 			}
 		}
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		if (!acpi_bus_get_device(handle, &device) && device) {
-			container_run_sbin_hotplug(device, "remove");
+			kobject_hotplug(&device->kobj, KOBJ_OFFLINE);
 		}
 		break;
 	default:
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
