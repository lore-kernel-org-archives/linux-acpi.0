From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: RE: [patch] acpi-20020725-2.4.19rc3 and incremental patch
	from acpi20020709
Date: 30 Jul 2002 23:15:57 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028084666.1109.29.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2002-07-29 at 14:33, Grover, Andrew wrote:
=20
> Once 2.4.19 is out, and assuming there aren't
> any big regressions, I will submit it to Marcelo for 2.4.20. It's a huge
> patch. It's been nine months since the last 2.4 ACPI update.
>=20
> Regards -- Andy
>=20
Ok=20

I would like that you or someone that understand the of meter
see the file linux-2.4.19/arch/i386/kernel/pci-pc.c

is now like this:

#ifdef CONFIG_ACPI_PCI
    if (acpi_pci_irq_init() > 0)
        pci_using_acpi_prt =3D 1;
#endif

    printk(KERN_INFO "PCI: Probing PCI hardware\n");
    if (!pci_using_acpi_prt) {
        pci_root_bus =3D pci_scan_bus(0, pci_root_ops, NULL);
    }

    if (clustered_apic_mode && (numnodes > 1)) {
        for (quad =3D 1; quad < numnodes; ++quad) {
            printk("Scanning PCI bus %d for quad %d\n",
                QUADLOCAL2BUS(quad,0), quad);
            pci_scan_bus(QUADLOCAL2BUS(quad,0),
                pci_root_ops, NULL);
        }
    }

    if (!pci_using_acpi_prt) {
        pcibios_irq_init();
        pcibios_fixup_peer_bridges();
        pcibios_fixup_irqs();
    }


but I don't  know if should be:

#ifdef CONFIG_ACPI_PCI
    if (acpi_pci_irq_init() > 0)
        pci_using_acpi_prt =3D 1;
#endif

    printk(KERN_INFO "PCI: Probing PCI hardware\n");
    if (!pci_using_acpi_prt) {
        pci_root_bus =3D pci_scan_bus(0, pci_root_ops, NULL);


    if (clustered_apic_mode && (numnodes > 1)) {
        for (quad =3D 1; quad < numnodes; ++quad) {
            printk("Scanning PCI bus %d for quad %d\n",
                QUADLOCAL2BUS(quad,0), quad);
            pci_scan_bus(QUADLOCAL2BUS(quad,0),
                pci_root_ops, NULL);
        }
    }

        pcibios_irq_init();
        pcibios_fixup_peer_bridges();
        pcibios_fixup_irqs();
    }
   =20
At least in this case I have no idea.=20
S=E9rgiomb



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
