From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 1/6] In acpi_memory_device_notify()
Date: Tue, 5 Mar 2013 16:23:23 +0800
Message-ID: <1362471808-9437-2-git-send-email-tangchen@cn.fujitsu.com>
References: <1362471808-9437-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362471808-9437-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, robert.moore@intel.com, lv.zheng@intel.com, ming.m.lin@intel.com, mpm@selenic.com, herbert@gondor.apana.org.au, rob@landley.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, trival@kernel.org
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/acpi_memhotplug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index da1f82b..8a10c23 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -369,7 +369,7 @@ static void acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
 			kfree(ej_event);
 		}
 
- unlock:
+unlock:
 		acpi_scan_lock_release();
 		if (ACPI_SUCCESS(status))
 			return;
-- 
1.7.1
