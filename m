From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] fix an issue around kobject_hotplug() in processor.c and
 container.c
Date: Fri, 26 Nov 2004 11:38:40 +0900
Message-ID: <20041126113840.557c0d4a.tokunaga.keiich@jp.fujitsu.com>
References: <20041125230257.56917529.tokunaga.keiich@jp.fujitsu.com>
 <20041125181548.GB30760@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20041125181548.GB30760-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 25 Nov 2004 10:15:48 -0800 Greg KH wrote:
> On Thu, Nov 25, 2004 at 11:02:57PM +0900, Keiichiro Tokunaga wrote:
> > +	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
> > +				"DRV_NAME=%s", dev->driver->name))
> 
> That should be PHYSDEVDRIVER not DRV_NAME to be consistant with the rest
> of the driver core.

  Exactly.  Thanks for the comments:)

  Len, I'm attaching an updated patch.  Please apply.

Thanks,
Keiichiro Tokunaga

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
---

 linux-2.6.10-rc2-mm3-kei/drivers/acpi/scan.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

diff -puN drivers/acpi/scan.c~namespace_agent_support drivers/acpi/scan.c
--- linux-2.6.10-rc2-mm3/drivers/acpi/scan.c~namespace_agent_support	2004-11-25 22:20:14.000000000 +0900
+++ linux-2.6.10-rc2-mm3-kei/drivers/acpi/scan.c	2004-11-26 08:57:47.048358808 +0900
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
http://productguide.itmanagersjournal.com/
