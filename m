From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 16/22] ACPI: remove unused __acpi_handle_debug macro
Date: Thu, 20 Sep 2018 00:04:38 +0200
Message-ID: <20180919220444.23190-17-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Baron <jbaron@akamai.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

If CONFIG_DYNAMIC_DEBUG is not set, acpi_handle_debug directly invokes
acpi_handle_printk (if DEBUG) or does a no-printk (if !DEBUG). So this
macro is never used.

Cc: linux-acpi@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 21e03aa32aae..e12d5ef1a054 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -948,9 +948,6 @@ acpi_handle_printk(const char *level, void *handle, const char *fmt, ...) {}
 #if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
 __printf(3, 4)
 void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const char *fmt, ...);
-#else
-#define __acpi_handle_debug(descriptor, handle, fmt, ...)		\
-	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__);
 #endif
 
 /*
-- 
2.16.4
