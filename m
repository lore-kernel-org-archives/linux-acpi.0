From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 6/7] X86 platform driver: Fix section mismatch in wmi.c
Date: Fri, 16 Jul 2010 13:11:36 +0200
Message-ID: <1279278697-3694-7-git-send-email-trenn@suse.de>
References: <1279278697-3694-1-git-send-email-trenn@suse.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1279278697-3694-1-git-send-email-trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-acpi@vger.kernel.org

The .add function must not be declared __init.

Signed-off-by: Thomas Renninger <trenn@suse.de>

CC: Alexey Starikovskiy <astarikovskiy@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-kernel@vger.kernel.org
CC: linux-acpi@vger.kernel.org
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/wmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index e4eaa14..635ebb4 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -804,7 +804,7 @@ static bool guid_already_parsed(const char *guid_string)
 /*
  * Parse the _WDG method for the GUID data blocks
  */
-static __init acpi_status parse_wdg(acpi_handle handle)
+static acpi_status parse_wdg(acpi_handle handle)
 {
 	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *obj;
@@ -947,7 +947,7 @@ static int acpi_wmi_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
-static int __init acpi_wmi_add(struct acpi_device *device)
+static int acpi_wmi_add(struct acpi_device *device)
 {
 	acpi_status status;
 	int result = 0;
-- 
1.6.3
