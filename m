From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 3/3] ACPI, APEI, report GHES error information via printk
Date: Tue, 30 Nov 2010 10:51:41 +0800
Message-ID: <1291085501-31494-4-git-send-email-ying.huang@intel.com>
References: <1291085501-31494-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291085501-31494-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

printk is one of the methods to report hardware errors to user space.
This patch implements hardware error reporting for GHES via printk.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/ghes.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -255,11 +255,23 @@ static void ghes_do_proc(struct ghes *gh
 		}
 #endif
 	}
+}
 
-	if (!processed && printk_ratelimit())
-		pr_warning(GHES_PFX
-		"Unknown error record from generic hardware error source: %d\n",
-			   ghes->generic->header.source_id);
+static void ghes_print_estatus(const char *pfx, struct ghes *ghes)
+{
+	if (pfx == NULL) {
+		if (ghes_severity(ghes->estatus->error_severity) <=
+		    GHES_SEV_CORRECTED)
+			pfx = KERN_WARNING HW_ERR;
+		else
+			pfx = KERN_ERR HW_ERR;
+	}
+	if (printk_ratelimit()) {
+		printk(
+	"%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
+	pfx, ghes->generic->header.source_id);
+		apei_estatus_print(pfx, ghes->estatus);
+	}
 }
 
 static int ghes_proc(struct ghes *ghes)
@@ -269,6 +281,7 @@ static int ghes_proc(struct ghes *ghes)
 	rc = ghes_read_estatus(ghes, 0);
 	if (rc)
 		goto out;
+	ghes_print_estatus(NULL, ghes);
 	ghes_do_proc(ghes);
 
 out:
