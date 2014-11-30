From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/1] ACPI: Deletion of an unnecessary check before the function
 call "pci_dev_put"
Date: Sun, 30 Nov 2014 11:08:36 +0100
Message-ID: <547AECA4.3050800@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:56159 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbaK3KIx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Nov 2014 05:08:53 -0500
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 30 Nov 2014 10:59:10 +0100

The pci_dev_put() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/ioapic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index 9a631a6..35963d3 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -185,8 +185,7 @@ exit_disable:
 	if (dev)
 		pci_disable_device(dev);
 exit_put:
-	if (dev)
-		pci_dev_put(dev);
+	pci_dev_put(dev);
 exit_free:
 	kfree(ioapic);
 exit:
-- 
2.1.3

