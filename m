From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 04/11] drivers: acpi: Include appropriate header file in
 pci_slot.c
Date: Tue, 17 Dec 2013 14:48:19 +0530
Message-ID: <0faeccd0213ce9c34a9a3776d3fcc9275348ddf0.1387271324.git.rashika.kheria@gmail.com>
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

Includes appropriate header file linux/pci-acpi.h in pci_slot.c
because functions acpi_pci_slot_enumerate(), acpi_pci_slot_remove()
and acpi_pci_slot_init() have their prototype declaratons in
linux/pci-acpi.h.

This eliminates the following warnings in pci_slot.c:
drivers/acpi/pci_slot.c:162:6: warning: no previous prototype for =E2=80=
=98acpi_pci_slot_enumerate=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/pci_slot.c:174:6: warning: no previous prototype for =E2=80=
=98acpi_pci_slot_remove=E2=80=99 [-Wmissing-prototypes]
drivers/acpi/pci_slot.c:215:13: warning: no previous prototype for =E2=80=
=98acpi_pci_slot_init=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/pci_slot.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index d678a18..139d9e4 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -35,6 +35,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/pci-acpi.h>
=20
 static bool debug;
 static int check_sta_before_sun;
--=20
1.7.9.5
