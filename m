From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 08/12] Fix an issue in ACPI processor and container drivers related  with kobject_hotplug()
Date: Wed, 23 Feb 2005 01:53:06 -0800
Message-ID: <200502230953.j1N9rLEx020711@shell0.pdx.osdl.net>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

This is to fix an issue around kobject_hotplug() used in ACPI processor and
container drivers.  A while ago, the drivers used their own function
'processor_run_sbin_hotplug() and container_run_sbin_hotplug()' to notify
the agent script using /sbin/hotplug mechanism.  But, they were changed to
use kobject_hotplug() instead and this has caused a side effect.

The container driver was supposed to invoke a container.agent (user mode
agent script) using /sbin/hotplug mechanism, but after the changes, it is
not able to call the agent any more and kobject_hotplug() in the
container.c became to invoke a namespace.agent instead if exists.  So, I
would like to use the namespace.agent to handle container hotplug event (or
something else) and let the agent to call proper agent (e.g. 
container.agent).  But, there is an issue we need to solve.  When the
namespace.agent is called, a path name of associated kobject is passed as a
DEVPATH (e.g./sys/firmware/ acpi/namespace/ACPI/_SB/DEV0).  However, the
agent would not know what device is associated with the DEVPATH nor which
agents to call since the DEVPATH name depends on platform.  The attached
patch is to add .hotplug_ops member to acpi_namespace_kset structure and
let it to set a driver name attached to the target kobject into the envp[]
variable as a DRV_NAME element.  With this, the namespace.agent can call
proper agents (e.g.  container.agent) by refering the DRV_NAME.

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/drivers/acpi/scan.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

diff -puN drivers/acpi/scan.c~fix-an-issue-in-acpi-processor-and-container-drivers-related-with-kobject_hotplug drivers/acpi/scan.c
--- 25/drivers/acpi/scan.c~fix-an-issue-in-acpi-processor-and-container-drivers-related-with-kobject_hotplug	2005-02-23 01:48:05.000000000 -0800
+++ 25-akpm/drivers/acpi/scan.c	2005-02-23 01:48:05.000000000 -0800
@@ -81,12 +81,37 @@ static struct kobj_type ktype_acpi_ns = 
 	.release	= acpi_device_release,
 };
 
+static int namespace_hotplug(struct kset *kset, struct kobject *kobj,
+			     char **envp, int num_envp, char *buffer,
+			     int buffer_size)
+{
+	struct acpi_device *dev = to_acpi_device(kobj);
+	int i = 0;
+	int len = 0;
+
+	if (!dev->driver)
+		return 0;
+
+	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
+				"PHYSDEVDRIVER=%s", dev->driver->name))
+		return -ENOMEM;
+
+	envp[i] = NULL;
+
+	return 0;
+}
+
+static struct kset_hotplug_ops namespace_hotplug_ops = {
+	.hotplug = &namespace_hotplug,
+};
+
 static struct kset acpi_namespace_kset = {
 	.kobj		= { 
 		.name = "namespace",
 	},
 	.subsys = &acpi_subsys,
 	.ktype	= &ktype_acpi_ns,
+	.hotplug_ops = &namespace_hotplug_ops,
 };
 
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
