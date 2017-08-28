From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH V3] acpi: apei: clear error status before acknowledging the error
Date: Mon, 28 Aug 2017 10:53:41 -0600
Message-ID: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

Currently we acknowledge errors before clearing the error status.
This could cause a new error to be populated by firmware in-between
the error acknowledgment and the error status clearing which would
cause the second error's status to be cleared without being handled.
So, clear the error status before acknowledging the errors.

Also, make sure to acknowledge the error if the error status read
fails.

V3: Seperate check for -ENOENT return value

V2: Only send error ack if there was an error populated
    Remove curly braces that are no longer needed

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d45..8d43b1c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -743,17 +743,19 @@ static int ghes_proc(struct ghes *ghes)
 	}
 	ghes_do_proc(ghes, ghes->estatus);
 
+out:
+	ghes_clear_estatus(ghes);
+
+	if (rc == -ENOENT)
+		return rc;
+
 	/*
 	 * GHESv2 type HEST entries introduce support for error acknowledgment,
 	 * so only acknowledge the error if this support is present.
 	 */
-	if (is_hest_type_generic_v2(ghes)) {
-		rc = ghes_ack_error(ghes->generic_v2);
-		if (rc)
-			return rc;
-	}
-out:
-	ghes_clear_estatus(ghes);
+	if (is_hest_type_generic_v2(ghes))
+		return ghes_ack_error(ghes->generic_v2);
+
 	return rc;
 }
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
