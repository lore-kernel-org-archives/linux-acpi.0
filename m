From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: HP DL360G3 and ACPI
Date: Fri, 23 Apr 2004 09:45:31 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05579C13C@orsmsx403.amr.corp.intel.com>
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
To: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>, Alexander Hoogerhuis <alexh-RsuaBgf086Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>     ACPI-1059: *** Info: There are no GPE blocks defined in the FADT

Yes, I'll remove this as "info", but leave it in as a debug statement in
the debug version.

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Cagle, John (ISS-Houston)
> Sent: Friday, April 23, 2004 6:44 AM
> To: Alexander Hoogerhuis; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] HP DL360G3 and ACPI
>=20
> > -----Original Message-----
> > From: Alexander Hoogerhuis
> > Sent: Thursday, April 22, 2004 11:50 PM
> >
> > I have a few of these beasts onsite at a customers site, and
> > they ahve a
> > tendency to wind up the fans and not come back ddown again. I'm
> > currently running 2.6.5-mm6 on them and the only piece of suspicious
> > output I can find int he boot log is this:
> >
> > ...
> > ACPI: Subsystem revision 20040326
> > ACPI: IRQ9 SCI: Level Trigger.
> >     ACPI-1059: *** Info: There are no GPE blocks defined in the FADT
> > ACPI: Interpreter enabled
> > ACPI: Using PIC for interrupt routing
> > ACPI: PCI Root Bridge [PCI0] (00:00)
> > ...
> >
> > Is there any harm here or just me barking up the wrong tree?
>=20
> You're barking up the wrong tree. :-)
>=20
> I assume you're talking about the "Info" line above.  This used to
> be a "Warning" until I pointed out that there's no requirement
> (or need) for GPE blocks to be defined in the FADT according to the
> ACPI specification.  This "Info" line should be removed, IMHO.  It's
> like having your car tell you "There are no maps in the glove box."
>=20
> If you're interested in having more intelligent fan control of the
> DL360G3, you'll need to install the 'hpasm' driver, available here:
>=20
>   http://tinyurl.com/3cj8f
>=20
> That link is for the Red Hat 8.0 version.  For the list of support
> pages for the different OS's, go here:
>=20
>   http://tinyurl.com/2xtrv
>=20
> If you're not running one of the officially supported OS's, you can
> still use the 'hpasm' driver.  The documentation gives instructions
> on rebuilding the driver for any kernel.
>=20
> Regards,
> John
>=20
> -----------------------------
> John Cagle  john.cagle-VXdhtT5mjnY@public.gmane.org
> HP Distinguished Technologist
> ProLiant Software Development
>   http://www.hp.com/linux/
>   Hewlett-Packard Company
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=12297
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
