From: Len Brown <lenb@kernel.org>
Subject: [PATCH 40/49] tools/power turbostat: run on IVB Xeon
Date: Sat,  6 Oct 2012 16:10:01 -0400
Message-ID: <1300651b40298ce60ee628b8f13f8c121706b06c.1349554106.git.len.brown@intel.com>
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

This fix is required to run on IVB Xeon,
which previously had an incorrect cpuid model number listed.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 861d771..7108d86 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1038,7 +1038,7 @@ int has_nehalem_turbo_ratio_limit(unsigned int family, unsigned int model)
 	case 0x2A:	/* SNB */
 	case 0x2D:	/* SNB Xeon */
 	case 0x3A:	/* IVB */
-	case 0x3D:	/* IVB Xeon */
+	case 0x3E:	/* IVB Xeon */
 		return 1;
 	case 0x2E:	/* Nehalem-EX Xeon - Beckton */
 	case 0x2F:	/* Westmere-EX Xeon - Eagleton */
@@ -1056,7 +1056,7 @@ int is_snb(unsigned int family, unsigned int model)
 	case 0x2A:
 	case 0x2D:
 	case 0x3A:	/* IVB */
-	case 0x3D:	/* IVB Xeon */
+	case 0x3E:	/* IVB Xeon */
 		return 1;
 	}
 	return 0;
-- 
1.8.0.rc0.18.gf84667d
