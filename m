From: Poyo VL <poyo_vl@yahoo.com>
Subject: [PATCH] /drivers/acpi/acpica/nsrepair.c (2.6.35.7) - Fixed useless compile warning
Date: Sun, 19 Sep 2010 22:51:23 -0700 (PDT)
Message-ID: <593258.59408.qm@web45801.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web45801.mail.sp1.yahoo.com ([68.180.199.46]:40605 "HELO
	web45801.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751062Ab0ITF6F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Sep 2010 01:58:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

This is not a problem, it is a simple fix for an ugly compiler warning.=
 When I=20
tried to cimpile, I got the following warning:
drivers/acpi/acpica/nsrepair.c: In function =E2=80=98acpi_ns_repair_obj=
ect=E2=80=99:
drivers/acpi/acpica/nsrepair.c:125:29: warning: =E2=80=98new_object=E2=80=
=99 may be used=20
uninitialized in this function
new_object is declared without being initialized. It is initialized in =
a=20
conditional expression like if (expected_btypes & ACPI_RTYPE_INTEGER) s=
o the=20
compiler can't be sure that it will be used initialized, and it throws =
that=20
warning.
Just have to initialize new_object which is a pointer with NULL.
Patch:

Signed-off-by: Ionut Gabriel Popescu <poyo_vl@yahoo.com>
---

--- a/drivers/acpi/acpica/nsrepair.c    2010-09-20 08:35:56.568006487 +=
0300
+++ b/drivers/acpi/acpica/nsrepair.c    2010-09-20 08:00:40.000000000 +=
0300
@@ -122,7 +122,7 @@ acpi_ns_repair_object(struct acpi_predef
               union acpi_operand_object **return_object_ptr)
 {
     union acpi_operand_object *return_object =3D *return_object_ptr;
-    union acpi_operand_object *new_object;
+    union acpi_operand_object *new_object =3D NULL;
     acpi_status status;
=20
     ACPI_FUNCTION_NAME(ns_repair_object);


     =20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
