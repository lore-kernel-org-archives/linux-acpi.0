From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [PATCH] fix an issue around kobject_hotplug() in processor.c and
 container.c
Date: Thu, 25 Nov 2004 23:02:57 +0900
Message-ID: <20041125230257.56917529.tokunaga.keiich@jp.fujitsu.com>
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Len, Anil

  I'm attaching a patch fixing an issue around kobject_hotplug()
in drivers/acpi/processor.c and container.c.

  A while ago, drivers/acpi/processor.c and container.c were
changed to use kobject_hotplug() instead of their own functions
'processor_run_sbin_hotplug()/container_run_sbin_hotplug()'.

  The container driver was supposed to invoke a container.agent
(user mode agent script) using /sbin/hotplug mechanism, but
after the changes, it doesn't call the agent any more because
kobject_hotplug() in the container.c invokes a namespace.agent
if exists.  So, I would like to use the namespace.agent to
handle container hotplug event (or something else) and let the
agent to call proper agent (e.g. container.agent).  But, there
is an issue we need to solve.  When the namespace.agent is called,
a path name of associated kobject is passed as a DEVPATH (e.g.
/sys/firmware/acpi/namespace/ACPI/_SB/DEV0).  However, the
agent does not know what device is associated with the DEVPATH
nor which agents to call.  The attached patch is to add 
.hotplug_ops member to acpi_namespace_kset structure and let
it to set a driver name attached to the target kobject into
the envp[] variable as a DRV_NAME element.  So, the
namespace.agent can call proper agents (e.g. container.agent)
by refering the DRV_NAME.

  Please apply.

You can download the namespace.agent from LHNS project
website (http://lhns.sf.net).

Thanks,
Keiichiro Tokunaga


Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Status: Tested on 2.6.10-rc2-mm3
---

 linux-2.6.10-rc2-mm3-kei/drivers/acpi/scan.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

diff -puN drivers/acpi/scan.c~namespace_agent_support drivers/acpi/scan.c
--- linux-2.6.10-rc2-mm3/drivers/acpi/scan.c~namespace_agent_support	2004-11-25 22:20:14.886571312 +0900
+++ linux-2.6.10-rc2-mm3-kei/drivers/acpi/scan.c	2004-11-25 22:20:14.889570856 +0900
@@ -81,12 +81,37 @@ static struct kobj_type ktype_acpi_ns = 
 	.release	= acpi_device_release,
 };
 
+static int namespace_hotplug_env(struct kset *kset, struct kobject *kobj,
+				  char **envp, int num_envp, char *buffer,
+				  int buffer_size)
+{
+	struct acpi_device *dev = to_acpi_device(kobj);
+	int i = 0;
+	int len = 0;
+
+	if (!dev->driver)
+		return 0;
+
+	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
+				"DRV_NAME=%s", dev->driver->name))
+		return -ENOMEM;
+	
+	envp[i] = NULL;
+
+	return 0;
+}
+
+static struct kset_hotplug_ops namespace_hotplug_ops = {
+	.hotplug = &namespace_hotplug_env,
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
http://productguide.itmanagersjournal.com/
