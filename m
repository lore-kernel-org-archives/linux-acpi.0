From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 5 Feb 2004 03:10:53 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB9@hdsmsx402.hd.intel.com>
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

> On Wed, 2004-02-04 at 21:15, Brown, Len wrote:=20
> > The strategy is to improve ACPI on Linux such that all=20
> Linux distros are
> > able to successfully ship ACPI enabled kernels.
> >=20
> > When we reach that stage, the OEMs will use these commercial Linux
> > products when they validate their platforms -- fixing DSDT problems
> > themselves before the 1st BIOS is released to the public.
>=20
> realistically, that's 3-5+ years away.  In the meantime, what are
> existing users to do?  (i.e. those of us who don't like reading 430+
> pages of the spec)

Linux users should buy machines from OEMs that support Linux,
and not buy machines from OEMs that ignore Linux.  There are
OEMS that validate their platforms with Linux today -- this isn't
3-5 years away.

> So basically we shouldn't use ACPI then, and instead use APM?

If you have an old machine with APM and it satisfies your needs,
then continue using APM on that machine.  However, APM isn't
available on many systems today, and it will be available on
even fewer systems in the future.

> If Linux ACPI could emulate the bugs that Windows has, then ACPI would
> work on Linux on most platforms right away.  That would make=20
> Linux more
> accessible to people.  Linux already has a bunch of hacks to support
> broken hardware which presumably Windows can work around;=20
> this seems to
> be just another one of those.

Where the spec is vague and vendor's BIOS suggests that Microsoft
interprets the spec a certain way, we make linux work that way.  We also
have several places where we accommodate ACPI spec violations because
OEMs shipped them and Windows doesn't catch them -- but we complain
loudly when we see such errors -- otherwise next year's BIOS' will still
have the same errors...
=20
> While it would be great if BIOS' used correct DSDT's, then what would
> happen if those DSDT's didn't work on Windows?  Which version do you
> think they'd ship?  Methinks not the one that works on Linux.

It isn't a choice between a Windows DSDT and a Linux DSDT.  An ACPI spec
compliant DSDT will run on both Windows and Linux.  Note also that ACPI
provides a mechanism where the it can behave differently depending on
the type and version of the OS.

> OTOH, what happens when Microsoft tries to fix their existing bugs --
> they'll either stick with their buggy version forever, or have to
> support several versions, depending on how many bugs are=20
> fixed and when
> they are fixed.  Or you'll end up with some versions of Windows that
> won't run on older or newer laptops.

Yes, I expect that Microsoft will have to maintain certain bug
compatibilty or they will not be able to upgrade Windows on existing
platforms that contains those bugs.  Linux may or may not be able to run
ACPI on those platforms.  This isn't a deal killer, however, as Linux
never did run ACPI on those old platforms -- we don't even enable ACPI
for platforms older than Jan 1, 2001.  If they've run Linux w/o ACPI
since then, it is fine that they continue to do so.  The key is that
_new_ platforms should be ACPI spec compliant and validated with
ACPI-enabled Linux -- and as some Linux distros have enabled ACPI --
this is happening today.

Cheers,
-Len


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
