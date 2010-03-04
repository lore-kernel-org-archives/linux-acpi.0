From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 3/4] ipmi: Convert tracking of the ACPI device pointer to a
	PNP device
Date: Wed, 03 Mar 2010 20:44:20 -0700
Message-ID: <20100304034420.30205.7749.stgit@bob.kio>
References: <20100304033146.30205.68689.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:20162 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab0CDDoV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 22:44:21 -0500
In-Reply-To: <20100304033146.30205.68689.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

Convert PNP patch (git 9e368fa011d4e0aa050db348d69514900520e40b) to
maintain a pointer to a PNP device, 'pnp_dev', instead of the ACPI
device, 'acpi_dev', that is currently being tracked with PNP based
IPMI device discovery.

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
---

 drivers/char/ipmi/ipmi_si_intf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 806ae83..37c6912 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1934,7 +1934,7 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 		info->irq_setup = std_irq_setup;
 	}
 
-	info->dev = &acpi_dev->dev;
+	info->dev = &dev->dev;
 	pnp_set_drvdata(dev, info);
 
 	return try_smi_init(info);

