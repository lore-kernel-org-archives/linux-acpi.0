From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 5/6] acpi: Check if @id is NULL in acpi_table_parse()
Date: Fri, 16 Aug 2013 15:06:48 +0800
Message-ID: <1376636809-10159-6-git-send-email-tangchen@cn.fujitsu.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

strncmp() does not check if the params are NULL. In acpi_table_parse(),
if @id is NULL, the kernel will panic.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/tables.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index d67a1fe..5a5263b 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -293,7 +293,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!handler)
+	if (!id || !handler)
 		return -EINVAL;
 
 	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
-- 
1.7.1
