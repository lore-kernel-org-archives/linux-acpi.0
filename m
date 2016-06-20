From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V8 5/9] vfio: platform: add extra debug info argument to call reset
Date: Mon, 20 Jun 2016 11:51:15 -0400
Message-ID: <1466437879-32182-6-git-send-email-okaya@codeaurora.org>
References: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35224 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbcFTPvp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2016 11:51:45 -0400
In-Reply-To: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-kernel@vger.kernel.org

Getting ready to bring out extra debug information to the caller
so that more verbose information can be printed when an error is
observed.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 drivers/vfio/platform/vfio_platform_common.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index fbf4565..e7ce2c2 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -171,7 +171,8 @@ static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
 	kfree(vdev->regions);
 }
 
-static int vfio_platform_call_reset(struct vfio_platform_device *vdev)
+static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
+				    const char **extra_dbg)
 {
 	if (vdev->of_reset) {
 		dev_info(vdev->device, "reset\n");
@@ -189,7 +190,7 @@ static void vfio_platform_release(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!(--vdev->refcnt)) {
-		vfio_platform_call_reset(vdev);
+		vfio_platform_call_reset(vdev, NULL);
 		vfio_platform_regions_cleanup(vdev);
 		vfio_platform_irq_cleanup(vdev);
 	}
@@ -218,7 +219,7 @@ static int vfio_platform_open(void *device_data)
 		if (ret)
 			goto err_irq;
 
-		vfio_platform_call_reset(vdev);
+		vfio_platform_call_reset(vdev, NULL);
 	}
 
 	vdev->refcnt++;
@@ -350,7 +351,7 @@ static long vfio_platform_ioctl(void *device_data,
 		return ret;
 
 	} else if (cmd == VFIO_DEVICE_RESET) {
-		return vfio_platform_call_reset(vdev);
+		return vfio_platform_call_reset(vdev, NULL);
 	}
 
 	return -ENOTTY;
-- 
1.8.2.1

