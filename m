From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fix an issue in ACPI processor and container
	drivers related with kobject_hotplug()
Date: Tue, 01 Feb 2005 10:07:35 +0800
Message-ID: <1107223655.26227.13.camel@sli10-desk.sh.intel.com>
References: <20050131220830.3a3d4e0f.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050131220830.3a3d4e0f.tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
On Mon, 2005-01-31 at 21:08, Keiichiro Tokunaga wrote:
>   I posted this patch before, but it has not been included yet.
> This was discussed and is ready to be included.
> 
>   This is to fix an issue around kobject_hotplug() used in
> ACPI processor and container drivers.  A while ago, the
> drivers used their own function 'processor_run_sbin_hotplug()
> and container_run_sbin_hotplug()' to notify the agent script
> using /sbin/hotplug mechanism.  But, they were changed to use
> kobject_hotplug() instead and this has caused a side effect.
> 
>   The container driver was supposed to invoke a container.agent
> (user mode agent script) using /sbin/hotplug mechanism, but
> after the changes, it is not able to call the agent any more
> and kobject_hotplug() in the container.c became to invoke a
> namespace.agent instead if exists.  So, I would like to use
> the namespace.agent to handle container hotplug event (or
> something else) and let the agent to call proper agent
> (e.g. container.agent).  But, there is an issue we need to
> solve.  When the namespace.agent is called, a path name of
> associated kobject is passed as a DEVPATH (e.g./sys/firmware/
> acpi/namespace/ACPI/_SB/DEV0).  However, the agent would not
> know what device is associated with the DEVPATH nor which
> agents to call since the DEVPATH name depends on platform.
> The attached patch is to add .hotplug_ops member to
> acpi_namespace_kset structure and let it to set a driver name
> attached to the target kobject into the envp[] variable as a
> DRV_NAME element.  With this, the namespace.agent can call
> proper agents (e.g. container.agent) by refering the DRV_NAME.
This will improve much. I don't know what's intent of
firmware/acpi/namespace clearly, but to me, It seems the acpi bus (so
add acpi bus first) should add .hotplug_ops instead of namespace.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
