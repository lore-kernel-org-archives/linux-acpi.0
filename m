From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI not working - worked with earlier versions
Date: Wed, 23 Oct 2002 09:50:49 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF62@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?=27Hanno_B=F6ck=27?= <hanno-Mmb7MZpHnFY@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Hanno B=F6ck [mailto:hanno-Mmb7MZpHnFY@public.gmane.org]=20
> Today i reinstalled Linux on my Athlon 700 System.
> With earlier versions of acpi, i had no problems. but now, i=20
> get the following error:
> >ACPI: Vendor "VIA694" System "AWRDACPI" Revision 0x0 has a=20
> known ACPI >BIOS problem.
> >ACPI: Reason: Bogus table. This is a non-recoverable error
>=20
> Well, I had working acpi before, so why this error?
> I don't know if everything worked, but i could definitely=20
> start acpid and shutdown my pc with the power-button. This is=20
> no longer possible, since it seems that this "error"-check=20
> disables acpi completely.
> I don't have an acpi-proc-interface and my pc will not shut=20
> down on halt.

Looks like there is a too-generic DSDT signature in the blacklist. You =
can
remove it on your system for now, and I will remove it for the next =
release.

BTW, I have now been convinced that ACPI table signatures are not =
sufficient
to differentiate between systems that work and systems that don't. We =
need
to expand blacklist.c to use DMI or other differentiating factors to =
apply
its rules.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
