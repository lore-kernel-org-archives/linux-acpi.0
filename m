From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: acpi problem with nforce motherboards and ethernet
Date: Thu, 5 Feb 2004 15:40:59 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040205154059.6649dd74.akpm@osdl.org>
References: <402298C7.5050405@wanadoo.es>
	<40229D2C.20701@blue-labs.org>
	<4022B55B.1090309@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4022B55B.1090309-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>
Cc: david+challenge-response-qokYbnrgTHEgsBAKwltoeQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Luis Miguel Garc=EDa <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org> wrote:
>
> David Ford wrote:
>=20
> > I have the same problem.  I "solved" it a while ago by mucking with=20
> > the AGP stuff.  IIRC, it was turning off AGP fast writes or 8x or=20
> > something similar in cmos.  Went from incredibly broken to stable=20
> > instantly.  I'll check my cmos settings in a bit and refresh my memory.
> >
> > What patches are you using?
>=20
>=20
> I'm using nforce2-apic.patch and nforce2-disconnect-quirk.patch that=20
> Andrew Morton have sent to me. I think they have been included in=20
> previous mm kernels but now are droped because they caused some=20
> temperature problems for some people with no nforce motherboards.

Yes, the patch which disables "Halt Disconnect and Stop Grant Disconnect"
apparently causes the CPU to run hot.

> By the way, is anyone involved in solving the IO-APIC thing in nforce=20
> motherboards? Anyone trying a different approach? Anyone contacting=20
> nvidia about this problem?

As far as I know, we're dead in the water on these problems.

Here's one:


[x86] do not wrongly override mp_ExtINT IRQ

From: Mathieu <cheuche+lkml-GANU6spQydw@public.gmane.org>.

With this patch timer IRQ0 is correctly set to IO-APIC-edge
(not XT-PIC) on nForce2 boards when using APIC and ACPI.

 arch/i386/kernel/mpparse.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/mpparse.c~nforce2-apic arch/i386/kernel/mpparse.c
--- linux-2.6.0-test11/arch/i386/kernel/mpparse.c~nforce2-apic	2003-12-08 0=
0:12:25.782597272 +0100
+++ linux-2.6.0-test11-root/arch/i386/kernel/mpparse.c	2003-12-08 00:12:25.=
786596664 +0100
@@ -962,7 +962,8 @@ void __init mp_override_legacy_irq (
 	 */
 	for (i =3D 0; i < mp_irq_entries; i++) {
 		if ((mp_irqs[i].mpc_dstapic =3D=3D intsrc.mpc_dstapic)=20
-			&& (mp_irqs[i].mpc_srcbusirq =3D=3D intsrc.mpc_srcbusirq)) {
+			&& (mp_irqs[i].mpc_srcbusirq =3D=3D intsrc.mpc_srcbusirq)
+			&& (mp_irqs[i].mpc_irqtype =3D=3D intsrc.mpc_irqtype)) {
 			mp_irqs[i] =3D intsrc;
 			found =3D 1;
 			break;

_

Here's the other:


From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz-ZGDBLhmm9VR4rM3dGMyr8Q@public.gmane.org>

[PATCH] fix lockups with APIC support on nForce2

Add PCI quirk to disable Halt Disconnect and Stop Grant Disconnect
(based on athcool program by Osamu Kayasono).

(Mark McPherson <mark-HKnOa/PvsEVBDgjK7y7TUQ@public.gmane.org> reports that this patch causes his CPU
temperature to skyrocket).


 25-akpm/arch/i386/pci/fixup.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

diff -puN arch/i386/pci/fixup.c~nforce2-disconnect-quirk arch/i386/pci/fixu=
p.c
--- 25/arch/i386/pci/fixup.c~nforce2-disconnect-quirk	Mon Jan  5 12:07:45 2=
004
+++ 25-akpm/arch/i386/pci/fixup.c	Mon Jan  5 12:07:45 2004
@@ -187,6 +187,22 @@ static void __devinit pci_fixup_transpar
 		dev->transparent =3D 1;
 }
=20
+/*
+ * Halt Disconnect and Stop Grant Disconnect (bit 4 at offset 0x6F)
+ * must be disabled when APIC is used (or lockups will happen).
+ */
+static void __devinit pci_fixup_nforce2_disconnect(struct pci_dev *d)
+{
+	u8 t;
+
+	pci_read_config_byte(d, 0x6F, &t);
+	if (t & 0x10) {
+		printk(KERN_INFO "PCI: disabling nForce2 Halt Disconnect"
+				 " and Stop Grant Disconnect\n");
+		pci_write_config_byte(d, 0x6F, (t & 0xef));
+	}
+}
+
 struct pci_fixup pcibios_fixups[] =3D {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci=
_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci=
_fixup_i450gx },
@@ -205,5 +221,6 @@ struct pci_fixup pcibios_fixups[] =3D {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixu=
p_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixu=
p_ncr53c810 },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transpar=
ent_bridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2,	p=
ci_fixup_nforce2_disconnect },
 	{ 0 }
 };

_



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
