From: Joshua Hunt <johunt@akamai.com>
Subject: [PATCH v2 2/2] ACPI, APEI, ERST: Fixed leaked resources in erst_init
Date: Tue,  8 Mar 2016 10:52:12 -0500
Message-ID: <1457452332-2673-3-git-send-email-johunt@akamai.com>
References: <1457452332-2673-1-git-send-email-johunt@akamai.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457452332-2673-1-git-send-email-johunt@akamai.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gong.chen@intel.com, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, Joshua Hunt <johunt@akamai.com>
List-Id: linux-acpi@vger.kernel.org

erst_init currently leaks resources allocated from its call to
apei_resources_init(). The data allocated there gets copied
into apei_resources_all and can be freed when we're done with it.

Signed-off-by: Josh Hunt <johunt@akamai.com>
---
 drivers/acpi/apei/erst.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 6e6bc10..006c389 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1207,6 +1207,9 @@ static int __init erst_init(void)
 		"Failed to allocate %lld bytes for persistent store error log.\n",
 		erst_erange.size);
 
+	/* Cleanup ERST Resources */
+	apei_resources_fini(&erst_resources);
+
 	return 0;
 
 err_release_erange:
-- 
1.7.9.5
