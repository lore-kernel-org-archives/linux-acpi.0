From: Len Brown <lenb@kernel.org>
Subject: Re: i386 warnings in acpi-test
Date: Thu, 21 Feb 2008 02:49:30 -0500
Message-ID: <200802210249.30481.lenb@kernel.org>
References: <20080215204706.89342eb5.akpm@linux-foundation.org> <200802160042.18620.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37474 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbYBUIls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 03:41:48 -0500
In-Reply-To: <200802160042.18620.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

On Saturday 16 February 2008 00:42, Len Brown wrote:

> > drivers/acpi/executer/exregion.c: In function 'acpi_ex_pci_config_s=
pace_handler':
> > drivers/acpi/executer/exregion.c:369: warning: passing argument 3 o=
f 'acpi_os_read_pci_configuration' from incompatible pointer type

Subject: ACPI: fix build warning
=46rom: Ming Lin <ming.m.lin@intel.com>

CC      drivers/acpi/executer/exregion.o
drivers/acpi/executer/exregion.c: In function
=E2=80=98acpi_ex_pci_config_space_handler=E2=80=99:
drivers/acpi/executer/exregion.c:369: attention : passing argument 3 of
=E2=80=98acpi_os_read_pci_configuration=E2=80=99 from incompatible poin=
ter type

exposed by 10270d4838bdc493781f5a1cf2e90e9c34c9142f

http://bugzilla.kernel.org/show_bug.cgi?id=3D9989

Signed-off-by: Ming Lin <ming.m.lin@intel.com>
---
diff --git a/drivers/acpi/executer/exregion.c b/drivers/acpi/executer/e=
xregion.c
index 2e9ce94..3f51b7e 100644
--- a/drivers/acpi/executer/exregion.c
+++ b/drivers/acpi/executer/exregion.c
@@ -338,6 +338,7 @@ acpi_ex_pci_config_space_handler(u32 function,
 	acpi_status status =3D AE_OK;
 	struct acpi_pci_id *pci_id;
 	u16 pci_register;
+	u32 value32;
=20
 	ACPI_FUNCTION_TRACE(ex_pci_config_space_handler);
=20
@@ -364,9 +365,9 @@ acpi_ex_pci_config_space_handler(u32 function,
 	switch (function) {
 	case ACPI_READ:
=20
-		*value =3D 0;
 		status =3D acpi_os_read_pci_configuration(pci_id, pci_register,
-							value, bit_width);
+							&value32, bit_width);
+		*value =3D value32;
 		break;
=20
 	case ACPI_WRITE:
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
