From: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Subject: Re: [Solved] Re: power-off (Acer TM632)
Date: Tue, 20 Jul 2004 15:30:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040720133027.GA15444@rap.rap.dk>
References: <20040531213726.GA3298@zimen.sk> <20040719175904.GC2690@smeagol> <40FC32DA.9080302@makines.com> <20040719213747.GA26393@rap.rap.dk> <40FC6DAA.6060809@makines.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40FC6DAA.6060809-npIeQ/MgtcxBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Arch. Giovanni Andrea Lucaferri" <lucaferri-npIeQ/MgtcxBDgjK7y7TUQ@public.gmane.org>
Cc: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 20, 2004 at 02:56:10AM +0200, Arch. Giovanni Andrea Lucaferri=
 wrote:
> mhh, no there isn't, but it's a good idea!
>=20
>=20
> Keld J=F8rn Simonsen ha scritto:
> >On Mon, Jul 19, 2004 at 10:45:14PM +0200, Arch. Giovanni Andrea Lucafe=
rri=20
> >wrote:
> >
> >>Hi Emma, mizu, hgfelger,
> >>it works! I've isolated the problem.
> >>I only had CONFIG_RTC=3DY in my kernel and that was the only problem.
> >>I've set
> >># CONFIG_RTC is not set
> >>and everything works now.
> >
> >
> >Is there a place where you can configure parameters for your machine
> >model? Eg my laptop will need noapic to function. I can of cause set
> >that parameter, but novices would not know this, and it would be bette=
r
> >if the make and model be detected and the parameter always set.
> >This is, I wonder if there is a repository for the make and models in
> >the kernel.

Where are the specific files for the DSDT tables? Are they taken from
the BIOS? Or is there a repository in the Linux kernel?

I understand that there are a number of fixes to buggy DSDT tables.
Why not include the fixes for all the makes and models
in the kernel, and then have it loaded at boot time?=20

Best regards
Keld


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
