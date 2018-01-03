From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 09/12] ACPICA: Recognize the Windows 10 version 1607 and 1703 OSI strings
Date: Wed,  3 Jan 2018 15:06:28 -0800
Message-ID: <20180103230631.15939-10-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20180103230631.15939-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43377 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751259AbeACXHn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:43 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@dell.com>, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Mario Limonciello <mario.limonciello@dell.com>

ACPICA commit 35a4a3ea723b3066f575e63e5f0116f7ce65e713

The public Microsoft document listing recognized OSI strings [1]
shows that these two strings were introduced.
version 1607 / Anniversary Update / "Redstone 1"
version 1703 / Creators Update / "Redstone 2"

[1] http://download.microsoft.com/download/7/e/7/7e7662cf-cbea-470b-a97e-ce7ce0d98dc2/winacpi_osi.docx

Link: https://github.com/acpica/acpica/commit/35a4a3ea
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/utosi.c | 2 ++
 include/acpi/actypes.h      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 3175b133c0e4..f6b8dd24b006 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -101,6 +101,8 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and Server 2012 - Added 08/2012 */
 	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and Server 2012 R2 - Added 01/2014 */
 	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10 - Added 03/2015 */
+	{"Windows 2016", NULL, 0, ACPI_OSI_WIN_10_RS1},	/* Windows 10 version 1607 - Added 12/2017 */
+	{"Windows 2017", NULL, 0, ACPI_OSI_WIN_10_RS2},	/* Windows 10 version 1703 - Added 12/2017 */
 
 	/* Feature Group Strings */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index ddde2790a54a..31f1be74dd16 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1301,6 +1301,8 @@ typedef enum {
 #define ACPI_OSI_WIN_7                  0x0B
 #define ACPI_OSI_WIN_8                  0x0C
 #define ACPI_OSI_WIN_10                 0x0D
+#define ACPI_OSI_WIN_10_RS1             0x0E
+#define ACPI_OSI_WIN_10_RS2             0x0F
 
 /* Definitions of getopt */
 
-- 
2.14.3

