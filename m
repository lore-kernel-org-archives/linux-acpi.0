From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V11 2/9] vfio: platform: move reset call to a common function
Date: Tue, 19 Jul 2016 09:01:42 -0400
Message-ID: <1468933309-19735-3-git-send-email-okaya@codeaurora.org>
References: <1468933309-19735-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468933309-19735-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com
Cc: Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

The reset call sequence seems to replicate itself multiple times
across the file. Grouping them together for maintenance reasons.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
Reviewed-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 drivers/vfio/platform/vfio_platform_common.c | 30 +++++++++++++---------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 08fd7c2..3e2a7c0 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -134,6 +134,17 @@ static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
 	kfree(vdev->regions);
 }
 
+static int vfio_platform_call_reset(struct vfio_platform_device *vdev)
+{
+	if (vdev->of_reset) {
+		dev_info(vdev->device, "reset\n");
+		return vdev->of_reset(vdev);
+	}
+
+	dev_warn(vdev->device, "no reset function found!\n");
+	return -EINVAL;
+}
+
 static void vfio_platform_release(void *device_data)
 {
 	struct vfio_platform_device *vdev = device_data;
@@ -141,12 +152,7 @@ static void vfio_platform_release(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!(--vdev->refcnt)) {
-		if (vdev->of_reset) {
-			dev_info(vdev->device, "reset\n");
-			vdev->of_reset(vdev);
-		} else {
-			dev_warn(vdev->device, "no reset function found!\n");
-		}
+		vfio_platform_call_reset(vdev);
 		vfio_platform_regions_cleanup(vdev);
 		vfio_platform_irq_cleanup(vdev);
 	}
@@ -175,12 +181,7 @@ static int vfio_platform_open(void *device_data)
 		if (ret)
 			goto err_irq;
 
-		if (vdev->of_reset) {
-			dev_info(vdev->device, "reset\n");
-			vdev->of_reset(vdev);
-		} else {
-			dev_warn(vdev->device, "no reset function found!\n");
-		}
+		vfio_platform_call_reset(vdev);
 	}
 
 	vdev->refcnt++;
@@ -312,10 +313,7 @@ static long vfio_platform_ioctl(void *device_data,
 		return ret;
 
 	} else if (cmd == VFIO_DEVICE_RESET) {
-		if (vdev->of_reset)
-			return vdev->of_reset(vdev);
-		else
-			return -EINVAL;
+		return vfio_platform_call_reset(vdev);
 	}
 
 	return -ENOTTY;
-- 
1.8.2.1
