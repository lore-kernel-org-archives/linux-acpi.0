From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/6] acpi: fix trivial warnings caused by previous commmit
Date: Thu, 17 Sep 2009 00:38:43 +0300
Message-ID: <1253137123-18047-7-git-send-email-felipe.contreras@gmail.com>
References: <1253137123-18047-1-git-send-email-felipe.contreras@gmail.com>
 <1253137123-18047-2-git-send-email-felipe.contreras@gmail.com>
 <1253137123-18047-3-git-send-email-felipe.contreras@gmail.com>
 <1253137123-18047-4-git-send-email-felipe.contreras@gmail.com>
 <1253137123-18047-5-git-send-email-felipe.contreras@gmail.com>
 <1253137123-18047-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:65443 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760071AbZIPVki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2009 17:40:38 -0400
In-Reply-To: <1253137123-18047-6-git-send-email-felipe.contreras@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

drivers/acpi/acpica/exfldio.c: In function =E2=80=98acpi_ex_extract_fro=
m_field=E2=80=99:
drivers/acpi/acpica/exfldio.c:761: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c:761: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c:761: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c:780: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c:780: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c:780: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c: In function =E2=80=98acpi_ex_insert_into=
_field=E2=80=99:
drivers/acpi/acpica/exfldio.c:880: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c:880: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c:880: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c:933: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c:933: warning: comparison of distinct poin=
ter types lacks a cast
drivers/acpi/acpica/exfldio.c:933: warning: comparison of distinct poin=
ter types lacks a cast

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/acpi/acpica/exfldio.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldi=
o.c
index 6687be1..4affc5f 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -760,7 +760,7 @@ acpi_ex_extract_from_field(union acpi_operand_objec=
t *obj_desc,
=20
 		ACPI_MEMCPY(((char *)buffer) + buffer_offset, &merged_datum,
 			    ACPI_MIN(obj_desc->common_field.access_byte_width,
-				     buffer_length - buffer_offset));
+				     (u8)(buffer_length - buffer_offset)));
=20
 		buffer_offset +=3D obj_desc->common_field.access_byte_width;
 		merged_datum =3D
@@ -779,7 +779,7 @@ acpi_ex_extract_from_field(union acpi_operand_objec=
t *obj_desc,
=20
 	ACPI_MEMCPY(((char *)buffer) + buffer_offset, &merged_datum,
 		    ACPI_MIN(obj_desc->common_field.access_byte_width,
-			     buffer_length - buffer_offset));
+			     (u8)(buffer_length - buffer_offset)));
=20
 	return_ACPI_STATUS(AE_OK);
 }
@@ -879,7 +879,7 @@ acpi_ex_insert_into_field(union acpi_operand_object=
 *obj_desc,
=20
 	ACPI_MEMCPY(&raw_datum, buffer,
 		    ACPI_MIN(obj_desc->common_field.access_byte_width,
-			     buffer_length - buffer_offset));
+			     (u8)(buffer_length - buffer_offset)));
=20
 	merged_datum =3D
 	    raw_datum << obj_desc->common_field.start_field_bit_offset;
@@ -932,7 +932,7 @@ acpi_ex_insert_into_field(union acpi_operand_object=
 *obj_desc,
 		buffer_offset +=3D obj_desc->common_field.access_byte_width;
 		ACPI_MEMCPY(&raw_datum, ((char *)buffer) + buffer_offset,
 			    ACPI_MIN(obj_desc->common_field.access_byte_width,
-				     buffer_length - buffer_offset));
+				     (u8)(buffer_length - buffer_offset)));
 		merged_datum |=3D
 		    raw_datum << obj_desc->common_field.start_field_bit_offset;
 	}
--=20
1.6.5.rc1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
