From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 1/4] ACPI / fan: remove unused macro for debug
Date: Tue,  3 Dec 2013 16:28:29 +0800
Message-ID: <1386059312-2990-2-git-send-email-aaron.lu@intel.com>
References: <1386059312-2990-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386059312-2990-1-git-send-email-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The _COMPONENT and ACPI_MODULE_NAME(name) is used for ACPI_DEBUG_PRINT,
since there is no such use in fan module we can remove them.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/fan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 1fb62900f32a..9638d28513e8 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -36,9 +36,6 @@
 #define ACPI_FAN_CLASS			"fan"
 #define ACPI_FAN_FILE_STATE		"state"
 
-#define _COMPONENT		ACPI_FAN_COMPONENT
-ACPI_MODULE_NAME("fan");
-
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Fan Driver");
 MODULE_LICENSE("GPL");
-- 
1.8.3.1
