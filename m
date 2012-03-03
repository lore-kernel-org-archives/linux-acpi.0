From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH v2] ACPI, APEI, EINJ, limit the range of einj_param
Date: Sat,  3 Mar 2012 11:56:43 +0800
Message-ID: <1330747003-11891-1-git-send-email-gong.chen@linux.intel.com>
References: <4F506E8A.8010901@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46362 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab2CCD4C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Mar 2012 22:56:02 -0500
In-Reply-To: <4F506E8A.8010901@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

On the platforms with ACPI4.x support, parameter extension
is not always doable, which means only parameter extension
is enabled, einj_param can take effect.

v2->v1: stopping early in einj_get_parameter_address for einj_param

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/einj.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 4ca087d..3d3816f 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -238,7 +238,7 @@ static void *einj_get_parameter_address(void)
 			return v5param;
 		}
 	}
-	if (paddrv4) {
+	if (param_extension && paddrv4) {
 		struct einj_parameter *v4param;
 
 		v4param = acpi_os_map_memory(paddrv4, sizeof(*v4param));
-- 
1.7.8.2.302.g17b4e

