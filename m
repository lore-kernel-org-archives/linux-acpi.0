From: Toon van der Pas <toon-/ye6tfJczTwcEEi49/iq3g@public.gmane.org>
Subject: Re: 2.5.34?
Date: Wed, 18 Sep 2002 18:38:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020918183819.A10275@vdpas.hobby.nl>
References: <20020916001425.82756.qmail@web20906.mail.yahoo.com> <20020916012506.G10583@parcelfarce.linux.theplanet.co.uk> <20020916081909.A25876@vdpas.hobby.nl> <20020917154653.C39@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020917154653.C39-muQmgwBScQHrBKCeMvbIDA@public.gmane.org>; from pavel-AlSwsSmVLrQ@public.gmane.org on Tue, Sep 17, 2002 at 03:46:53PM +0000
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 17, 2002 at 03:46:53PM +0000, Pavel Machek wrote:
>=20
> > > > Is 2.5.34 patch comming out soon?
> > >=20
> > > i don't particularly see the point in releasing one since all ACPI =
patches
> > > for 2.5 that i'm aware of are integrated into the current bitkeeper=
 tree.
> > > you could grab a nightly snapshot if you can't wait for 2.5.35:
> > > http://www.kernel.org/pub/linux/kernel/people/jgarzik/snap/2.5/patc=
h-2.5.34-bk6.bz2
> >=20
> > But be aware that the swsusp patch in the IDE driver in de 2.5 kernel
> > was lost when Martin Dalecki's IDE project was removed!
> > I would wait for it to return in some form or another, if I where you.
>=20
> Look at l-k, I already submitted IDE swsusp support to Andre.

I know.
I got my information from your postings on the linux-kernel mailing list.=
=20
My only intention was to warn people that their data is NOT safe when
using swsusp with recent 2.5 kernels.

I should have added that you already submitted a patch on the
linux-kernel mailing list. Sorry about that.

BTW: From your discussion with Andr=E9 Hedrick I understood that there
still is some disagreement about the layer where the I/O to the IDE
block devices should be blocked by swsusp. Is this resolved now?

Regards,
Toon.
--=20
 /"\                             |
 \ /     ASCII RIBBON CAMPAIGN   |  "Who is this General Failure, and
  X        AGAINST HTML MAIL     |   what is he doing on my harddisk?"
 / \


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
