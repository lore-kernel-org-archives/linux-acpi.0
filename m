From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/18] ACPICA: Linux-specific header: Add support for s390x compilation.
Date: Wed, 28 Dec 2016 15:28:56 +0800
Message-ID: <3bd56752472fc2b4718d0e3d9b2f02badb70176e.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit ecac9504e32d3b501c8cb021afb253b4a83fc82f

Adds s390x as a 64-bit architecture.

Link: https://github.com/acpica/acpica/commit/ecac9504
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/aclinux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index af588e0..252359e 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -201,7 +201,8 @@
 #define ACPI_CAST_PTHREAD_T(pthread) ((acpi_thread_id) (pthread))
 
 #if defined(__ia64__)    || defined(__x86_64__) ||\
-	defined(__aarch64__) || defined(__PPC64__)
+	defined(__aarch64__) || defined(__PPC64__) ||\
+	defined(__s390x__)
 #define ACPI_MACHINE_WIDTH          64
 #define COMPILER_DEPENDENT_INT64    long
 #define COMPILER_DEPENDENT_UINT64   unsigned long
-- 
2.7.4
