From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 01/21] ACPI: ibm-acpi: do not use / in driver names
Date: Sat, 25 Nov 2006 18:42:16 -0200
Message-ID: <20061125204216.6604.44912.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:941 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967176AbWKYUmN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 15:42:13 -0500
In-Reply-To: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

ibm-acpi uses sub-device names like ibm/hotkey, which get in the way of
a sysfs conversion.  Fix it to use ibm_hotkey instead.  Thanks to Zhang
Rui for noticing this.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

 drivers/acpi/ibm_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 9658253..9baae34 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1854,7 +1854,7 @@ static int __init register_driver(struct
 	}
 
 	memset(ibm->driver, 0, sizeof(struct acpi_driver));
-	sprintf(ibm->driver->name, "%s/%s", IBM_NAME, ibm->name);
+	sprintf(ibm->driver->name, "%s_%s", IBM_NAME, ibm->name);
 	ibm->driver->ids = ibm->hid;
 	ibm->driver->ops.add = &ibm_device_add;
 
