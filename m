From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 17/22] ACPI: implement acpi_handle_debug in terms of _dynamic_func_call
Date: Thu, 20 Sep 2018 00:04:39 +0200
Message-ID: <20180919220444.23190-18-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Baron <jbaron@akamai.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

With coming changes on x86-64, all dynamic debug descriptors in a
translation unit must have distinct names. The macro _dynamic_func_call
takes care of that. No functional change.

Cc: linux-acpi@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e12d5ef1a054..83bacf9039e9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -977,12 +977,8 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #else
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define acpi_handle_debug(handle, fmt, ...)				\
-do {									\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
-		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
-				##__VA_ARGS__);				\
-} while (0)
+	_dynamic_func_call(fmt, __acpi_handle_debug,			\
+			   handle, pr_fmt(fmt), ##__VA_ARGS__)
 #else
 #define acpi_handle_debug(handle, fmt, ...)				\
 ({									\
-- 
2.16.4
