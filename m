From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 7/7] Documentation: Add new /sys/kernel/debug/ec/* files to ABI
Date: Fri, 16 Jul 2010 13:11:37 +0200
Message-ID: <1279278697-3694-8-git-send-email-trenn@suse.de>
References: <1279278697-3694-1-git-send-email-trenn@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279278697-3694-1-git-send-email-trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Thomas Renninger <trenn@suse.de>

CC: Alexey Starikovskiy <astarikovskiy@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-kernel@vger.kernel.org
CC: linux-acpi@vger.kernel.org
CC: platform-driver-x86@vger.kernel.org
---
 Documentation/ABI/testing/debugfs-ec |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-ec

diff --git a/Documentation/ABI/testing/debugfs-ec b/Documentation/ABI/testing/debugfs-ec
new file mode 100644
index 0000000..6546115
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-ec
@@ -0,0 +1,20 @@
+What:		/sys/kernel/debug/ec/*/{gpe,use_global_lock,io}
+Date:		July 2010
+Contact:	Thomas Renninger <trenn@suse.de>
+Description:
+
+General information like which GPE is assigned to the EC and whether
+the global lock should get used.
+Knowing the EC GPE one can watch the amount of HW events related to
+the EC here (XY -> GPE number from /sys/kernel/debug/ec/*/gpe):
+/sys/firmware/acpi/interrupts/gpeXY
+
+The io file is binary and a userspace tool located here:
+ftp://ftp.suse.com/pub/people/trenn/sources/ec/
+should get used to read out the 256 Embedded Controller registers
+or writing to them.
+
+CAUTION: Do not write to the Embedded Controller if you don't know
+what you are doing! Rebooting afterwards also is a good idea.
+This can influence the way your machine is cooled and fans may
+not get switched on again after you did a wrong write.
-- 
1.6.3
