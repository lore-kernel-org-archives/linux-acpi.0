From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 12/14] ACPI: use proper DYNAMIC_DEBUG_BRANCH macro
Date: Tue, 12 Feb 2019 22:41:48 +0100
Message-ID: <20190212214150.4807-13-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Jason Baron <jbaron@akamai.com>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

dynamic debug may be implemented via static keys, but ACPI is missing
out on that runtime benefit since it open-codes one possible definition
of DYNAMIC_DEBUG_BRANCH.

Cc: linux-acpi@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f20b69a..bcdfbb2bea24 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -987,7 +987,7 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #define acpi_handle_debug(handle, fmt, ...)				\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))		\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
 		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
 				##__VA_ARGS__);				\
 } while (0)
-- 
2.20.1
