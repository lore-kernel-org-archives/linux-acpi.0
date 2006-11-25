From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 17/21] ACPI: ibm-acpi: add support for the ultrabay on the T60,X60
Date: Sat, 25 Nov 2006 18:47:37 -0200
Message-ID: <20061125204737.6604.88351.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48018 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967194AbWKYUrj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 15:47:39 -0500
In-Reply-To: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This patch adds support for the ultrabay on the T60, X60 and other new
ThinkPads that have a SATA ultrabay.

I intend to keep bay and dock support in ibm-acpi working and updated until
it finally gets deprecated and removed in favour of the generic dock and
bay support.  But we aren't there yet.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

 drivers/acpi/ibm_acpi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index adf3dae..0151263 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -174,6 +174,7 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/*
 #endif
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
+	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */ 
 	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
     );				/* A21e, R30, R31 */
 
