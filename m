From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2 12/13] nouveau: fix memory leak in ACPI _DSM related code
Date: Thu, 19 Dec 2013 20:38:21 +0800
Message-ID: <1387456702-4709-13-git-send-email-jiang.liu@linux.intel.com>
References: <1387456702-4709-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387456702-4709-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, David Airlie <airlied@linux.ie>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-acpi@vger.kernel.org

Fix memory leak in function nouveau_optimus_dsm() and nouveau_dsm().

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/gpu/drm/nouveau/nouveau_acpi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 95c7404..03d4911 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -110,6 +110,7 @@ static int nouveau_optimus_dsm(acpi_handle handle, int func, int arg, uint32_t *
 
 	if (obj->type == ACPI_TYPE_INTEGER)
 		if (obj->integer.value == 0x80000002) {
+			kfree(output.pointer);
 			return -ENODEV;
 		}
 
@@ -156,8 +157,10 @@ static int nouveau_dsm(acpi_handle handle, int func, int arg, uint32_t *result)
 	obj = (union acpi_object *)output.pointer;
 
 	if (obj->type == ACPI_TYPE_INTEGER)
-		if (obj->integer.value == 0x80000002)
+		if (obj->integer.value == 0x80000002) {
+			kfree(output.pointer);
 			return -ENODEV;
+		}
 
 	if (obj->type == ACPI_TYPE_BUFFER) {
 		if (obj->buffer.length == 4 && result) {
-- 
1.7.10.4
