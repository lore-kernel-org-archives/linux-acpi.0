From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] fix(Fix _STA checking in acpi_bus_add)
Date: Wed, 12 May 2004 15:07:44 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE055BA15D2@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Simon Derr <Simon.Derr-6ktuUTfB/bM@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

My proposal for spec change to ACPI 3.0:


Section 6.3.6 _STA (Status)

<in the description section>

A special case is where bit 0 is cleared (not present) but bit 3 is set
(device is functional).  This case is used to indicate a valid device
for which no device driver should be loaded (for example, a bridge
device.)  Children of this device may be present and valid, so a device
scan should continue enumeration below a device whose _STA returns this
bit combination.




> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Bjorn Helgaas
> Sent: Wednesday, May 12, 2004 2:54 PM
> To: Brown, Len
> Cc: Simon Derr; Matthew Wilcox; ACPI Developers
> Subject: Re: [ACPI] [PATCH] fix(Fix _STA checking in acpi_bus_add)
>=20
> On Wednesday 12 May 2004 3:49 pm, Len Brown wrote:
> > The ACPI spec gurus say that as of 2.0c,
> > _STA.functional is meaningless unless _STA.present.
> >
> > However, they also say that the (_STA.functional && !_STA.present)
> > implementation was intentional -- apparently to trick some OSPM into
> > using a resource for initialization only, but to not load
> > a driver.
>=20
> Yup, I think somebody said Windows did something special with
> this combination.  Figures.
>=20
> > I'm advocating that the spec be clarified to explicitly
> > allow or disallow this idiom.
> >
> > In the mean-time, Bjorn's patch is now present in the acpi-test
tree.
>=20
> Sounds good to me.  Thanks for chasing it down!
>=20
> Bjorn
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to
> deliver
> higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=3Dosdnemail3
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
