From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] acpi: Add D3 cold state
Date: Wed, 04 May 2011 22:56:43 +0800
Message-ID: <1304521003.2624.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41040 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167Ab1EDO4n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 May 2011 10:56:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

_SxW returns an Integer containing the lowest D-state supported in stat=
e
Sx. If OSPM has not indicated that it supports _PR3, then the value =E2=
=80=9C3=E2=80=9D
corresponds to D3.  If it has indicated _PR3 support, the value =E2=80=9C=
3=E2=80=9D
represents D3hot and the value =E2=80=9C4=E2=80=9D represents D3cold.

Linux does set _OSC._PR3, so we should fix it to expect that _SxW can
return 4.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/bus.c     |    2 +-
 drivers/pci/pci-acpi.c |    2 ++
 include/acpi/actypes.h |    5 +++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9749980..d1e06c1 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -227,7 +227,7 @@ static int __acpi_bus_set_power(struct acpi_device =
*device, int state)
 	acpi_status status =3D AE_OK;
 	char object_name[5] =3D { '_', 'P', 'S', '0' + state, '\0' };
=20
-	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
+	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD=
))
 		return -EINVAL;
=20
 	/* Make sure this is a valid target state */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7c3b18e..d36f41e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -195,6 +195,8 @@ static pci_power_t acpi_pci_choose_state(struct pci=
_dev *pdev)
 		return PCI_D2;
 	case ACPI_STATE_D3:
 		return PCI_D3hot;
+	case ACPI_STATE_D3_COLD:
+		return PCI_D3cold;
 	}
 	return PCI_POWER_ERROR;
 }
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 64f838b..f72cbe5 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -501,8 +501,9 @@ typedef u64 acpi_integer;
 #define ACPI_STATE_D1                   (u8) 1
 #define ACPI_STATE_D2                   (u8) 2
 #define ACPI_STATE_D3                   (u8) 3
-#define ACPI_D_STATES_MAX               ACPI_STATE_D3
-#define ACPI_D_STATE_COUNT              4
+#define ACPI_STATE_D3_COLD              (u8) 4
+#define ACPI_D_STATES_MAX               ACPI_STATE_D3_COLD
+#define ACPI_D_STATE_COUNT              5
=20
 #define ACPI_STATE_C0                   (u8) 0
 #define ACPI_STATE_C1                   (u8) 1
--=20
1.7.4.4



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
