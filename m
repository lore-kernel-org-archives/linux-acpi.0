From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PCI / PM: Fix device PM regression related to D3hot/D3cold
Date: Wed, 16 May 2012 22:15:21 +0200
Message-ID: <201205162215.21429.rjw@sisk.pl>
References: <5165867.6kdtKH1k0B@penguin> <201205151928.36026.rjw@sisk.pl> <201205161224.26007.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:48824 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760596Ab2EPUKZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 May 2012 16:10:25 -0400
In-Reply-To: <201205161224.26007.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lekensteyn <lekensteyn@gmail.com>
Cc: rockorequin@hotmail.com, Cristian =?iso-8859-1?q?Rodr=EDguez?= <crrodriguez@opensuse.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

=46rom: Rafael J. Wysocki <rjw@sisk.pl>

Commit 1cc0c998fdf2cb665d625fb565a0d6db5c81c639 (ACPI: Fix D3hot
v D3cold confusion) introduced a bug in __acpi_bus_set_power() and
changed the behavior of acpi_pci_set_power_state() in such a way that
it generally doesn't work as expected if PCI_D3hot is passed to it
as the second argument.

=46irst off, if ACPI_STATE_D3 (equal to ACPI_STATE_D3_COLD) is passed
to __acpi_bus_set_power() and the explicit_set flag is set for the
D3cold state, the function will try to execute AML method called
"_PS4", which doesn't exist.

=46ix this by adding a check to ensure that the name of the AML method
to execute for transitions to ACPI_STATE_D3_COLD is correct in
__acpi_bus_set_power().

Second, if PCI_D3hot is passed to acpi_pci_set_power_state() as the
target state, the function will request a transition to
ACPI_STATE_D3_HOT instead of ACPI_STATE_D3.  However,
ACPI_STATE_D3_HOT is now only marked as supported if the _PR3 AML
method is defined for the given device, which is rare.  This causes
problems to happen on systems where devices were successfully put
into ACPI D3 by pci_set_power_state(PCI_D3hot) which doesn't work
now.  In particular, some unused graphics adapters are not turned
off as a result.

To fix this issue restore the old behavior of
acpi_pci_set_power_state(), which is to request a transition to
ACPI_STATE_D3 (equal to ACPI_STATE_D3_COLD) if either PCI_D3hot or
PCI_D3cold is passed to it as the argument.

This approach is not ideal, because generally power should not
be removed from devices if PCI_D3hot is the target power state,
but since this behavior is relied on, we have no choice but to
restore it at the moment and spend more time on designing a
better solution in the future.

References: https://bugzilla.kernel.org/show_bug.cgi?id=3D43228
Reported-by: rocko <rockorequin@hotmail.com>
Reported-by: Lekensteyn <lekensteyn@gmail.com>
Reported-by: Cristian Rodr=EDguez <crrodriguez@opensuse.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Hi all,

The previous patch was incomplete, so please test this one instead.

Thanks,
Rafael

---
 drivers/acpi/bus.c     |    4 ++++
 drivers/pci/pci-acpi.c |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

Index: linux/drivers/pci/pci-acpi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/pci/pci-acpi.c
+++ linux/drivers/pci/pci-acpi.c
@@ -223,7 +223,7 @@ static int acpi_pci_set_power_state(stru
 		[PCI_D0] =3D ACPI_STATE_D0,
 		[PCI_D1] =3D ACPI_STATE_D1,
 		[PCI_D2] =3D ACPI_STATE_D2,
-		[PCI_D3hot] =3D ACPI_STATE_D3_HOT,
+		[PCI_D3hot] =3D ACPI_STATE_D3,
 		[PCI_D3cold] =3D ACPI_STATE_D3
 	};
 	int error =3D -EINVAL;
Index: linux/drivers/acpi/bus.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/bus.c
+++ linux/drivers/acpi/bus.c
@@ -250,6 +250,10 @@ static int __acpi_bus_set_power(struct a
 		return -ENODEV;
 	}
=20
+	/* _PS3 should be executed for transitions into D3cold. */
+	if (state =3D=3D ACPI_STATE_D3_COLD)
+		object_name[3] =3D '3';
+
 	/*
 	 * Transition Power
 	 * ----------------
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
