From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V9 9/9] vfio: platform: check reset call return code during release
Date: Wed, 13 Jul 2016 22:06:35 -0400
Message-ID: <1468461995-32676-10-git-send-email-okaya@codeaurora.org>
References: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53414 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbcGNCHC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2016 22:07:02 -0400
In-Reply-To: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-kernel@vger.kernel.org

Release call is ignoring the return code from reset call and can
potentially continue even though reset call failed.

If reset_required module parameter is set, this patch is going
to validate the return code and will cause stack dump with
WARN_ON and warn the user of failure.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 drivers/vfio/platform/vfio_platform_common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 1898ff6..65e53c7 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -238,7 +238,15 @@ static void vfio_platform_release(void *device_data)
 	mutex_lock(&driver_lock);
 
 	if (!(--vdev->refcnt)) {
-		vfio_platform_call_reset(vdev, NULL);
+		const char *extra_dbg = NULL;
+		int ret;
+
+		ret = vfio_platform_call_reset(vdev, &extra_dbg);
+		if (ret && vdev->reset_required) {
+			dev_warn(vdev->device, "reset driver is required and reset call failed in release (%d) %s\n",
+				 ret, extra_dbg ? extra_dbg : "");
+			WARN_ON(1);
+		}
 		vfio_platform_regions_cleanup(vdev);
 		vfio_platform_irq_cleanup(vdev);
 	}
-- 
1.8.2.1

