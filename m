From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [patch] acpi-20020725-2.4.19rc3 and incremental patch
	 from acpi20020709
Date: Tue, 13 Aug 2002 11:06:09 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DD83@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: =?iso-8859-1?Q?=27S=E9rgio_Monteiro_Basto=27?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

(Sorry for replying to old threads - just got back from vacation)

Fixed (I think):

agrover  1.24 | #ifdef CONFIG_ACPI_PCI
agrover  1.24 | 	if (!acpi_pci_irq_init())
agrover  1.24 | 		pci_using_acpi_prt =3D 1;
agrover  1.24 | #endif
agrover  1.24 | 	if (!pci_using_acpi_prt) {
agrover  1.24 | 		pci_root_bus =3D pcibios_scan_root(0);
agrover  1.24 | 		pcibios_irq_init();
agrover  1.24 | 		pcibios_fixup_peer_bridges();
agrover  1.24 | 		pcibios_fixup_irqs();
agrover  1.24 | 	}
patch    1.19 | 	if (clustered_apic_mode && (numnodes > 1)) {
patch    1.19 | 		for (quad =3D 1; quad < numnodes; ++quad) {
patch    1.19 | 			printk("Scanning PCI bus %d for quad
%d\n",=20
patch    1.19 | 				QUADLOCAL2BUS(quad,0),
quad);
patch    1.19 | 			pci_scan_bus(QUADLOCAL2BUS(quad,0),=20
patch    1.19 | 				pci_root_ops, NULL);
patch    1.19 | 		}
patch    1.19 | 	}
torvalds 1.1  |=20
torvalds 1.1  | 	pcibios_resource_survey();

Let me know if this won't work.

-- Andy

> -----Original Message-----
> From: S=E9rgio Monteiro Basto [mailto:sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org]=20
> Sent: Tuesday, July 30, 2002 8:16 PM
> To: Grover, Andrew
> Cc: acpi-devel
> Subject: RE: [ACPI] [patch] acpi-20020725-2.4.19rc3 and=20
> incremental patch from acpi20020709
>=20
>=20
> On Mon, 2002-07-29 at 14:33, Grover, Andrew wrote:
> =20
> > Once 2.4.19 is out, and assuming there aren't
> > any big regressions, I will submit it to Marcelo for=20
> 2.4.20. It's a huge
> > patch. It's been nine months since the last 2.4 ACPI update.
> >=20
> > Regards -- Andy
> >=20
> Ok=20
>=20
> I would like that you or someone that understand the of meter
> see the file linux-2.4.19/arch/i386/kernel/pci-pc.c
>=20
> is now like this:
>=20
> #ifdef CONFIG_ACPI_PCI
>     if (acpi_pci_irq_init() > 0)
>         pci_using_acpi_prt =3D 1;
> #endif
>=20
>     printk(KERN_INFO "PCI: Probing PCI hardware\n");
>     if (!pci_using_acpi_prt) {
>         pci_root_bus =3D pci_scan_bus(0, pci_root_ops, NULL);
>     }
>=20
>     if (clustered_apic_mode && (numnodes > 1)) {
>         for (quad =3D 1; quad < numnodes; ++quad) {
>             printk("Scanning PCI bus %d for quad %d\n",
>                 QUADLOCAL2BUS(quad,0), quad);
>             pci_scan_bus(QUADLOCAL2BUS(quad,0),
>                 pci_root_ops, NULL);
>         }
>     }
>=20
>     if (!pci_using_acpi_prt) {
>         pcibios_irq_init();
>         pcibios_fixup_peer_bridges();
>         pcibios_fixup_irqs();
>     }
>=20
>=20
> but I don't  know if should be:
>=20
> #ifdef CONFIG_ACPI_PCI
>     if (acpi_pci_irq_init() > 0)
>         pci_using_acpi_prt =3D 1;
> #endif
>=20
>     printk(KERN_INFO "PCI: Probing PCI hardware\n");
>     if (!pci_using_acpi_prt) {
>         pci_root_bus =3D pci_scan_bus(0, pci_root_ops, NULL);
>=20
>=20
>     if (clustered_apic_mode && (numnodes > 1)) {
>         for (quad =3D 1; quad < numnodes; ++quad) {
>             printk("Scanning PCI bus %d for quad %d\n",
>                 QUADLOCAL2BUS(quad,0), quad);
>             pci_scan_bus(QUADLOCAL2BUS(quad,0),
>                 pci_root_ops, NULL);
>         }
>     }
>=20
>         pcibios_irq_init();
>         pcibios_fixup_peer_bridges();
>         pcibios_fixup_irqs();
>     }
>    =20
> At least in this case I have no idea.=20
> S=E9rgiomb
>=20


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
