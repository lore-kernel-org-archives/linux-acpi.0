From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI / PCIe / AER: Disable native AER service if BIOS has precedence (v2) (was: Re: [PATCH]  PCI / PCIe / AER ...)
Date: Mon, 20 Sep 2010 18:50:00 +0200
Message-ID: <201009201850.00626.rjw@sisk.pl>
References: <201009200002.15609.rjw@sisk.pl> <4C96FCA3.2060704@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50804 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab0ITQvE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Sep 2010 12:51:04 -0400
In-Reply-To: <4C96FCA3.2060704@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Monday, September 20, 2010, Chen Gong wrote:
> =E4=BA=8E 9/20/2010 6:02 AM, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > From: Rafael J. Wysocki<rjw@sisk.pl>
> >
> > There is a design issue related to PCIe AER and _OSC that the BIOS
> > may be asked to grant control of the AER service even if some
> > Hardware Error Source Table (HEST) entries contain information
> > meaning that the BIOS really should control it.  Namely,
> > pcie_port_acpi_setup() calls pcie_aer_get_firmware_first() that
> > determines whether or not the AER service should be controlled by
> > the BIOS on the basis of the HEST information for the given PCIe
> > port.  The BIOS is asked to grant control of the AER service for
> > a PCIe Root Complex if pcie_aer_get_firmware_first() returns 'false=
'
> > for at least one root port in that complex, even if all of the othe=
r
> > root ports' HEST entries have the FIRMWARE_FIRST flag set (and none
> > of them has the GLOBAL flag set).  However, if the AER service is
> > controlled by the kernel, that may interfere with the BIOS' handlin=
g
> > of the error sources having the FIRMWARE_FIRST flag.  Moreover,
> > there may be PCIe endpoints that have the FIRMWARE_FIRST flag set i=
n
> > HEST and are attached to the root ports in question, in which case =
it
> > also may be unsafe to ask the BIOS for control of the AER service.
> >
> > For this reason, introduce a function checking if there's at least
> > one PCIe-related HEST entry with the FIRMWARE_FIRST flag set and
> > disable the native AER service altogether if this function returns
> > 'true'.
> >
> > Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
> > ---
> >   drivers/pci/pcie/aer/aerdrv.c      |    2 +-
> >   drivers/pci/pcie/aer/aerdrv.h      |    3 +++
> >   drivers/pci/pcie/aer/aerdrv_acpi.c |   31 +++++++++++++++++++++++=
++++++++
> >   drivers/pci/pcie/portdrv_acpi.c    |    2 +-
> >   4 files changed, 36 insertions(+), 2 deletions(-)
> >
> > Index: linux-2.6/drivers/pci/pcie/aer/aerdrv_acpi.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv_acpi.c
> > +++ linux-2.6/drivers/pci/pcie/aer/aerdrv_acpi.c
> > @@ -93,4 +93,35 @@ int pcie_aer_get_firmware_first(struct p
> >   		aer_set_firmware_first(dev);
> >   	return dev->__aer_firmware_first;
> >   }
> > +
> > +static bool aer_firmware_first;
> > +
> > +static int aer_hest_parse_aff(struct acpi_hest_header *hest_hdr, v=
oid *data)
> > +{
> > +	if (aer_firmware_first)
> > +		return 0;
> > +
> > +	switch (hest_hdr->type) {
> > +	case ACPI_HEST_TYPE_AER_ROOT_PORT:
> > +	case ACPI_HEST_TYPE_AER_ENDPOINT:
> > +	case ACPI_HEST_TYPE_AER_BRIDGE:
> > +		aer_firmware_first =3D !!(p->flags&  ACPI_HEST_FIRMWARE_FIRST);
>=20
> Where "p" comes from ? Maybe it points to "struct acpi_hest_aer_commo=
n *p;"

My bad, terribly sorry.

I must have posted a wrong version of the patch. :-(
=46ixed patch is appended.

Thanks,
Rafael

---
=46rom: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PCI / PCIe / AER: Disable native AER service if BIOS has prece=
dence (v2)

There is a design issue related to PCIe AER and _OSC that the BIOS
may be asked to grant control of the AER service even if some
Hardware Error Source Table (HEST) entries contain information
meaning that the BIOS really should control it.  Namely,
pcie_port_acpi_setup() calls pcie_aer_get_firmware_first() that
determines whether or not the AER service should be controlled by
the BIOS on the basis of the HEST information for the given PCIe
port.  The BIOS is asked to grant control of the AER service for
a PCIe Root Complex if pcie_aer_get_firmware_first() returns 'false'
for at least one root port in that complex, even if all of the other
root ports' HEST entries have the FIRMWARE_FIRST flag set (and none
of them has the GLOBAL flag set).  However, if the AER service is
controlled by the kernel, that may interfere with the BIOS' handling
of the error sources having the FIRMWARE_FIRST flag.  Moreover,
there may be PCIe endpoints that have the FIRMWARE_FIRST flag set in
HEST and are attached to the root ports in question, in which case it
also may be unsafe to ask the BIOS for control of the AER service.

=46or this reason, introduce a function checking if there's at least
one PCIe-related HEST entry with the FIRMWARE_FIRST flag set and
disable the native AER service altogether if this function returns
'true'.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Changes since v1:

 * Fix compilation problem with undefined p in aer_hest_parse_aff().

---
 drivers/pci/pcie/aer/aerdrv.c      |    2 +-
 drivers/pci/pcie/aer/aerdrv.h      |    3 +++
 drivers/pci/pcie/aer/aerdrv_acpi.c |   34 ++++++++++++++++++++++++++++=
++++++
 drivers/pci/pcie/portdrv_acpi.c    |    2 +-
 4 files changed, 39 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/pcie/aer/aerdrv_acpi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ linux-2.6/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -93,4 +93,38 @@ int pcie_aer_get_firmware_first(struct p
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
 }
+
+static bool aer_firmware_first;
+
+static int aer_hest_parse_aff(struct acpi_hest_header *hest_hdr, void =
*data)
+{
+	struct acpi_hest_aer_common *p;
+
+	if (aer_firmware_first)
+		return 0;
+
+	switch (hest_hdr->type) {
+	case ACPI_HEST_TYPE_AER_ROOT_PORT:
+	case ACPI_HEST_TYPE_AER_ENDPOINT:
+	case ACPI_HEST_TYPE_AER_BRIDGE:
+		p =3D (struct acpi_hest_aer_common *)(hest_hdr + 1);
+		aer_firmware_first =3D !!(p->flags & ACPI_HEST_FIRMWARE_FIRST);
+	default:
+		return 0;
+	}
+}
+
+/**
+ * aer_acpi_firmware_first - Check if APEI should control AER.
+ */
+bool aer_acpi_firmware_first(void)
+{
+	static bool parsed =3D false;
+
+	if (!parsed) {
+		apei_hest_parse(aer_hest_parse_aff, NULL);
+		parsed =3D true;
+	}
+	return aer_firmware_first;
+}
 #endif
Index: linux-2.6/drivers/pci/pcie/aer/aerdrv.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv.h
+++ linux-2.6/drivers/pci/pcie/aer/aerdrv.h
@@ -132,6 +132,7 @@ static inline int aer_osc_setup(struct p
=20
 #ifdef CONFIG_ACPI_APEI
 extern int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
+extern bool aer_acpi_firmware_first(void);
 #else
 static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
 {
@@ -139,6 +140,8 @@ static inline int pcie_aer_get_firmware_
 		return pci_dev->__aer_firmware_first;
 	return 0;
 }
+
+static inline bool aer_acpi_firmware_first(void) { return false; }
 #endif
=20
 static inline void pcie_aer_force_firmware_first(struct pci_dev *pci_d=
ev,
Index: linux-2.6/drivers/pci/pcie/aer/aerdrv.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv.c
+++ linux-2.6/drivers/pci/pcie/aer/aerdrv.c
@@ -416,7 +416,7 @@ static void aer_error_resume(struct pci_
  */
 static int __init aer_service_init(void)
 {
-	if (!pci_aer_available())
+	if (!pci_aer_available() || aer_acpi_firmware_first())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
Index: linux-2.6/drivers/pci/pcie/portdrv_acpi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/pci/pcie/portdrv_acpi.c
+++ linux-2.6/drivers/pci/pcie/portdrv_acpi.c
@@ -49,7 +49,7 @@ int pcie_port_acpi_setup(struct pci_dev=20
 		| OSC_PCI_EXPRESS_PME_CONTROL;
=20
 	if (pci_aer_available()) {
-		if (pcie_aer_get_firmware_first(port))
+		if (aer_acpi_firmware_first())
 			dev_dbg(&port->dev, "PCIe errors handled by BIOS.\n");
 		else
 			flags |=3D OSC_PCI_EXPRESS_AER_CONTROL;
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
