From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: fix regression on D3hot detection
Date: Wed, 16 May 2012 12:24:25 +0200
Message-ID: <201205161224.26007.rjw@sisk.pl>
References: <5165867.6kdtKH1k0B@penguin> <1430051.zWhrZKIcmE@penguin> <201205151928.36026.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:47796 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966231Ab2EPKTa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 May 2012 06:19:30 -0400
In-Reply-To: <201205151928.36026.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lekensteyn <lekensteyn@gmail.com>, rockorequin@hotmail.com, Cristian =?iso-8859-1?q?Rodr=EDguez?= <crrodriguez@opensuse.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, May 15, 2012, Rafael J. Wysocki wrote:
> On Tuesday, May 15, 2012, Lekensteyn wrote:
> > On Tuesday 15 May 2012 17:47:43 you wrote:
> > > On Tuesday, May 15, 2012, Lekensteyn wrote:
> > > > Commit 1cc0c998fdf2cb665d625fb565a0d6db5c81c639 tried clear up =
some
> > > > confusion around D3hot and D3cold but accidentally changed beha=
viour on
> > > > validating device power states. It added an extra condition: i =
<
> > > > ACPI_STATE_D3_HOT which means that only states D0, D1 and D2 ar=
e accepted
> > > > if there are no power resources but the _PSx method exist. D3(h=
ot) is
> > > > missing here.
> > >=20
> > > Which is intentional (that follows from the ACPI spec.).
> > Now that I am reading it back, this patch invalidates the comment i=
n the code=20
> > and could be achieved by removing the whole i < ... condition (beca=
use that is=20
> > the for-loop condition too). In the ACPI spec [1], I cannot find a =
statement=20
> > that D3 is invalid if there is no _PR3 state. Do you have a referen=
ce for the=20
> > behaviour?
>=20
> Yes, pretty much.  ACPI 4.0 Section 7.2.10 _PR3 (Power Resources for =
D3hot)
> says:
>=20
> "Platform/drivers must assume that the device will have power complet=
ely
> removed when the device is place[d] into "D3" via _PS3."
>=20
> This basically means that if _PR3 is not present, we must assume that=
 _PS3
> puts the device into D3cold.
>=20
> > About the linked bug, I do not see any _PR3 methods on at least 258=
 Optimus=20
> > machines (acpidumps for a lot hybrid graphics machines [2]) althoug=
h the _PS3=20
> > methods on those machines really put the device in a lower power st=
ate.
>=20
> That's correct and that state is D3cold.

So, I believe the patch below should fix the problem and I'll appreciat=
e it
if someone who can reproduce it can test.

Thanks,
Rafael

---
=46rom: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI / PCI / PM: Restore old behavior of acpi_pci_set_power_st=
ate()

Commit 1cc0c998fdf2cb665d625fb565a0d6db5c81c639 (ACPI: Fix D3hot
v D3cold confusion) changed the behavior of
acpi_pci_set_power_state() in such a way that if PCI_D3hot is
passed to it, the function will request a transition to
ACPI_STATE_D3_HOT instead of ACPI_STATE_D3, but ACPI_STATE_D3_HOT
is only supported if the _PR3 AML method is defined for the given
device, which is rare.  This causes problems to happen on systems
where devices were successfully put into ACPI D3 by
pci_set_power_state(PCI_D3hot) which doesn't work now.  In
particular, some unused graphics adapters are not turned off as a
result.

To fix this issue restore the old behavior of
acpi_pci_set_power_state(), which is to request a transition to
ACPI_STATE_D3 (defined to be the same as ACPI_STATE_D3_COLD) if
either PCI_D3hot or PCI_D3cold is passed to it as the argument.

This approach is not ideal, because generally power should not
be removed from devices if PCI_D3hot is the target power state,
but since this behavior is relied on, we have no choice but to
restore it at the moment and spend more time on providing a
better solution in the future.

References: https://bugzilla.kernel.org/show_bug.cgi?id=3D43228
Reported-by: rocko <rockorequin@hotmail.com>
Reported-by: Cristian Rodr=EDguez <crrodriguez@opensuse.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
