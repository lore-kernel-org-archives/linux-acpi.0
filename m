From: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Re: Intel Centrino and Linux
Date: 08 May 2003 08:33:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87n0hyx7zd.fsf@lapper.ihatent.com>
References: <200305031848.04583.nbellm@gmx.de>
	<1051979022.24562.24.camel@dhcp22.swansea.linux.org.uk>
	<m21xzb9vig.fsf_-_@tnuctip.rychter.com>
	<1052308970.3061.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1052308970.3061.4.camel-2MMpYkNvuYAXoXS6vNje7nviChZXdy279dF7HbQ/qKg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> writes:

> On Mer, 2003-05-07 at 06:27, Jan Rychter wrote:
> > I'm facing this kind of decision (buying a new laptop soon, possibly the
> > Toshiba DynaBook SS S7/290LNKW) -- so, does the above mean that Intel
> > Centrino is not Linux friendly?
> 
> Currently yes. On some of them the APM works well enough to suspend and
> do battery reporting but not to do CPU speed control stuff (at least not
> from battery life measurement).
> 
> > I've already ruled out all Compaq notebooks thanks to the multiple
> > problem reports seen on this list (hi HP/Compaq! 
> 
> The newer Compaq ACPI seems to work well (eg the z9xx series laptops).
> They do need an ACPI kernel and have some other quirks which needed
> Linux fixing (and which showed up Linux bugs too)
> 

Having used Compaq laptops for a long time (since first PII-350 model
of the Armada M700 and every model since in the M700 series and now
the Evo N800c), I'd say that these laptops are generally working very
nicely with linux. Even ACPI, which looked dire a while back, now
works like a charm with the Evo I have, and run Linux as the host OS
on it 98% of the time, the other two are spent in XP playing Ghost
Recon ;)

As is being discussed in another thread here, are the issues of how to
be able to roll your own custom DSDT into a kernel more easily, to
make ACPI work more readily for a wider audience.

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+ufpTCQ1pa+gRoggRAvXvAKCGY/ezgolnjeOcRSPhk8h61ACvWgCghgzk
l8OpMNwW1pGr2WVbvO3p+HU=
=lvQ0
-----END PGP SIGNATURE-----


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
