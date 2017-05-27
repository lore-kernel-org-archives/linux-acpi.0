From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 01/16] platform/x86: wmi: Drop "Mapper (un)loaded" messages
Date: Fri, 26 May 2017 22:31:15 -0700
Message-ID: <e12ef54a704a614659171cb825008fdc07ab4839.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55249 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdE0Fbl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 May 2017 01:31:41 -0400
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>

From: Andy Lutomirski <luto@kernel.org>

WMI is just a driver. There is no need to announce when it is loaded.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/wmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index ceeb8c1..0043581 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -836,7 +836,6 @@ static int __init acpi_wmi_init(void)
 		return error;
 	}
 
-	pr_info("Mapper loaded\n");
 	return 0;
 }
 
@@ -844,8 +843,6 @@ static void __exit acpi_wmi_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_wmi_driver);
 	class_unregister(&wmi_class);
-
-	pr_info("Mapper unloaded\n");
 }
 
 subsys_initcall(acpi_wmi_init);
-- 
2.9.4

