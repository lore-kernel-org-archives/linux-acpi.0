From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [RFC][PATCH] CPU hotplug consideration in acpi_bus_add()
Date: Wed, 30 Mar 2005 22:28:41 +0900
Message-ID: <20050330222841.541b7a23.tokunaga.keiich@jp.fujitsu.com>
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, Anil Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

  This is to add CPU hotplug consideration to acpi_bus_add()
that now assumes processor objects are always present,
functioning, etc. at least when parent object is present.
But, CPU hotplug is supported today, so we need to change
the assumption.  If a processor object has _STA method, we
should respect it.

Thanks,
Keiichiro Tokunaga


Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
---

 linux-2.6.12-rc1-mm3-kei-kei/drivers/acpi/scan.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff -puN drivers/acpi/scan.c~cpu_hp_consideration drivers/acpi/scan.c
--- linux-2.6.12-rc1-mm3-kei/drivers/acpi/scan.c~cpu_hp_consideration	2005-03-27 15:51:44.000000000 +0900
+++ linux-2.6.12-rc1-mm3-kei-kei/drivers/acpi/scan.c	2005-03-27 15:51:44.000000000 +0900
@@ -1061,13 +1061,15 @@ acpi_add_single_object (
 	/*
 	 * Status
 	 * ------
-	 * See if the device is present.  We always assume that non-Device()
-	 * objects (e.g. thermal zones, power resources, processors, etc.) are
-	 * present, functioning, etc. (at least when parent object is present).
-	 * Note that _STA has a different meaning for some objects (e.g.
-	 * power resources) so we need to be careful how we use it.
+	 * See if the device is present.  We always assume that non-Device
+	 * and non-Processor objects (e.g. thermal zones, power resources,
+	 * etc.) are present, functioning, etc. (at least when parent object
+	 * is present).  Note that _STA has a different meaning for some
+	 * objects (e.g. power resources) so we need to be careful how we use
+	 * it.
 	 */
 	switch (type) {
+	case ACPI_BUS_TYPE_PROCESSOR:
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
 		if (ACPI_FAILURE(result) || !device->status.present) {

_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
