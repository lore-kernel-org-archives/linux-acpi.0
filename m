From: Frans Pop <elendil@planet.nl>
Subject: [PATCH] PCI PM: Consistently use variable name "error" for pm call return values
Date: Tue, 20 Jan 2009 23:01:44 +0100
Message-ID: <200901202301.46198.elendil@planet.nl>
References: <1232413680.3971.32.camel@yakui_zhao.sh.intel.com> <20090120074534.GE16426@elte.hu> <20090120074534.GE16426@elte.hu> <200901202132.04682.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml17.KPNXCHANGE.COM ([213.75.38.117]:4586 "EHLO
	hpsmtp-eml17.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753173AbZATWBu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jan 2009 17:01:50 -0500
In-reply-To: <200901202132.04682.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mingo@elte.hu, yakui.zhao@intel.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org

=46rom: Frans Pop <elendil@planet.nl>

PCI PM: Consistently use variable name "error" for pm call return value=
s
   =20
Signed-off-by: Frans Pop <elendil@planet.nl>
---
While looking at your patch

> Subject: PCI PM: Restore standard config registers of all devices ear=
ly
>
> There is a problem in our handling of suspend-resume of PCI devices
> that many of them have their standard config registers restored with
> interrupts enabled and they are put into the full power state with
> interrupts enabled as well. =A0This may lead to the following scenari=
o:
> [...]

I noticed two functions use a variable "i" to store the return value of=
 PM
function calls while the rest of the file uses "error". As "i" normally
indicates a counter of some sort it seems better to keep this consisten=
t.

I have no objection if you prefer to fold this patch into yours.
Compile tested.

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 9de07b7..6976669 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -352,15 +352,15 @@ static int pci_legacy_suspend(struct device *dev,=
 pm_message_t state)
 {
 	struct pci_dev * pci_dev =3D to_pci_dev(dev);
 	struct pci_driver * drv =3D pci_dev->driver;
-	int i =3D 0;
+	int error =3D 0;
=20
 	if (drv && drv->suspend) {
 		pci_dev->state_saved =3D false;
=20
-		i =3D drv->suspend(pci_dev, state);
-		suspend_report_result(drv->suspend, i);
-		if (i)
-			return i;
+		error =3D drv->suspend(pci_dev, state);
+		suspend_report_result(drv->suspend, error);
+		if (error)
+			return error;
=20
 		if (pci_dev->state_saved)
 			goto Fixup;
@@ -378,20 +378,20 @@ static int pci_legacy_suspend(struct device *dev,=
 pm_message_t state)
  Fixup:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
=20
-	return i;
+	return error;
 }
=20
 static int pci_legacy_suspend_late(struct device *dev, pm_message_t st=
ate)
 {
 	struct pci_dev * pci_dev =3D to_pci_dev(dev);
 	struct pci_driver * drv =3D pci_dev->driver;
-	int i =3D 0;
+	int error =3D 0;
=20
 	if (drv && drv->suspend_late) {
-		i =3D drv->suspend_late(pci_dev, state);
-		suspend_report_result(drv->suspend_late, i);
+		error =3D drv->suspend_late(pci_dev, state);
+		suspend_report_result(drv->suspend_late, error);
 	}
-	return i;
+	return error;
 }
=20
 static int pci_legacy_resume_early(struct device *dev)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
