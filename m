From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V7 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Date: Thu,  7 Dec 2017 16:10:24 -0500
Message-ID: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Introduce new ACPI and OF device ids for thw HW along with the helper
functions.

Changes from v6:
* add const to the device callback parameter in fwnode.
* reorganize the callbacks in the code
* rename get_match_data() as device_get_match_data()
* place pointer checks into acpi_get_match_data()

Sinan Kaya (7):
  Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
  ACPI / bus: Introduce acpi_get_match_data() function
  device property: Introduce a common API to fetch device match data
  OF: properties: Implement get_match_data() callback
  ACPI: properties: Implement get_match_data() callback
  dmaengine: qcom_hidma: Add support for the new revision
  dmaengine: qcom_hidma: Add identity register support

 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  4 +--
 drivers/acpi/bus.c                                 | 18 ++++++++++
 drivers/acpi/property.c                            |  8 +++++
 drivers/base/property.c                            |  7 ++++
 drivers/dma/qcom/hidma.c                           | 41 ++++++++++------------
 drivers/of/property.c                              |  8 +++++
 include/linux/acpi.h                               |  6 ++++
 include/linux/fwnode.h                             |  4 +++
 include/linux/property.h                           |  2 ++
 9 files changed, 74 insertions(+), 24 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
