From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 5 Feb 2004 00:15:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB6@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The strategy is to improve ACPI on Linux such that all Linux distros are
able to successfully ship ACPI enabled kernels.

When we reach that stage, the OEMs will use these commercial Linux
products when they validate their platforms -- fixing DSDT problems
themselves before the 1st BIOS is released to the public.

Thus the long term strategy is for zero DSDT over-rides.

Re: what does windows do?
Windows doesn't have to do anything.  By being first to ship ACPI, that
implementation provided the defacto ACPI compliance test to which all
BIOS' are tested -- even if that implementation is not ACPI spec
compliant.  No, only under dire circumstances will we emulate Windows
bugs in Linux.

-Len

> -----Original Message-----
> From: Scott T. Smith [mailto:scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org]=20
> Sent: Wednesday, February 04, 2004 9:19 PM
> To: Brown, Len
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] RE: ACPI -- Workaround for broken DSDT
>=20
>=20
> On Tue, 2004-02-03 at 23:22, Brown, Len wrote:
> > > From Brown, Len on Sunday, 01 February, 2004:
> > > >The vendor should supply a correct DSDT with their BIOS.
> > > >In the case of Dell, you might inquire here:=20
http://linux.dell.com/
> > >For non-vendor supplied solutions, you might also follow the=20
> > DSDT link
> > >here: http://acpi.sourceforge.net/ =20
> >=20
> > Hmm.  Do vendors generally release these?  I know Dell's very shaky
on
> >   the Linux support front, at least for desktop/laptop.
> > Also, how do non-vendor supplied ones get made?  Seems like
something
> >   you need NDA'ed docs for.
>=20
> Non-vendor supplied DSDTs are created by end-users who bought machines
> that don't work.  Per the DSDT link above, one can extract,
> dis-assemble, modify a DSDT -- and tell Linux to use your copy instead
> of the version burned into PROM.

what's the long term strategy for ACPI on Linux?  If there are so many
broken DSDT's, and we want ACPI to be accessible to non-programmers,
then what's the ultimate solution?  Is it to include patches for every
possible platform, and have the ACPI subsystem autodetect and fix at
boot time?

Since thus far the ability to override the DSDT tables has not been
included in the vanilla ACPI distribution, then it seems you guys have
something else in mind.

What does Windows do?  Is it just that their DSDT
parser/executer/whatever operates differently (in which case a Windows
emulation mode could be added to the Linux subsystem), or is it that
Laptop manufacturers ship a corrected DSDT as part of their driver set?

	Scott



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
