From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: RE: 'rmmod button' doesn't remove /proc/acpi/button
Date: Mon, 11 Nov 2002 14:24:59 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10476BA14@cceexc19.americas.cpqcorp.net>
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
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]
> > I found a minor bug in button.c's acpi_button_exit() routine.=20
> >  It doesn't remove the top-level 'button' directory when=20
> > unloading the module, and if you insmod/rmmod multiple times,=20
> > you'll end up with lots of 'button' directories in /proc/acpi.
>=20
> This actually reveals a bug in *all* of the client drivers.=20

Actually, all the other client drivers had code to remove
the class proc entry -- it was only missing from button.c's
unload logic.

> They all depend upon a global variable with the name=20
> acpi_{battery,button,etc}_dir to see if they need to make=20
> their class proc entry when adding their first device. This=20
> has the benefit of only creating a "button" directory if=20
> there actually is a button, but has the bad feature of not=20
> working for insmod...because the global variables go away,=20
> and so we blindly add the proc entries again.
>=20
> I think the best thing is to make the semantics "the proc dir=20
> is there if the driver is loaded, even with no devices=20
> present" instead of "the proc dir is there only if an actual=20
> instance of the device is present".
>=20
> This allows us to move the creation of the dir to the driver=20
> init function, instead of the device add function.
>=20
> Does that sound right?

That does sound like a cleaner approach.  Let me try it out
and see what the patch looks like.

>=20
> Regards -- Andy

Regards,
John
--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux
         281-514-9167


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
