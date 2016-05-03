From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 3/7] ACPI / osi: Add acpi_osi=!! to allow reverting acpi_osi=!
Date: Tue,  3 May 2016 16:48:32 +0800
Message-ID: <9feb2e52793828de4931f16715b2ff872fe14274.1462263979.git.lv.zheng@intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com> <cover.1462263979.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462263979.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch introduces acpi_osi=!! so that quirks may use it to revert
acpi_osi=!.

Reported-and-tested-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/kernel-parameters.txt |    2 ++
 drivers/acpi/osl.c                  |    3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 0b3de80..c48f387 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -312,6 +312,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			acpi_osi=!*		# remove all strings
 			acpi_osi=!		# disable all built-in OS vendor
 						  strings
+			acpi_osi=!!		# enable all built-in OS vendor
+						  strings
 			acpi_osi=		# disable all strings
 
 			'acpi_osi=!' can be used in combination with single or
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index cd9667f..fbedea7 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1489,6 +1489,9 @@ void __init acpi_osi_setup(char *str)
 				osi->enable = false;
 			}
 			return;
+		} else if (*str == '!') {
+			osi_config.default_disabling = 0;
+			return;
 		}
 		enable = false;
 	}
-- 
1.7.10
