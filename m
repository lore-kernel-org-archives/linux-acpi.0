From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/30] ACPICA: Cleanup some invocation indentations, no functional change
Date: Thu, 24 Mar 2016 09:40:12 +0800
Message-ID: <4b6853af6fbfe928d9e292713b83030669dfb8a9.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 9ed98dc36645aaeba11967722951156650d94f47

For consistency, cleanup function invocations.

Link: https://github.com/acpica/acpica/commit/9ed98dc3
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsprepkg.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 9047f28..fde5a09 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -179,6 +179,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
+
 			elements++;
 		}
 		break;
@@ -225,6 +226,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 					return (status);
 				}
 			}
+
 			elements++;
 		}
 		break;
@@ -569,11 +571,13 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 			if (sub_package->package.count < expected_count) {
 				goto package_too_small;
 			}
+
 			if (sub_package->package.count <
 			    package->ret_info.count1) {
 				expected_count = package->ret_info.count1;
 				goto package_too_small;
 			}
+
 			if (expected_count == 0) {
 				/*
 				 * Either the num_entries element was originally zero or it was
@@ -661,6 +665,7 @@ acpi_ns_check_package_elements(struct acpi_evaluate_info *info,
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
+
 		this_element++;
 	}
 
@@ -671,6 +676,7 @@ acpi_ns_check_package_elements(struct acpi_evaluate_info *info,
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
+
 		this_element++;
 	}
 
-- 
1.7.10
