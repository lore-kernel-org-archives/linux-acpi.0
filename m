From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/6] ACPI-APEI-EINJ: Replace 12 seq_printf() calls by
 seq_puts() in available_error_type_show()
Date: Tue, 18 Apr 2017 18:54:26 +0200
Message-ID: <31965286-0979-2489-367b-3d4819f4bdd1@users.sourceforge.net>
References: <077115e4-8ec3-9c6d-0374-8ffc5e0f85c0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:51617 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbdDRQyk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 12:54:40 -0400
In-Reply-To: <077115e4-8ec3-9c6d-0374-8ffc5e0f85c0@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Borislav Petkov <bp@suse.de>, Chun-Yi Lee <joeyli.kernel@gmail.com>, Colin Ian King <colin.king@canonical.com>, Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, Linda Knippers <linda.knippers@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Apr 2017 17:50:12 +0200

Strings which did not contain data format specifications should be put
into a sequence. Thus use the corresponding function "seq_puts".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/apei/einj.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index ec50c32ea3da..b2bb7c764cdb 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -580,29 +580,30 @@ static int available_error_type_show(struct seq_file *m, void *v)
 	if (rc)
 		return rc;
 	if (available_error_type & 0x0001)
-		seq_printf(m, "0x00000001\tProcessor Correctable\n");
+		seq_puts(m, "0x00000001\tProcessor Correctable\n");
 	if (available_error_type & 0x0002)
-		seq_printf(m, "0x00000002\tProcessor Uncorrectable non-fatal\n");
+		seq_puts(m, "0x00000002\tProcessor Uncorrectable non-fatal\n");
 	if (available_error_type & 0x0004)
-		seq_printf(m, "0x00000004\tProcessor Uncorrectable fatal\n");
+		seq_puts(m, "0x00000004\tProcessor Uncorrectable fatal\n");
 	if (available_error_type & 0x0008)
-		seq_printf(m, "0x00000008\tMemory Correctable\n");
+		seq_puts(m, "0x00000008\tMemory Correctable\n");
 	if (available_error_type & 0x0010)
-		seq_printf(m, "0x00000010\tMemory Uncorrectable non-fatal\n");
+		seq_puts(m, "0x00000010\tMemory Uncorrectable non-fatal\n");
 	if (available_error_type & 0x0020)
-		seq_printf(m, "0x00000020\tMemory Uncorrectable fatal\n");
+		seq_puts(m, "0x00000020\tMemory Uncorrectable fatal\n");
 	if (available_error_type & 0x0040)
-		seq_printf(m, "0x00000040\tPCI Express Correctable\n");
+		seq_puts(m, "0x00000040\tPCI Express Correctable\n");
 	if (available_error_type & 0x0080)
-		seq_printf(m, "0x00000080\tPCI Express Uncorrectable non-fatal\n");
+		seq_puts(m,
+			 "0x00000080\tPCI Express Uncorrectable non-fatal\n");
 	if (available_error_type & 0x0100)
-		seq_printf(m, "0x00000100\tPCI Express Uncorrectable fatal\n");
+		seq_puts(m, "0x00000100\tPCI Express Uncorrectable fatal\n");
 	if (available_error_type & 0x0200)
-		seq_printf(m, "0x00000200\tPlatform Correctable\n");
+		seq_puts(m, "0x00000200\tPlatform Correctable\n");
 	if (available_error_type & 0x0400)
-		seq_printf(m, "0x00000400\tPlatform Uncorrectable non-fatal\n");
+		seq_puts(m, "0x00000400\tPlatform Uncorrectable non-fatal\n");
 	if (available_error_type & 0x0800)
-		seq_printf(m, "0x00000800\tPlatform Uncorrectable fatal\n");
+		seq_puts(m, "0x00000800\tPlatform Uncorrectable fatal\n");
 
 	return 0;
 }
-- 
2.12.2

