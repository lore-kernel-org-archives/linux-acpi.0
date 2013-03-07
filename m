From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [RESEND PATCH 3/6] acpi: Remove the leading spaces of "finish_override" label in acpi_tb_table_override().
Date: Thu, 7 Mar 2013 18:38:14 +0800
Message-ID: <1362652697-30284-4-git-send-email-tangchen@cn.fujitsu.com>
References: <1362652697-30284-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362652697-30284-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, robert.moore@intel.com, lv.zheng@intel.com, ming.m.lin@intel.com, mpm@selenic.com, herbert@gondor.apana.org.au, rob@landley.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, trivial@kernel.org
List-Id: linux-acpi@vger.kernel.org

There is 7 leading spaces in front of "finish_override" label in acpi_tb_table_override(). Remove them.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/acpica/tbinstal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index e57cd38..b1e098d 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -313,7 +313,7 @@ struct acpi_table_header *acpi_tb_table_override(struct acpi_table_header
 
 	return (NULL);		/* There was no override */
 
-      finish_override:
+finish_override:
 
 	ACPI_INFO((AE_INFO,
 		   "%4.4s %p %s table override, new table: %p",
-- 
1.7.1
