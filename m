From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 04/22] x86, ACPI: Search buffer above 4G in second try for acpi override tables
Date: Thu,  4 Apr 2013 16:46:08 -0700
Message-ID: <1365119186-23487-5-git-send-email-yinghai@kernel.org>
References: <1365119186-23487-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365119186-23487-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Now we only search buffer for override acpi table under 4G.
In some case, like user use memmap to exclude all low ram,
we may not find range for it under 4G.

Do second try to search above 4G.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/osl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 313d14d..c08cdb6 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -627,6 +627,10 @@ void __init acpi_initrd_override(void *data, size_t size)
 	/* under 4G at first, then above 4G */
 	acpi_tables_addr = memblock_find_in_range(0, (1ULL<<32) - 1,
 					all_tables_size, PAGE_SIZE);
+	if (!acpi_tables_addr)
+		acpi_tables_addr = memblock_find_in_range(0,
+					~(phys_addr_t)0,
+					all_tables_size, PAGE_SIZE);
 	if (!acpi_tables_addr) {
 		WARN_ON(1);
 		return;
-- 
1.8.1.4
