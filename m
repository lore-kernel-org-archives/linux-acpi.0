From: Kai Germaschewski <kai-germaschewski-Q3dYeWy5uxSHXe+LvDLADg@public.gmane.org>
Subject: Re: ACPI Source patches updated (20021022)
Date: Thu, 24 Oct 2002 10:29:04 -0500 (CDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0210241017560.6574-100000@chaos.physics.uiowa.edu>
References: <20021023110222.A14630@sci.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021023110222.A14630-ORSVBvAovxo@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 23 Oct 2002, Ville Syrj=E4l=E4 wrote:

> On Tue, Oct 22, 2002 at 07:19:33PM -0700, Grover, Andrew wrote:
> > Hi all,
> >=20
> > New ACPI patches are now available on http://sf.net/projects/acpi .
> > Non-Linux source releases will be up by Thursday evening.
>=20
> You didn't pick up my IRQ derive fix. Is it incorrect or did you just
> miss it?
>=20
> --- linux-2.4.20-pre7/drivers/acpi/pci_irq.c~   Thu Sep 19 17:17:58 200=
2
> +++ linux-2.4.20-pre7/drivers/acpi/pci_irq.c    Tue Oct  8 01:45:29 200=
2
> @@ -285,7 +285,7 @@
>  	 * PCI interrupt routing entry (a.k.a. the "bridge swizzle").
>  	 */
>  	while (!irq && (bridge =3D bridge->bus->self)) {
> -		pin =3D (pin + PCI_SLOT(bridge->devfn)) % 4;
> +		pin =3D (pin + PCI_SLOT(dev->devfn)) % 4;
>  		irq =3D acpi_pci_irq_lookup(0, bridge->bus->number, PCI_SLOT(bridge-=
>devfn), pin);
>  	}

Well, this patch is obviously not correct, consider the case where the=20
loop is executed more than once.

I think it should be

	while (!irq && bridge->bus->self) {
		pin =3D (pin + PCI_SLOT(bridge->devfn)) % 4;
		bridge =3D bridge->bus->self;
		irq =3D acpi_pci_irq_lookup(0, bridge->bus->number, PCI_SLOT(bridge->de=
vfn), pin);
	}

Want to give that a try?

--Kai




-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4729346;7592162;s?http://www.sun.com/javavote
