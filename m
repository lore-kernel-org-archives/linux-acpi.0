From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 32/35] include/linux/acpi.h changes for SMBIOS and System
Date: Thu, 23 Jun 2011 13:25:29 -0400
Message-ID: <20110623172528.27778.11021.sendpatchset@prarit.bos.redhat.com>
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>
List-Id: linux-acpi@vger.kernel.org

include/linux/acpi.h changes for SMBIOS and System Firmware

As part of the new SMBIOS and System Firmware code:

- Replace old dmi* structures and functions with new sysfw* and smbios*
structures and functions in individual drivers

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 include/linux/acpi.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1deb2a7..29d7de8 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -217,7 +217,7 @@ static inline int acpi_video_display_switch_support(void)
 #endif /* defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE) */
 
 extern int acpi_blacklisted(void);
-extern void acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d);
+extern void acpi_smbios_osi_linux(int enable, const struct sysfw_id *d);
 extern void acpi_osi_setup(char *str);
 
 #ifdef CONFIG_ACPI_NUMA
-- 
1.7.5.4
