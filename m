From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V7 3/9] vfio: platform: determine reset capability
Date: Mon, 13 Jun 2016 00:26:35 -0400
Message-ID: <1465792001-27960-4-git-send-email-okaya@codeaurora.org>
References: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, eric.auger@linaro.org
Cc: Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Creating a new function to determine if this driver supports reset
function or not. This is an attempt to abstract device tree calls
from the rest of the code.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
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
