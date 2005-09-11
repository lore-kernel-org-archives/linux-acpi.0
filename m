From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Subject: [PATCH - Resend] PNPACPI: only parse device that have CRS method
Date: Sun, 11 Sep 2005 12:12:31 +0200
Message-ID: <4324030F.3090406@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060900080206010200080702"
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060900080206010200080702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch blacklist device that don't have CRS method as there are
useless for pnp layer as they don't provide any resource.

Please comment and consider for inclusion.

Thanks,

Matthieu


--------------060900080206010200080702
Content-Type: text/x-patch;
 name="pnpacpi_nocrs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_nocrs.patch"

Index: linux-2.6.13rc/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-2.6.13rc.orig/drivers/pnp/pnpacpi/core.c	2005-08-28 19:24:40.000000000 +0200
+++ linux-2.6.13rc/drivers/pnp/pnpacpi/core.c	2005-08-28 19:26:35.000000000 +0200
@@ -131,7 +131,8 @@
 	struct pnp_id *dev_id;
 	struct pnp_dev *dev;
 
-	if (!ispnpidacpi(acpi_device_hid(device)) ||
+	status = acpi_get_handle(device->handle, "_CRS", &temp);
+	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
 		is_exclusive_device(device))
 		return 0;
 


--------------060900080206010200080702--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
