From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: RE: Working around bugs in ACPI BIOS [was Re: DSDT in initrd]
Date: Mon, 19 May 2003 22:11:25 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030520041129.3CD3EF7863@voldemort.scrye.com>
References: <F760B14C9561B941B89469F59BA3A847E96EA5@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96EA5-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Andrew" == Andrew Grover <Grover> writes:

Andrew> Against 2.4-acpi-latest.  Completely untested. Does this work?

It appears to work fine here on my compaq presario 2800t. 

ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?
ACPI: Ignoring * in _HID. Is this a Compaq?

With the stock acpi-20030512-2.4.21-rc2.diff.gz patch + your patch
below eveything looks to work fine. Battery status, lid, pretty much
any function. 

Thanks, 

Andrew> -- Andy

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+yarw3imCezTjY0ERAljZAJ4scPAbCMgkIqQH6qRArgninl1c7gCfYvXd
ZtsNJGRCJPdEX4XhlDiX2/g=
=Kh0B
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
