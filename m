From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: RE: 'rmmod button' doesn't remove /proc/acpi/button
Date: Mon, 11 Nov 2002 17:00:26 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E307@cceexc19.americas.cpqcorp.net>
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

Andy,

Your patch seems OK for creating/removing the class directories at the
appropriate times.  I've run into some other issues, but I'll address
those in another thread.  In response to Dominik's email, I don't think
having empty class directories is confusing to the user, since there's
already precedence for having filesystem entries with nothing behind
them.  For instance, just because /dev/hdb exists, doesn't mean that you
have a 2nd IDE hard drive.

Thanks,
John

> -----Original Message-----
> From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> Sent: Monday, November 11, 2002 2:48 PM
> To: Cagle, John (ISS-Houston)
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] RE: 'rmmod button' doesn't remove=20
> /proc/acpi/button
>=20
>=20
> > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]
> > Actually, all the other client drivers had code to remove
> > the class proc entry -- it was only missing from button.c's=20
> > unload logic.
>=20
> I think they're not quite right...
>=20
> > > I think the best thing is to make the semantics "the proc dir is=20
> > > there if the driver is loaded, even with no devices=20
> present" instead=20
> > > of "the proc dir is there only if an actual instance of=20
> the device=20
> > > is present". This allows us to move the creation of the=20
> dir to the=20
> > > driver init function, instead of the device add function.
>=20
> > That does sound like a cleaner approach.  Let me try it out and see=20
> > what the patch looks like.
>=20
> I've generated the attached patch (against 2.4-acpi but=20
> should apply to 2.5). Does it fix the problem? If not, it=20
> should at least be a starting point.
>=20
> Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
