From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] ACPI / Wakeup: Enable button GPEs unconditionally during initialization
Date: Sun, 6 Feb 2011 14:20:17 +0100
Message-ID: <201102061420.17431.rjw@sisk.pl>
References: <201102061418.56202.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47712 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab1BFNVq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Feb 2011 08:21:46 -0500
In-Reply-To: <201102061418.56202.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Ferenc =?utf-8?q?W=C3=A1gner?= <wferi@niif.hu>

=46rom: Rafael J. Wysocki <rjw@sisk.pl>

Commit 9630bdd (ACPI: Use GPE reference counting to support shared
GPEs) introduced a suspend regression where boxes resume immediately
after being suspended due to the lid or sleep button wakeup status
not being cleared properly.  This happens if the GPEs corresponding
to those devices are not enabled all the time, which apparently is
expected by some BIOSes.

To fix this problem, enable button and lid GPEs unconditionally
during initialization and keep them enabled all the time, regardless
of whether or not the ACPI button driver is used.

References: https://bugzilla.kernel.org/show_bug.cgi?id=3D27372
Reported-and-tested-by: Ferenc W=C3=A1gner <wferi@niif.hu>
Cc: stable@kernel.org
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/button.c |   13 -------------
 drivers/acpi/wakeup.c |    6 +++++-
 2 files changed, 5 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/acpi/wakeup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/wakeup.c
+++ linux-2.6/drivers/acpi/wakeup.c
@@ -86,8 +86,12 @@ int __init acpi_wakeup_device_init(void)
 		struct acpi_device *dev =3D container_of(node,
 						       struct acpi_device,
 						       wakeup_list);
-		if (device_can_wakeup(&dev->dev))
+		if (device_can_wakeup(&dev->dev)) {
+			/* Button GPEs are supposed to be always enabled. */
+			acpi_enable_gpe(dev->wakeup.gpe_device,
+					dev->wakeup.gpe_number);
 			device_set_wakeup_enable(&dev->dev, true);
+		}
 	}
 	mutex_unlock(&acpi_device_lock);
 	return 0;

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
