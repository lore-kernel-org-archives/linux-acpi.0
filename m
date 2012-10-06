From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/49] tools/power turbostat: delete unused line
Date: Sat,  6 Oct 2012 16:10:02 -0400
Message-ID: <d7db69016548c4bf3bec3556f6a15b9332dae34f.1349554106.git.len.brown@intel.com>
References: <1349554210-29978-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349554210-29978-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>

MSR_TSC is no longer needed because
we now use RDTSC directly.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7108d86..3c9dc54 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -35,7 +35,6 @@
 #include <ctype.h>
 #include <sched.h>
 
-#define MSR_TSC	0x10
 #define MSR_NEHALEM_PLATFORM_INFO	0xCE
 #define MSR_NEHALEM_TURBO_RATIO_LIMIT	0x1AD
 #define MSR_APERF	0xE8
-- 
1.8.0.rc0.18.gf84667d
