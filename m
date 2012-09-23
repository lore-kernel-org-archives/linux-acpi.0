From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/23] ACPICA: Add Windows8/Server2012 string for _OSI method.
Date: Sun, 23 Sep 2012 00:33:53 -0400
Message-ID: <a57f7f9175b8ccbc9df83ac13860488913115de4.1348371388.git.len.brown@intel.com>
References: <1348374851-20378-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348374851-20378-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1348371388.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1348371388.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Feng Tang <feng.tang@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This change adds a new _OSI string, "Windows 2012" for both Windows 8
and Windows Server 2012.

>From Microsoft document "How to Identify the Windows Version in ACPI
by Using _OSI", July 13, 2012.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h | 1 +
 drivers/acpi/acpica/utosi.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index cc80fe1..493529a 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -932,6 +932,7 @@ struct acpi_bit_register_info {
 #define ACPI_OSI_WIN_VISTA_SP1          0x09
 #define ACPI_OSI_WIN_VISTA_SP2          0x0A
 #define ACPI_OSI_WIN_7                  0x0B
+#define ACPI_OSI_WIN_8                  0x0C
 
 #define ACPI_ALWAYS_ILLEGAL             0x00
 
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 34ef0bd..676285d 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -73,6 +73,7 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Windows 2006 SP1", NULL, 0, ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
 	{"Windows 2006 SP2", NULL, 0, ACPI_OSI_WIN_VISTA_SP2},	/* Windows Vista SP2 - Added 09/2010 */
 	{"Windows 2009", NULL, 0, ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
+	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and Server 2012 - Added 08/2012 */
 
 	/* Feature Group Strings */
 
-- 
1.7.12.1.396.g16eed7c
