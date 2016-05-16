From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V5 1/6] vfio: platform: rename reset function
Date: Sun, 15 May 2016 22:13:34 -0400
Message-ID: <1463364819-477-2-git-send-email-okaya@codeaurora.org>
References: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@linaro.org
Cc: Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Renaming the reset function to of_reset as it is only used
by the device tree based platforms.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/vfio/platform/vfio_platform_common.c  | 30 +++++++++++++--------------
 drivers/vfio/platform/vfio_platform_private.h |  6 +++---
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index e65b142..08fd7c2 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -41,7 +41,7 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
 		if (!strcmp(iter->compat, compat) &&
 			try_module_get(iter->owner)) {
 			*module = iter->owner;
-			reset_fn = iter->reset;
+			reset_fn = iter->of_reset;
 			break;
 		}
 	}
@@ -51,18 +51,18 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
 
 static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
 {
-	vdev->reset = vfio_platform_lookup_reset(vdev->compat,
-						&vdev->reset_module);
-	if (!vdev->reset) {
+	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
+						    &vdev->reset_module);
+	if (!vdev->of_reset) {
 		request_module("vfio-reset:%s", vdev->compat);
-		vdev->reset = vfio_platform_lookup_reset(vdev->compat,
-							 &vdev->reset_module);
+		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
+							&vdev->reset_module);
 	}
 }
 
 static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
 {
-	if (vdev->reset)
+	if (vdev->of_reset)
 		module_put(vdev->reset_module);
 }
 
@@ -141,9 +141,9 @@ static void vfio_platform_release(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!(--vdev->refcnt)) {
-		if (vdev->reset) {
+		if (vdev->of_reset) {
 			dev_info(vdev->device, "reset\n");
-			vdev->reset(vdev);
+			vdev->of_reset(vdev);
 		} else {
 			dev_warn(vdev->device, "no reset function found!\n");
 		}
@@ -175,9 +175,9 @@ static int vfio_platform_open(void *device_data)
 		if (ret)
 			goto err_irq;
 
-		if (vdev->reset) {
+		if (vdev->of_reset) {
 			dev_info(vdev->device, "reset\n");
-			vdev->reset(vdev);
+			vdev->of_reset(vdev);
 		} else {
 			dev_warn(vdev->device, "no reset function found!\n");
 		}
@@ -213,7 +213,7 @@ static long vfio_platform_ioctl(void *device_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		if (vdev->reset)
+		if (vdev->of_reset)
 			vdev->flags |= VFIO_DEVICE_FLAGS_RESET;
 		info.flags = vdev->flags;
 		info.num_regions = vdev->num_regions;
@@ -312,8 +312,8 @@ static long vfio_platform_ioctl(void *device_data,
 		return ret;
 
 	} else if (cmd == VFIO_DEVICE_RESET) {
-		if (vdev->reset)
-			return vdev->reset(vdev);
+		if (vdev->of_reset)
+			return vdev->of_reset(vdev);
 		else
 			return -EINVAL;
 	}
@@ -611,7 +611,7 @@ void vfio_platform_unregister_reset(const char *compat,
 
 	mutex_lock(&driver_lock);
 	list_for_each_entry_safe(iter, temp, &reset_list, link) {
-		if (!strcmp(iter->compat, compat) && (iter->reset == fn)) {
+		if (!strcmp(iter->compat, compat) && (iter->of_reset == fn)) {
 			list_del(&iter->link);
 			break;
 		}
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 42816dd..71ed7d1 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -71,7 +71,7 @@ struct vfio_platform_device {
 	struct resource*
 		(*get_resource)(struct vfio_platform_device *vdev, int i);
 	int	(*get_irq)(struct vfio_platform_device *vdev, int i);
-	int	(*reset)(struct vfio_platform_device *vdev);
+	int	(*of_reset)(struct vfio_platform_device *vdev);
 };
 
 typedef int (*vfio_platform_reset_fn_t)(struct vfio_platform_device *vdev);
@@ -80,7 +80,7 @@ struct vfio_platform_reset_node {
 	struct list_head link;
 	char *compat;
 	struct module *owner;
-	vfio_platform_reset_fn_t reset;
+	vfio_platform_reset_fn_t of_reset;
 };
 
 extern int vfio_platform_probe_common(struct vfio_platform_device *vdev,
@@ -103,7 +103,7 @@ extern void vfio_platform_unregister_reset(const char *compat,
 static struct vfio_platform_reset_node __reset ## _node = {	\
 	.owner = THIS_MODULE,					\
 	.compat = __compat,					\
-	.reset = __reset,					\
+	.of_reset = __reset,					\
 };								\
 __vfio_platform_register_reset(&__reset ## _node)
 
-- 
1.8.2.1
