From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2] tools/power/acpi: Add .gitignore file
Date: Fri,  3 Mar 2017 09:44:11 -0500
Message-ID: <1488552251-20573-1-git-send-email-prarit@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbdCCOoT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Mar 2017 09:44:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, devel@acpica.org

v2: added sign off .. oops.  Sorry about that.

P.

---8<---

Add a .gitignore file so that git commands do not pick up the resulting
binaries and directories.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
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

