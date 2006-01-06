From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 6/9] PNPACPI: only parse device that have CRS method
Date: Thu, 05 Jan 2006 22:30:57 -0800
Message-ID: <200601060631.k066V9G7008138@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, castet.matthieu-GANU6spQydw@public.gmane.org, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
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
--- devel/drivers/pnp/pnpacpi/core.c~pnpacpi-only-parse-device-that-have-crs-method	2006-01-05 22:28:25.000000000 -0800
+++ devel-akpm/drivers/pnp/pnpacpi/core.c	2006-01-05 22:29:45.000000000 -0800
@@ -131,7 +131,8 @@ static int __init pnpacpi_add_device(str
 	struct pnp_id *dev_id;
 	struct pnp_dev *dev;
 
-	if (!ispnpidacpi(acpi_device_hid(device)) ||
+	status = acpi_get_handle(device->handle, "_CRS", &temp);
+	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
 		is_exclusive_device(device))
 		return 0;
 
_
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
