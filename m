From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ACPICA: use designated initializers
Date: Fri, 16 Dec 2016 17:04:25 -0800
Message-ID: <20161217010425.GA140581@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

Prepare to mark sensitive kernel structures for randomization by making
sure they're using designated initializers. These were identified during
allyesconfig builds of x86, arm, and arm64, with most initializer fixes
extracted from grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/acpi/acpica/hwxfsleep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index f76e0eab32b8..25cd5c66e102 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -70,11 +70,12 @@ static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
 /* Legacy functions are optional, based upon ACPI_REDUCED_HARDWARE */
 
 static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
-	{ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
-	 acpi_hw_extended_sleep},
-	{ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
-	 acpi_hw_extended_wake_prep},
-	{ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake), acpi_hw_extended_wake}
+	{ .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
+	  .extended_function = acpi_hw_extended_sleep },
+	{ .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
+	  .extended_function = acpi_hw_extended_wake_prep },
+	{ .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake),
+	  .extended_function = acpi_hw_extended_wake }
 };
 
 /*
-- 
2.7.4


-- 
Kees Cook
Nexus Security
