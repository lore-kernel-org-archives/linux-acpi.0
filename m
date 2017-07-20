From: frowand.list@gmail.com
Subject: [PATCH 2/2] MAINTAINERS: device property: of: add fwnode.h
Date: Thu, 20 Jul 2017 12:13:25 -0700
Message-ID: <1500578005-25893-3-git-send-email-frowand.list@gmail.com>
References: <1500578005-25893-1-git-send-email-frowand.list@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500578005-25893-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Device tree is impacted by changes to fwnode.h, add a file entry
to OPEN FIRMWARE AND FLATTENED DEVICE TREE

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0ac362e850a..cb58c20b1ef8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9771,6 +9771,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 S:	Maintained
 F:	drivers/of/
 F:	include/linux/of*.h
+F:	include/linux/fwnode.h
 F:	scripts/dtc/
 F:	Documentation/ABI/testing/sysfs-firmware-ofw
 
-- 
Frank Rowand <frank.rowand@sony.com>
