From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH] acpi/apei: free lists of resources in einj and erst
Date: Fri, 10 Jul 2015 14:58:32 +0300
Message-ID: <20150710115832.13167.20624.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>
List-Id: linux-acpi@vger.kernel.org

This patch adds missing apei_resources_fini and
plugs several tiny memory leaks.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/acpi/apei/apei-base.c |    2 ++
 drivers/acpi/apei/einj.c      |    7 +++----
 drivers/acpi/apei/erst.c      |    1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index a85ac07f3da3..b9a5418e6938 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -497,6 +497,7 @@ int apei_resources_request(struct apei_resources *resources,
 	rc = apei_resources_sub(resources, &nvs_resources);
 	if (rc)
 		goto nvs_res_fini;
+	apei_resources_fini(&nvs_resources);
 
 	if (arch_apei_filter_addr) {
 		apei_resources_init(&arch_res);
@@ -506,6 +507,7 @@ int apei_resources_request(struct apei_resources *resources,
 		rc = apei_resources_sub(resources, &arch_res);
 		if (rc)
 			goto arch_res_fini;
+		apei_resources_fini(&arch_res);
 	}
 
 	rc = -EINVAL;
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index a095d4f858da..ed02d9da4a3e 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -379,10 +379,9 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 			rc = apei_resources_add(&addr_resources,
 				trigger_param_region->address,
 				trigger_param_region->bit_width/8, true);
-			if (rc)
-				goto out_fini;
-			rc = apei_resources_sub(&trigger_resources,
-					&addr_resources);
+			if (!rc)
+				rc = apei_resources_sub(&trigger_resources,
+							&addr_resources);
 		}
 		apei_resources_fini(&addr_resources);
 		if (rc)
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 3670bbab57a3..41ceeae3f6aa 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1190,6 +1190,7 @@ static int __init erst_init(void)
 	if (!erst_erange.vaddr)
 		goto err_release_erange;
 
+	apei_resources_fini(&erst_resources);
 	pr_info(
 	"Error Record Serialization Table (ERST) support is initialized.\n");
 
