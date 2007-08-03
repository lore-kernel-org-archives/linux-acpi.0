From: Len Brown <len.brown@intel.com>
Subject: [PATCH 11/12] ACPI: EC: fix build warning
Date: Fri,  3 Aug 2007 18:33:44 -0400
Message-ID: <11861804361684-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763755AbXHCWd5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:57 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <52fe4bdf40bc07498c5f7935551774e8f8458190.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

drivers/acpi/ec.c:657: warning: =E2=80=98acpi_ec_register_query_methods=
=E2=80=99 defined but not used

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 4d7fe82..6292890 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -652,19 +652,6 @@ static struct acpi_ec *make_acpi_ec(void)
 }
=20
 static acpi_status
-acpi_ec_register_query_methods(acpi_handle handle, u32 level,
-			       void *context, void **return_value)
-{
-	struct acpi_namespace_node *node =3D handle;
-	struct acpi_ec *ec =3D context;
-	int value =3D 0;
-	if (sscanf(node->name.ascii, "_Q%x", &value) =3D=3D 1) {
-		acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
-	}
-	return AE_OK;
-}
-
-static acpi_status
 ec_parse_device(acpi_handle handle, u32 Level, void *context, void **r=
etval)
 {
 	acpi_status status;
--=20
1.5.3.rc3.7.gd58e
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
