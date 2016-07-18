From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V10 3/9] vfio: platform: determine reset capability
Date: Mon, 18 Jul 2016 19:09:21 -0400
Message-ID: <1468883367-2854-4-git-send-email-okaya@codeaurora.org>
References: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Creating a new function to determine if this driver supports reset
function or not. This is an attempt to abstract device tree calls
from the rest of the code.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
Reviewed-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 drivers/vfio/platform/vfio_platform_common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 3e2a7c0..6be92c3 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -49,6 +49,11 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
 	return reset_fn;
 }
 
+static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
+{
+	return vdev->of_reset ? true : false;
+}
+
 static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
 {
 	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
@@ -214,7 +219,7 @@ static long vfio_platform_ioctl(void *device_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		if (vdev->of_reset)
+		if (vfio_platform_has_reset(vdev))
 			vdev->flags |= VFIO_DEVICE_FLAGS_RESET;
 		info.flags = vdev->flags;
 		info.num_regions = vdev->num_regions;
-- 
1.8.2.1
