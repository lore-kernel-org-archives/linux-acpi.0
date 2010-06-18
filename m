From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI / PM: Do not use native PCIe PME by default
Date: Fri, 18 Jun 2010 17:04:22 +0200
Message-ID: <201006181704.22550.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53289 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933594Ab0FRPGI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2010 11:06:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

=46rom: Rafael J. Wysocki <rjw@sisk.pl>

Commit c7f486567c1d0acd2e4166c47069835b9f75e77b
(PCI PM: PCIe PME root port service driver) causes the native PCIe
PME signaling to be used by default, if the BIOS allows the kernel to
control the standard configuration registers of PCIe root ports.
However, the native PCIe PME is coupled to the native PCIe hotplug
and calling pcie_pme_acpi_setup() makes some BIOSes expect that
the native PCIe hotplug will be used as well.  That, in turn, causes
problems to appear on systems where the PCIe hotplug driver is not
loaded.  The usual symptom, as reported by Jaroslav Kamen=C3=ADk and
others, is that the ACPI GPE associated with PCIe hotplug keeps
firing continuously causing kacpid to take substantial percentage
of CPU time.

To work around this issue, change the default so that the native
PCIe PME signaling is only used if directly requested with the help
of the pcie_pme=3D command line switch.

=46ixes https://bugzilla.kernel.org/show_bug.cgi?id=3D15924 , which is
a listed regression from 2.6.33.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Jaroslav Kamen=C3=ADk <jaroslav@kamenik.cz>
Tested-by: Antoni Grzymala <antekgrzymala@gmail.com>=20
---
 Documentation/kernel-parameters.txt |    4 +++-
 drivers/pci/pcie/pme/pcie_pme.c     |   19 +++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/pci/pcie/pme/pcie_pme.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/pci/pcie/pme/pcie_pme.c
+++ linux-2.6/drivers/pci/pcie/pme/pcie_pme.c
@@ -34,7 +34,7 @@
  * being registered.  Consequently, the interrupt-based PCIe PME signa=
ling will
  * not be used by any PCIe root ports in that case.
  */
-static bool pcie_pme_disabled;
+static bool pcie_pme_disabled =3D true;
=20
 /*
  * The PCI Express Base Specification 2.0, Section 6.1.8, states the f=
ollowing:
@@ -64,12 +64,19 @@ bool pcie_pme_msi_disabled;
=20
 static int __init pcie_pme_setup(char *str)
 {
-	if (!strcmp(str, "off"))
-		pcie_pme_disabled =3D true;
-	else if (!strcmp(str, "force"))
+	if (!strncmp(str, "auto", 4))
+		pcie_pme_disabled =3D false;
+	else if (!strncmp(str, "force", 5))
 		pcie_pme_force_enable =3D true;
-	else if (!strcmp(str, "nomsi"))
-		pcie_pme_msi_disabled =3D true;
+
+	str =3D strchr(str, ',');
+	if (str) {
+		str++;
+		str +=3D strspn(str, " \t");
+		if (*str && !strcmp(str, "nomsi"))
+			pcie_pme_msi_disabled =3D true;
+	}
+
 	return 1;
 }
 __setup("pcie_pme=3D", pcie_pme_setup);
Index: linux-2.6/Documentation/kernel-parameters.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -2048,7 +2048,9 @@ and is between 256 and 4096 characters.=20
 			WARNING: Forcing ASPM on may cause system lockups.
=20
 	pcie_pme=3D	[PCIE,PM] Native PCIe PME signaling options:
-		off	Do not use native PCIe PME signaling.
+			Format: {auto|force}[,nomsi]
+		auto	Use native PCIe PME signaling if the BIOS allows the
+			kernel to control PCIe config registers of root ports.
 		force	Use native PCIe PME signaling even if the BIOS refuses
 			to allow the kernel to control the relevant PCIe config
 			registers.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
