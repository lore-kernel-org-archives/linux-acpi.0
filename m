From: Thomas Renninger <trenn@suse.de>
Subject: [Fwd: [PATCH 3/5] Export acpi_check_resource_conflict]
Date: Wed, 24 Oct 2007 16:33:07 +0200
Message-ID: <1193236387.4590.230.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46160 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759897AbXJXOdJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 10:33:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>

Export acpi_check_resource_conflict(), sometimes drivers already have
a struct resource at hand so no need to use the wrappers to build a new
one.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/acpi/osl.c   |    3 ++-
 include/linux/acpi.h |    5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.24-rc0.orig/drivers/acpi/osl.c	2007-10-21 14:36:08.000000=
000 +0200
+++ linux-2.6.24-rc0/drivers/acpi/osl.c	2007-10-21 14:36:13.000000000 +=
0200
@@ -1097,7 +1097,7 @@ __setup("acpi_enforce_resources=3D", acpi_
=20
 /* Check for resource conflicts between ACPI OperationRegions and nati=
ve
  * drivers */
-static int acpi_check_resource_conflict(struct resource *res)
+int acpi_check_resource_conflict(struct resource *res)
 {
 	struct acpi_res_list *res_list_elem;
 	int ioport;
@@ -1147,6 +1147,7 @@ static int acpi_check_resource_conflict(
 	}
 	return 0;
 }
+EXPORT_SYMBOL(acpi_check_resource_conflict);
=20
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name)
--- linux-2.6.24-rc0.orig/include/linux/acpi.h	2007-10-21 14:36:00.0000=
00000 +0200
+++ linux-2.6.24-rc0/include/linux/acpi.h	2007-10-21 14:36:13.000000000=
 +0200
@@ -123,6 +123,8 @@ extern int pci_mmcfg_config_num;
 extern int sbf_port;
 extern unsigned long acpi_realmode_flags;
=20
+int acpi_check_resource_conflict(struct resource *res);
+
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name);
 int acpi_check_mem_region(resource_size_t start, resource_size_t n,
@@ -131,6 +133,9 @@ int acpi_check_mem_region(resource_size_
=20
 #define acpi_mp_config	0
=20
+static inline int acpi_check_resource_conflict(struct resource *res)
+{ return 0; }
+
 static inline int acpi_check_region(resource_size_t start, resource_si=
ze_t n,
 				    const char *name) { return 0 };
=20

--=20
Thomas Renninger

Research and Developement Departement
SUSE LINUX Products GmbH,
Maxfeldstr. 5, D - 90409 N=C3=BCrnberg
Phone: +49 (0)911 - 740 53 675
e-mail: trenn@suse.de

SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG N=C3=BCrnberg)

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
