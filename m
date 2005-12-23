From: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] identify which device is not power-manageable
Date: Fri, 23 Dec 2005 13:48:32 -0800
Message-ID: <20051223134832.068052c6.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jhpark-rcMnpv/mMogm2U1zsICqmTJCwzzwUKMU@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Jae-hyeon Park <jhpark-rcMnpv/mMogm2U1zsICqmTJCwzzwUKMU@public.gmane.org>

Identify which device is not power-manageable to make
the message more useful.

Signed-off-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
---
 drivers/acpi/bus.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2615-rc6g4.orig/drivers/acpi/bus.c
+++ linux-2615-rc6g4/drivers/acpi/bus.c
@@ -198,7 +198,8 @@ int acpi_bus_set_power(acpi_handle handl
 
 	if (!device->flags.power_manageable) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Device is not power manageable\n"));
+				  "Device '%s' is not power manageable\n",
+					device->kobj.name));
 		return_VALUE(-ENODEV);
 	}
 	/*


---


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
