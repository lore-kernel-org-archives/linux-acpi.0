From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/3] ACPICA: ACPICA: Fix for _INI regression
Date: Wed,  8 May 2013 12:02:06 +0800
Message-ID: <0899b998dcffc1d000e6374ec7666784e2787404.1367912853.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367912853.git.lv.zheng@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <cover.1367912853.git.lv.zheng@intel.com>
Sender: stable-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, stable@vger.kernel.org, linux-acpi@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

This change fixes a problem introduced in 20130328 where _INI
methods are no longer executed properly because of a memory block
that is not initialized properly.  ACPICA BZ1016. Tomasz Nowicki
<tomasz.nowicki@linaro.org>

Buglink: https://bugs.acpica.org/show_bug.cgi?id=1016
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/acpi/acpica/nsinit.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 2a431ec..46f0f83 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -558,6 +558,7 @@ acpi_ns_init_one_device(acpi_handle obj_handle,
 	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
 			(ACPI_TYPE_METHOD, device_node, METHOD_NAME__INI));
 
+	ACPI_MEMSET(info, 0, sizeof(struct acpi_evaluate_info));
 	info->prefix_node = device_node;
 	info->pathname = METHOD_NAME__INI;
 	info->parameters = NULL;
-- 
1.7.10
