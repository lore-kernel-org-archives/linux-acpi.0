From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: help for ACPI_CONTAINER sucks
Date: Tue, 18 Jan 2005 14:49:24 +0900
Message-ID: <20050118144924.2ab0749e.tokunaga.keiich@jp.fujitsu.com>
References: <20050115222129.GB10070@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20050115222129.GB10070-lGaJ6EKWmV+kGg0756fqLw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Grant Grundler <grundler-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Grant,

  I'm sorry, the help doesn't help...  Let me explain it here
and I'm attaching a patch.

  The ACPI spec allows one or more "devices", to be described
in a (ACPI0004, PNP0A05, PNP0A06) "container" object.  This is
typically used to describe CPUs, memory, root bridges, P2P
bridges etc. in any arbitrary combination.  The intent is to 
describe the machine, so the contents of a container will 
depend on machine topology.  A container can be used, for
example, to describe a NUMA compute node with CPUs and memory
or an IO node with bridges and slots.  ACPI firmware doesn't
really build container objects today, so these are really useful
in the hot-plug context, at least for now.  The intent of the
new code is to allow an ACPI container to be _physically_
inserted or removed.  It depends on the corresponding _logical_
hotplug functionality (e.g. cpu/memory hotplug) to exist elsewhere
in the kernel.  The current ACPI code only supports a compute
node with CPUs and memory.

Thanks,
Keiichiro Tokunaga

---

 linux-2.6.11-rc1-kei-kei/drivers/acpi/Kconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/Kconfig~fix-help-container drivers/acpi/Kconfig
--- linux-2.6.11-rc1-kei/drivers/acpi/Kconfig~fix-help-container	2005-01-17 11:37:39.000000000 +0900
+++ linux-2.6.11-rc1-kei-kei/drivers/acpi/Kconfig	2005-01-18 14:27:09.000000000 +0900
@@ -339,7 +339,12 @@ config ACPI_CONTAINER
 	depends on ACPI && EXPERIMENTAL
 	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU || ACPI_HOTPLUG_IO)
 	 ---help---
-	 	This is the ACPI generic container driver which supports
-		ACPI0004, PNP0A05 and PNP0A06 devices
+	  This allows _physical_ insertion and removal of CPUs and memory.
+	  This can be useful, for example, on NUMA machines that support
+	  ACPI based physical hotplug of nodes, or non-NUMA machines that
+	  support physical cpu/memory hot-plug.
+
+	  If one selects "m", this driver can be loaded with
+	  "modprobe acpi_container".
 
 endmenu

_



On Sat, 15 Jan 2005 15:21:29 -0700 Grant Grundler wrote:
> 
> Help for ACPI_CONTAINER is just useless:
>                 This is the ACPI generic container driver which supports
> 		ACPI0004, PNP0A05 and PNP0A06 devices.
> 
> Help should explain what those devices are and what might not work
> unless I enable ACPI_CONTAINER. As a !acpi_developer I have no clue
> and am just annoyed by the question.
> 
> Here is a fictious example (I have no clue about ACPI) might provide
> some guidance on what I was expecting:
> 	The ACPI generic container driver provides support for:
> 	ACPI0004 - Hotplug IO
> 	PNP0A05  - Hotplug CPU
> 	PNP0A06  - Hotplug Memory
> 	
> 	One can use those devices but can't access hotplug features
> 	unless this option is enabled.
> 
> 	If one selects "m", this driver can be loaded with
> 	"modprobe acpi_container".
> 
> hth,
> grant
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
