From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 38/52] ACPI / utils: Drop reference in test for device presence
Date: Fri, 29 Mar 2019 20:52:45 -0400
Message-ID: <20190330005301.26868-38-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 54e3aca84e571559915998aa6cc05e5ac37c043b ]

When commit 8661423eea1a ("ACPI / utils: Add new acpi_dev_present
helper") introduced acpi_dev_present(), it missed the fact that
bus_find_device() took a reference on the device found by it and
the callers of acpi_dev_present() don't drop that reference.

Drop the reference on the device in acpi_dev_present().

Fixes: 8661423eea1a ("ACPI / utils: Add new acpi_dev_present helper")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 78db97687f26..c4b06cc075f9 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -800,6 +800,7 @@ bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 	match.hrv = hrv;
 
 	dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
+	put_device(dev);
 	return !!dev;
 }
 EXPORT_SYMBOL(acpi_dev_present);
-- 
2.19.1
