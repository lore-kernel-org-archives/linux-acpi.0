From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [PATCH] Fix an issue in ACPI processor and container drivers related
 with kobject_hotplug()
Date: Mon, 31 Jan 2005 22:08:30 +0900
Message-ID: <20050131220830.3a3d4e0f.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, Anil Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  I posted this patch before, but it has not been included yet.
This was discussed and is ready to be included.

  This is to fix an issue around kobject_hotplug() used in
ACPI processor and container drivers.  A while ago, the
drivers used their own function 'processor_run_sbin_hotplug()
and container_run_sbin_hotplug()' to notify the agent script
using /sbin/hotplug mechanism.  But, they were changed to use
kobject_hotplug() instead and this has caused a side effect.

  The container driver was supposed to invoke a container.agent
(user mode agent script) using /sbin/hotplug mechanism, but
after the changes, it is not able to call the agent any more
and kobject_hotplug() in the container.c became to invoke a
namespace.agent instead if exists.  So, I would like to use
the namespace.agent to handle container hotplug event (or
something else) and let the agent to call proper agent
(e.g. container.agent).  But, there is an issue we need to
solve.  When the namespace.agent is called, a path name of
associated kobject is passed as a DEVPATH (e.g./sys/firmware/
acpi/namespace/ACPI/_SB/DEV0).  However, the agent would not
know what device is associated with the DEVPATH nor which
agents to call since the DEVPATH name depends on platform.
The attached patch is to add .hotplug_ops member to
acpi_namespace_kset structure and let it to set a driver name
attached to the target kobject into the envp[] variable as a
DRV_NAME element.  With this, the namespace.agent can call
proper agents (e.g. container.agent) by refering the DRV_NAME.

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

---

 linux-2.6.11-rc2-kei/drivers/acpi/scan.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

diff -puN drivers/acpi/scan.c~namespace_agent_support drivers/acpi/scan.c
--- linux-2.6.11-rc2/drivers/acpi/scan.c~namespace_agent_support	2005-01-31 22:01:11.000000000 +0900
+++ linux-2.6.11-rc2-kei/drivers/acpi/scan.c	2005-01-31 22:01:11.000000000 +0900
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
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
