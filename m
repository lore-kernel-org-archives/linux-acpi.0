From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: 2.4.24 patch apply failed on vanilla kernel
Date: 09 Jan 2004 05:19:29 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1073643569.2447.66.camel@dhcppc4>
References: <20040107134658.5afa9142.acpi@thermoman.de>
	 <20040107155325.5bfceba0@tethys>
	 <20040107163907.391c146e.acpi@thermoman.de>
	 <20040107165054.1fbfc829@tethys>
	 <1073505678.7422.24.camel@darkstar.portugal>
	 <20040107225650.388f96d4@tethys>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040107225650.388f96d4-qdKmdXVU2OY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: wwp <subscript-GANU6spQydw@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Two problems here -- both caused my me -- both now fixed.

1. I mis-merged the line in smpboot.c
when I first found and fixed that bug i replaced NR_CPUS
with MAX_APICS, which made perfect sense for the non-numa
case where MAX_APICS is 16.  wli checked in the BITS_PER_LONG
fix (32) and I mistakenly over-wrote it -- now restored.

2. Marcelo re-named the 2.4.24 bk tree to be 2.4.25
and quickly released a new 2.4.24 tree with just a couple of
changes.  Until tonight, my ACPI patch on kernel.org was
against the 'old' 2.4.24.  I've since updated both the trees
at http://linux-acpi.bkbits.net/ as well as the plain patches
up on http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches

Let me know if I missed anything.

thanks,
-Len

On Wed, 2004-01-07 at 16:56, wwp wrote:
> Hi S=E9rgio Monteiro Basto,
>=20
>=20
> On 07 Jan 2004 20:01:17 +0000 S=E9rgio Monteiro Basto <sergiomb-2XwKdJGMC1E@public.gmane.org=
.pt> wrote:
>=20
> > I think=20
> > Full version of kernel2.4.24 have all apci patches updated=20
>=20
> Forgotten to say that 2.4.24 doesn't include any change around acpi sin=
ce
> 2.4.23, it was only a security fix release (see the Changelog).
>=20
>=20
> Regards,



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
