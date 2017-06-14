From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/3] ACPI: EC: Fix EC command visibility for dynamic debug
Date: Wed, 14 Jun 2017 13:59:18 +0800
Message-ID: <c283b9157c1d602631d723b35925dc1c6bf42752.1497418749.git.lv.zheng@intel.com>
References: <d8ac96c8fd988daec20f7a22a2acb3119ccd149b.1497418749.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d8ac96c8fd988daec20f7a22a2acb3119ccd149b.1497418749.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

acpi_ec_cmd_string() currently is only enabled for "DEBUG" macro, but users
trend to use CONFIG_DYNAMIC_DEBUG and enable ec.c pr_debug() print-outs by
"dyndbg='file ec.c +p'". In this use case, all command names are turned
into UNDEF and the log is confusing. This affects bugzilla triage work.

This patch fixes this issue by enabling acpi_ec_cmd_string() for
CONFIG_DYNAMIC_DEBUG.

Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: Feng Chenzhou <chenzhoux.feng@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 30d7f82..f3ff591 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -316,7 +316,7 @@ static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 	ec->timestamp = jiffies;
 }
 
-#ifdef DEBUG
+#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
 static const char *acpi_ec_cmd_string(u8 cmd)
 {
 	switch (cmd) {
-- 
2.7.4
