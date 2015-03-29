From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 13/86] acpi/video: use uapi/linux/pci_ids.h directly
Date: Sun, 29 Mar 2015 15:38:38 +0200
Message-ID: <1427635734-24786-14-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/acpi/video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 26eb70c..e7c7e0a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -35,7 +35,7 @@
 #include <linux/thermal.h>
 #include <linux/sort.h>
 #include <linux/pci.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
-- 
MST
