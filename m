From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v7 8/8] PCC: Enable PCC only when needed
Date: Thu,  9 Jul 2015 14:04:24 -0400
Message-ID: <f88f374b4e09f23d5601a2081d1d3d9322e3caf5.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-acpi@vger.kernel.org

CPPC is the first client to make use of the PCC Mailbox channel. So
enable it only when CPPC is also enabled.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 84b0a2d..f2c30cc 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -45,7 +45,7 @@ config OMAP_MBOX_KFIFO_SIZE
 
 config PCC
 	bool "Platform Communication Channel Driver"
-	depends on ACPI
+	depends on ACPI && ACPI_CPPC_LIB
 	help
 	  ACPI 5.0+ spec defines a generic mode of communication
 	  between the OS and a platform such as the BMC. This medium
-- 
1.9.1

