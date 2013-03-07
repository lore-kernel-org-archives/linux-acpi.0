From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [RESEND PATCH 5/6] acpi: Add the missing parameter comment for acpi_initialize_tables().
Date: Thu, 7 Mar 2013 18:38:16 +0800
Message-ID: <1362652697-30284-6-git-send-email-tangchen@cn.fujitsu.com>
References: <1362652697-30284-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362652697-30284-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, robert.moore@intel.com, lv.zheng@intel.com, ming.m.lin@intel.com, mpm@selenic.com, herbert@gondor.apana.org.au, rob@landley.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, trivial@kernel.org
List-Id: linux-acpi@vger.kernel.org

In the comment of acpi_initialize_tables(), it mistakes allow_resize
with allow_realloc.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/acpica/tbxface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 93d1432..659e0f6 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -80,7 +80,7 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count)
  *                                    array is dynamically allocated.
  *              initial_table_count - Size of initial_table_array, in number of
  *                                    struct acpi_table_desc structures
- *              allow_realloc       - Flag to tell Table Manager if resize of
+ *              allow_resize        - Flag to tell Table Manager if resize of
  *                                    pre-allocated array is allowed. Ignored
  *                                    if initial_table_array is NULL.
  *
-- 
1.7.1
