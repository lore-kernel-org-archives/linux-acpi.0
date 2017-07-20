From: frowand.list@gmail.com
Subject: [PATCH 1/2] MAINTAINERS: device property: acpi: add fwnode.h
Date: Thu, 20 Jul 2017 12:13:24 -0700
Message-ID: <1500578005-25893-2-git-send-email-frowand.list@gmail.com>
References: <1500578005-25893-1-git-send-email-frowand.list@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500578005-25893-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

ACPI is impacted by changes to fwnode.h, add a file entry
to ACPI

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 205d3977ac46..c0ac362e850a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -302,6 +302,7 @@ S:	Supported
 F:	drivers/acpi/
 F:	drivers/pnp/pnpacpi/
 F:	include/linux/acpi.h
+F:	include/linux/fwnode.h
 F:	include/acpi/
 F:	Documentation/acpi/
 F:	Documentation/ABI/testing/sysfs-bus-acpi
-- 
Frank Rowand <frank.rowand@sony.com>
