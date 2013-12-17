From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 06/11] drivers: acpi: Add appropriate ifdef conditions in
 exdump.c
Date: Tue, 17 Dec 2013 14:54:21 +0530
Message-ID: <150a5858e78dc6eabfa11b5d52ce97998b807225.1387271324.git.rashika.kheria@gmail.com>
References: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:32797 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab3LQJYc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2013 04:24:32 -0500
Content-Disposition: inline
In-Reply-To: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org, josh@joshtriplett.org

Enclose functions acpi_ex_dump_namespace_node() and
acpi_ex_dump_object_descriptor() in appropriate ifdef condition of
ACPI_FUTURE_USAGE in file acpica/exdump.c.

This eliminates the following warnings in exdump.c:
drivers/acpi/acpica/exdump.c:809:6: warning: no previous prototype for =
=E2=80=98acpi_ex_dump_namespace_node=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/acpica/exdump.c:995:1: warning: no previous prototype for =
=E2=80=98acpi_ex_dump_object_descriptor=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/acpica/exdump.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.=
c
index 4d046fa..3cd2817 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -54,6 +54,7 @@ ACPI_MODULE_NAME("exdump")
  * The following routines are used for debug output only
  */
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
+#ifdef  ACPI_FUTURE_USAGE
 /* Local prototypes */
 static void acpi_ex_out_string(char *title, char *value);
=20
@@ -68,6 +69,7 @@ static void acpi_ex_dump_reference_obj(union acpi_ope=
rand_object *obj_desc);
 static void
 acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 			 u32 level, u32 index);
+#endif
=20
 /*********************************************************************=
**********
  *
@@ -210,6 +212,7 @@ static struct acpi_exdump_info acpi_ex_dump_bank_fi=
eld[5] =3D {
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(bank_field.bank_obj), "Bank Object=
"}
 };
=20
+#ifdef  ACPI_FUTURE_USAGE
 static struct acpi_exdump_info acpi_ex_dump_index_field[5] =3D {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_bank_field), NULL},
 	{ACPI_EXD_FIELD, 0, NULL},
@@ -218,6 +221,7 @@ static struct acpi_exdump_info acpi_ex_dump_index_f=
ield[5] =3D {
 	 "Index Object"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(index_field.data_obj), "Data Objec=
t"}
 };
+#endif
=20
 static struct acpi_exdump_info acpi_ex_dump_reference[8] =3D {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_reference), NULL},
@@ -287,6 +291,7 @@ static struct acpi_exdump_info acpi_ex_dump_node[5]=
 =3D {
=20
 /* Dispatch table, indexed by object type */
=20
+#ifdef  ACPI_FUTURE_USAGE
 static struct acpi_exdump_info *acpi_ex_dump_info[] =3D {
 	NULL,
 	acpi_ex_dump_integer,
@@ -444,6 +449,7 @@ acpi_ex_dump_object(union acpi_operand_object *obj_=
desc,
 		count--;
 	}
 }
+#endif
=20
 /*********************************************************************=
**********
  *
@@ -785,6 +791,7 @@ acpi_ex_dump_operands(union acpi_operand_object **o=
perands,
  *
  *********************************************************************=
*********/
=20
+#ifdef  ACPI_FUTURE_USAGE
 static void acpi_ex_out_string(char *title, char *value)
 {
 	acpi_os_printf("%20s : %s\n", title, value);
@@ -1042,5 +1049,6 @@ acpi_ex_dump_object_descriptor(union acpi_operand=
_object *obj_desc, u32 flags)
 	acpi_ex_dump_object(obj_desc, acpi_ex_dump_info[obj_desc->common.type=
]);
 	return_VOID;
 }
+#endif
=20
 #endif
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
