From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 13/14] ACPI: remove unused __acpi_handle_debug macro
Date: Tue, 12 Feb 2019 22:41:49 +0100
Message-ID: <20190212214150.4807-14-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Jason Baron <jbaron@akamai.com>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

If CONFIG_DYNAMIC_DEBUG is not set, acpi_handle_debug directly invokes
acpi_handle_printk (if DEBUG) or does a no-printk (if !DEBUG). So this
macro is never used.

Cc: linux-acpi@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index bcdfbb2bea24..07b9fa507824 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -953,9 +953,6 @@ acpi_handle_printk(const char *level, void *handle, const char *fmt, ...) {}
 #if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
 __printf(3, 4)
 void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const char *fmt, ...);
-#else
-#define __acpi_handle_debug(descriptor, handle, fmt, ...)		\
-	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__);
 #endif
 
 /*
-- 
2.20.1
