From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] export acpi_get_firmware_table to modules
Date: Tue, 13 Aug 2002 19:28:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020813192839.B5283@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This patch just exports acpi_get_firmware_table to modules.  It's a
more convenient interface to use than acpi_get_table, IMO.

diff -urpNX ../dontdiff acpi/linux-acpi0726/drivers/acpi/acpi_ksyms.c linux-acpi/drivers/acpi/acpi_ksyms.c
--- acpi/linux-acpi0726/drivers/acpi/acpi_ksyms.c	Mon Aug 12 19:43:52 2002
+++ linux-acpi/drivers/acpi/acpi_ksyms.c	Mon Aug 12 19:49:54 2002
@@ -62,6 +62,7 @@ EXPORT_SYMBOL(acpi_get_object_info);
 EXPORT_SYMBOL(acpi_get_next_object);
 EXPORT_SYMBOL(acpi_evaluate_object);
 EXPORT_SYMBOL(acpi_get_table);
+EXPORT_SYMBOL(acpi_get_firmware_table);
 EXPORT_SYMBOL(acpi_install_notify_handler);
 EXPORT_SYMBOL(acpi_remove_notify_handler);
 EXPORT_SYMBOL(acpi_install_gpe_handler);

-- 
Revolutions do not require corporate support.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
