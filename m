From: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: Re: [Resend][PATCH] PCI / ACPI: Request _OSC control once for each root bridge (v3)
Date: Fri, 7 Jan 2011 08:14:15 +0200
Message-ID: <201101070814.15886.ozan@pardus.org.tr>
References: <201101070055.10065.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:33887 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab1AGG0q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jan 2011 01:26:46 -0500
In-Reply-To: <201101070055.10065.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>

Cuma 07 Ocak 2011 g=C3=BCn=C3=BC (saat 01:55:09) Rafael J. Wysocki =C5=9F=
unlar=C4=B1 yazm=C4=B1=C5=9Ft=C4=B1:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Move the evaluation of acpi_pci_osc_control_set() (to request control
> of PCI Express native features) into acpi_pci_root_add() to avoid
> calling it many times for the same root complex with the same
> arguments.  Additionally, check if all of the requisite _OSC
> support bits are set before calling acpi_pci_osc_control_set() for
> a given root complex.
>=20
> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D20232
> Reported-by: Ozan Caglayan <ozan@pardus.org.tr>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>=20
> Hi,
>=20
> This fixes a post-2.6.35 regression for Ozan, possibly -stable materi=
al.

Tested-by: Ozan Caglayan <ozan@pardus.org.tr>

---
Ozan =C3=87a=C4=9Flayan
TUBITAK/UEKAE - Pardus Linux
http://www.pardus.org.tr/eng
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
