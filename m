From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Thermal managment broken
Date: Wed, 18 Sep 2002 19:00:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020918190047.C921@brodo.de>
References: <20020916163600.GA11617@elf.ucw.cz> <20020916225518.B2247@brodo.de> <20020918102555.GB18221@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020918102555.GB18221-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>; from pavel-+ZI9xUNit7I@public.gmane.org on Wed, Sep 18, 2002 at 12:25:55PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Pavel,

On Wed, Sep 18, 2002 at 12:25:55PM +0200, Pavel Machek wrote:
> > Additionally, it might be better to specify a "starting" and
> > "stopping" trip point - so that you don't have a fan going
> > on-off-on-off-on-off repeatedly. (IIRC someone complained about this =
a few
> > months ago on this list). But even without this "feature", I'd like t=
o see
> > the user-specified trip points in the acpi patch.
>=20
> I believe this is orthogonal. You need to do two thresholds even
> without user help, so it needs to be solved some other way.

IIRC, that's something the DSDT has to provide - the trip points should
change (right in the DSDT) when the fan is turned on or off, respectively.
Many DSDTs don't do this, and this is an annoyance, but except some basic
"sanity checking" (for example, having a minimum fan-on period of x
seconds), such a policy interface should either provide such a two-thresh=
old
policy itself (turn-off=3D=3Duser-value - 5=B0), or get direct user-input=
 for it.

	Dominik


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
