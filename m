From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: Re: DSDT in initrd
Date: Wed, 28 May 2003 13:27:40 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2C3@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]=20
> > > > What this enables is not only an elimination of the hassle=20
> > > of initrd, it
> > > > enables previously unmodularizable things like ACPI, or=20
> > > PCI, or all the
> > > > special code needed for x86 subarchs, or whatever other=20
> > > code that one
> > >=20
> > > subarchs are different issue. They can't
> > > be modularized without runtime overhead.
> >=20
> > How much runtime overhead?
>=20
> Hard to tell... It might be 10% in heavy-interrupt-load situation...

Can you help me understand more about why this might be? Why would
modularized code be a performance hit over statically linked? I was
assuming there would be another pointer dereference perhaps but that
certainly is not going to be noticed. We already have drivers in
modules, I'm trying to understand how for example a hi-perf nic driver
performs the same when modularized but subarch stuff wouldn't, when I'm
assuming it would just be like a "driver" for the particular
peculiarities of the platform.

Thanks -- Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
