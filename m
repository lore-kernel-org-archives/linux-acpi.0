From: Yann Droneaud <ydroneaud@mandriva.com>
Subject: [PATCH 1/2] IPMI and acpi=off|ht : acpi-get-firmware-failure.patch
Date: 16 May 2005 23:42:38 +0200
Message-ID: <m23bsmzw35.fsf@firedrake.mandriva.com>
References: <m27jhyzwj6.fsf@firedrake.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261915AbVEPVyO@vger.kernel.org>
In-Reply-To: <m27jhyzwj6.fsf@firedrake.mandriva.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
Cc: Yann Droneaud <ydroneaud@mandriva.com>
List-Id: linux-acpi@vger.kernel.org


This patch check that rsdt_info->pointer is not NULL before trying to
unmap ACPI tables, which can happen if acpi_tb_get_rsdt_address() failed.

In my case, with ipmi_si_intf module and acpi=ht|off parameter, the call
failed because acpi_gbl_table_flags is not initialised, so the
address.pointer_type is not setup correctly, leading to message like:

May 16 11:18:29 localhost kernel:     ACPI-0166: *** Error: Invalid address flags 8

and rsdt_info->pointer equal to NULL leading to the Oops.

--- linux-2.6.11.9/drivers/acpi/tables/tbxfroot.c	2005-05-11 18:42:39.000000000 -0400
+++ linux-2.6.11.9-fixes/drivers/acpi/tables/tbxfroot.c	2005-05-16 16:51:33.115768232 -0400
@@ -313,7 +313,9 @@ acpi_get_firmware_table (
 
 
 cleanup:
-	acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info->pointer->length);
+	if (rsdt_info->pointer) {
+		acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info->pointer->length);
+	}
 	ACPI_MEM_FREE (rsdt_info);
 
 	if (header) {


Signed-Off-by: ydroneaud@mandriva.com

-- 
Yann Droneaud <ydroneaud@mandriva.com>
Consulting Engineer
Professional Services
Mandriva http://mandriva.com/ (previously known as Mandrakesoft)
