From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/7] acpi: fix trivial warnings caused by previous commmit
Date: Mon, 19 Oct 2009 01:54:34 +0300
Message-ID: <1255906474-25091-8-git-send-email-felipe.contreras@gmail.com>
References: <1255906474-25091-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:62235 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbZJRW6F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Oct 2009 18:58:05 -0400
In-Reply-To: <1255906474-25091-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

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
index d7b3b41..597bc39 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -761,7 +761,7 @@ acpi_ex_extract_from_field(union acpi_operand_objec=
t *obj_desc,
=20
 		ACPI_MEMCPY(((char *)buffer) + buffer_offset, &merged_datum,
 			    ACPI_MIN(obj_desc->common_field.access_byte_width,
-				     buffer_length - buffer_offset));
+				     (u8)(buffer_length - buffer_offset)));
=20
 		buffer_offset +=3D obj_desc->common_field.access_byte_width;
 		merged_datum =3D
@@ -780,7 +780,7 @@ acpi_ex_extract_from_field(union acpi_operand_objec=
t *obj_desc,
=20
 	ACPI_MEMCPY(((char *)buffer) + buffer_offset, &merged_datum,
 		    ACPI_MIN(obj_desc->common_field.access_byte_width,
-			     buffer_length - buffer_offset));
+			     (u8)(buffer_length - buffer_offset)));
=20
 	return_ACPI_STATUS(AE_OK);
 }
@@ -880,7 +880,7 @@ acpi_ex_insert_into_field(union acpi_operand_object=
 *obj_desc,
=20
 	ACPI_MEMCPY(&raw_datum, buffer,
 		    ACPI_MIN(obj_desc->common_field.access_byte_width,
-			     buffer_length - buffer_offset));
+			     (u8)(buffer_length - buffer_offset)));
=20
 	merged_datum =3D
 	    raw_datum << obj_desc->common_field.start_field_bit_offset;
@@ -933,7 +933,7 @@ acpi_ex_insert_into_field(union acpi_operand_object=
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
1.6.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
