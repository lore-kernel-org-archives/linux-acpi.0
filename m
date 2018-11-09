From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 17/23] ACPI: implement acpi_handle_debug in terms of _dynamic_func_call
Date: Sat, 10 Nov 2018 00:10:15 +0100
Message-ID: <20181109231021.11658-18-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Jason Baron <jbaron@akamai.com>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

With coming changes on x86-64, all dynamic debug descriptors in a
translation unit must have distinct names. The macro _dynamic_func_call
takes care of that. No functional change.

Cc: linux-acpi@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index de8633456d71..b284598ae023 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -975,12 +975,8 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
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
2.19.1.6.gbde171bbf5
