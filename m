From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [RESEND PATCH 2/6] acpi: Add missing parameter comment for acpi_get_table_with_size().
Date: Thu, 7 Mar 2013 18:38:13 +0800
Message-ID: <1362652697-30284-3-git-send-email-tangchen@cn.fujitsu.com>
References: <1362652697-30284-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362652697-30284-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, robert.moore@intel.com, lv.zheng@intel.com, ming.m.lin@intel.com, mpm@selenic.com, herbert@gondor.apana.org.au, rob@landley.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, trivial@kernel.org
List-Id: linux-acpi@vger.kernel.org

In the comment of acpi_get_table_with_size(), one parameter tbl_size
is missing. And the definitions of i and j begin with space, not tab.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/acpica/tbxface.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index b35a5e6..93d1432 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -304,6 +304,7 @@ ACPI_EXPORT_SYMBOL(acpi_unload_table_id)
  * PARAMETERS:  signature           - ACPI signature of needed table
  *              instance            - Which instance (for SSDTs)
  *              out_table           - Where the pointer to the table is returned
+ *              tbl_size            - Size of the table
  *
  * RETURN:      Status and pointer to table
  *
@@ -315,8 +316,7 @@ acpi_get_table_with_size(char *signature,
 	       u32 instance, struct acpi_table_header **out_table,
 	       acpi_size *tbl_size)
 {
-       u32 i;
-       u32 j;
+	u32 i, j;
 	acpi_status status;
 
 	/* Parameter validation */
-- 
1.7.1
