From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [Lhns-devel] Re: [PATCH 6/6]ACPI based Physical CPU hotplug
Date: Tue, 14 Sep 2004 16:57:43 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040914165743.6c8e6fe5.tokunaga.keiich@jp.fujitsu.com>
References: <44BDAFB888F59F408FAE3CC35AB47041B17999@orsmsx409>
 <20040908184152.D7384@unix-os.sc.intel.com>
 <20040913101834.65490902.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20040913101834.65490902.tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhns-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 13 Sep 2004 10:18:34 +0900 Keiichiro Tokunaga wrote:
> On Wed, 08 Sep 2004 18:41:52 -0700 Keshavamurthy Anil S wrote:
> > ---
> > Name:container_drv.patch
> > Status: Tested on 2.6.9-rc1-mm2
> > Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Depends:	
> > Version: applies on 2.6.9-rc1-mm2
> > Description:
> > This is the very early version on the Container driver which supports
> > hotplug notifications on ACPI004, PNP0A05 and PNP0A06 devices.
> 
> Here is a typo fix.  The HID 'ACPI004' should be 'ACPI0004':)

I found two more typos in drivers/acpi/Kconfig:)  Here is an
updated patch.

Thanks,
Keiichiro Tokunaga


Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

---

 linux-2.6.9-rc1-mm3-kei/drivers/acpi/Kconfig     |    4 ++--
 linux-2.6.9-rc1-mm3-kei/drivers/acpi/container.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/acpi/container.c~fix-acpi0004 drivers/acpi/container.c
--- linux-2.6.9-rc1-mm3/drivers/acpi/container.c~fix-acpi0004	2004-09-14 09:21:44.105042495 +0900
+++ linux-2.6.9-rc1-mm3-kei/drivers/acpi/container.c	2004-09-14 09:21:44.106019063 +0900
@@ -58,7 +58,7 @@ static int acpi_container_remove(struct 
 static struct acpi_driver acpi_container_driver = {
 	.name =		ACPI_CONTAINER_DRIVER_NAME,
 	.class =	ACPI_CONTAINER_CLASS,
-	.ids =		"ACPI004,PNP0A05,PNP0A06",
+	.ids =		"ACPI0004,PNP0A05,PNP0A06",
 	.ops =		{
 				.add =		acpi_container_add,
 				.remove =	acpi_container_remove,
@@ -270,7 +270,7 @@ container_walk_namespace_cb(acpi_handle 
 		goto end;
 	}
 
-	if (strcmp(hid, "ACPI004") && strcmp(hid, "PNP0A05") &&
+	if (strcmp(hid, "ACPI0004") && strcmp(hid, "PNP0A05") &&
 			strcmp(hid, "PNP0A06")) {
 		goto end;
 	}
diff -puN drivers/acpi/Kconfig~fix-acpi0004 drivers/acpi/Kconfig
--- linux-2.6.9-rc1-mm3/drivers/acpi/Kconfig~fix-acpi0004	2004-09-14 16:03:54.646284767 +0900
+++ linux-2.6.9-rc1-mm3-kei/drivers/acpi/Kconfig	2004-09-14 16:04:19.225512452 +0900
@@ -317,11 +317,11 @@ config ACPI_SCI_EMULATE
 	  device object name).
 
 config ACPI_CONTAINER
-	tristate "ACPI004,PNP0A05 and PNP0A06 Container Driver"
+	tristate "ACPI0004, PNP0A05 and PNP0A06 Container Driver"
 	depends on (ACPI)
 	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU || ACPI_HOTPLUG_IO)
 	 ---help---
 	 	This is the ACPI generic container driver which supports
-		ACPI004, PNP0A05 and PNP0A06 devices
+		ACPI0004, PNP0A05 and PNP0A06 devices
 
 endmenu

_


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
