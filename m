From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 01/11] drivers: acpi: Mark the function acpi_table_checksum()
 as static in osl.c
Date: Tue, 17 Dec 2013 14:43:05 +0530
Message-ID: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria__40642.1559550383$1387271637$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:57729 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab3LQJNT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2013 04:13:19 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, josh@joshtriplett.org

Marks the function acpi_table_checksum() as static in osl.c
because it is not used outside this file.

This eliminates the following warning in osl.c:
drivers/acpi/osl.c:547:11: warning: no previous prototype for
=E2=80=98acpi_table_checksum=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/osl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 54a20ff..1f4c104 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -544,7 +544,7 @@ static u64 acpi_tables_addr;
 static int all_tables_size;
=20
 /* Copied from acpica/tbutils.c:acpi_tb_checksum() */
-u8 __init acpi_table_checksum(u8 *buffer, u32 length)
+static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
 {
 	u8 sum =3D 0;
 	u8 *end =3D buffer + length;
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
