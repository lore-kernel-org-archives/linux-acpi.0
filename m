From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 07/11] drivers: acpi: Include appropriate header file in
 pci_link.c
Date: Tue, 17 Dec 2013 14:58:31 +0530
Message-ID: <a8a439a6a00b03ab0df484dc157155034126736b.1387271324.git.rashika.kheria@gmail.com>
References: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, josh@joshtriplett.org
List-Id: linux-acpi@vger.kernel.org

Includes appropriate header file internal.h in pci_link.c
because function acpi_pci_link_init() has its prototype declaration in
internal.h.

This eliminates the following warning in pci_link.c:
drivers/acpi/pci_link.c:874:13: warning: no previous prototype for =E2=80=
=98acpi_pci_link_init=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/pci_link.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 2652a61..447c329 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -42,6 +42,7 @@
=20
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include "internal.h"
=20
 #define PREFIX "ACPI: "
=20
--=20
1.7.9.5
