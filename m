From: Nathan Conrad <conrad-aYgNHrD+FxfR7s880joybQ@public.gmane.org>
Subject: SSDT on Sony VAIO
Date: Fri, 10 Jan 2003 21:42:06 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030111024206.GA9493@bungled.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am using kernel 2.5.55 on a Sony Vaio PCG-FXA49. Right now,
/proc/acpi/processor/CPU0/info says that performance management is
not available. My CPU (1.2 GHz mobile Athlon4) supports PowerNow, and
I would expect this would qualify as performance management.

I have looked at my ACPI tables and there is a listing of 5 P-states
in my SSDT (1200 MHz,1000,800,600,500 MHz).

Why are these not listed in my /proc/acpi/processor/CPU0 directory?

Does the current Linux ACPI driver look at the SSDT tables, or does it
only look at the DSDT for AML?

One thing to note is that my DSDT has a very minimal \_PR section:

    Scope (\_PR)
    {
        Processor (CPU0, 0x01, 0x00008010, 0x06) {}
    }

The SSDT has a more filled out one. I do not know how to disassemble
it (iasl does not know how to handle a SSDT).

-Nathan

--
Nathan J. Conrad   (XXX)-687-7449    https://bungled.net/
312 Moore Hall // UNC-C // Charlotte, NC 28223
GPG: F4FC 7E25 9308 ECE1 735C  0798 CE86 DA45 9170 3112
--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+H4R+zobaRZFwMRIRAkgFAJ4pr7VX75d2AhdUB1SfM4atRTeTuACfV+D3
GRliRP5XjgL3javKrlxefH8=
=m59W
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
