From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/18] ACPI: Add D3 cold state
Date: Sun, 29 May 2011 05:44:12 -0400
Message-ID: <28c2103dad04dba29ba86e22dad5735db8f0e13c.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:55530 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab1E2J5y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:57:54 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY0094DBOGA0E2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:57:54 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

=46rom: Lin Ming <ming.m.lin@intel.com>

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
Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.5.3.367.ga9930.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
