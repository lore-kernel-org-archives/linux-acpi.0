From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv2 5/5] ACPI / pcie: suppress compiler warning in portdrv_acpi.c
Date: Mon, 11 Mar 2013 11:17:08 +0200
Message-ID: <1362993428-14823-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56515 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab3CKJR3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Mar 2013 05:17:29 -0400
In-Reply-To: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org

This patch fixes following compiler warning when build via make W=3D1:

drivers/pci/pcie/portdrv_acpi.c:34:5: warning: no previous prototype fo=
r =E2=80=98pcie_port_acpi_setup=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pcie/portdrv_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv=
_acpi.c
index a86b56e..b4d2894 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -17,6 +17,7 @@
=20
 #include "aer/aerdrv.h"
 #include "../pci.h"
+#include "portdrv.h"
=20
 /**
  * pcie_port_acpi_setup - Request the BIOS to release control of PCIe =
services.
--=20
1.8.2.rc0.22.gb3600c3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
