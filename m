From: Lekensteyn <lekensteyn@gmail.com>
Subject: [PATCH] ACPICA: Fix documentation of acpi_get_name
Date: Sat, 10 Nov 2012 12:03:25 +0100
Message-ID: <2420385.2vUNKyqQx0@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42085 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab2KJLDd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Nov 2012 06:03:33 -0500
Received: by mail-wi0-f178.google.com with SMTP id hr7so1188897wib.1
        for <linux-acpi@vger.kernel.org>; Sat, 10 Nov 2012 03:03:32 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

acpi_get_name has always returned acpi_status since 2009 and passed the
string containing the path to parameter "buffer".

Signed-off-by: Peter Wu <lekensteyn@gmail.com>
---
 drivers/acpi/acpica/nsxfname.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 08e9610..c27c12d 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -146,7 +146,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_handle)
  *              name_type       - Full pathname or single segment
  *              buffer          - Buffer for returned path
  *
- * RETURN:      Pointer to a string containing the fully qualified Name.
+ * RETURN:      Status
  *
  * DESCRIPTION: This routine returns the fully qualified name associated with
  *              the Handle parameter.  This and the acpi_pathname_to_handle are
-- 
1.8.0


