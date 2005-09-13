From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 4/5] PNPACPI: only parse device that have CRS method
Date: Mon, 12 Sep 2005 22:38:37 -0700
Message-ID: <200509130539.j8D5d5Xw009974@shell0.pdx.osdl.net>
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, castet.matthieu-GANU6spQydw@public.gmane.org, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>

Blacklist devices that don't have CRS method as they are useless for pnp
layer as they don't provide any resource.

Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/pnp/pnpacpi/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/pnp/pnpacpi/core.c~pnpacpi-only-parse-device-that-have-crs-method drivers/pnp/pnpacpi/core.c
--- devel/drivers/pnp/pnpacpi/core.c~pnpacpi-only-parse-device-that-have-crs-method	2005-09-11 03:20:29.000000000 -0700
+++ devel-akpm/drivers/pnp/pnpacpi/core.c	2005-09-11 03:20:29.000000000 -0700
@@ -131,7 +131,8 @@ static int __init pnpacpi_add_device(str
 	struct pnp_id *dev_id;
 	struct pnp_dev *dev;
 
-	if (!ispnpidacpi(acpi_device_hid(device)) ||
+	status = acpi_get_handle(device->handle, "_CRS", &temp);
+	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
 		is_exclusive_device(device))
 		return 0;
 
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
