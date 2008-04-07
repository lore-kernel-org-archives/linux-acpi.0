From: Li Zefan <lizf@cn.fujitsu.com>
Subject: [PATCH] ACPI: check a return value correctly in acpi_power_get_context()
Date: Mon, 07 Apr 2008 16:57:06 +0800
Message-ID: <47F9E1E2.5020506@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:51208 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755474AbYDGI7I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2008 04:59:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

We should check *resource != NULL rather than resource != NULL,
which will be always true.

Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
---
 drivers/acpi/power.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 76bf6d9..f2a76ac 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -121,7 +121,7 @@ acpi_power_get_context(acpi_handle handle,
 	}
 
 	*resource = acpi_driver_data(device);
-	if (!resource)
+	if (!*resource)
 		return -ENODEV;
 
 	return 0;
-- 
1.5.4.rc3

