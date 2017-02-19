From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] tools/power/acpi: Add .gitignore file
Date: Sun, 19 Feb 2017 16:57:53 -0500
Message-ID: <1487541473-21479-1-git-send-email-prarit@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbdBSV6D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 19 Feb 2017 16:58:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, devel@acpica.org

Add a .gitignore file so that git commands do not pick up the resulting
binaries and directories.

Cc: Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: devel@acpica.org
---
 tools/power/acpi/.gitignore |    4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/power/acpi/.gitignore

diff --git a/tools/power/acpi/.gitignore b/tools/power/acpi/.gitignore
new file mode 100644
index 000000000000..cba3d994995c
--- /dev/null
+++ b/tools/power/acpi/.gitignore
@@ -0,0 +1,4 @@
+acpidbg
+acpidump
+ec
+include
-- 
1.7.9.3

