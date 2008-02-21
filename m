From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/26] ACPI: fix build warning
Date: Thu, 21 Feb 2008 04:25:35 -0500
Message-ID: <1186974f3ffe3c1796e5efce7afffefcfda9a6f0.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55522 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756585AbYBUJ3L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 04:29:11 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Ming Lin <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exregion.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

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
--=20
1.5.4.2

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
