From: Chris Howells <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Subject: Re: Present rate from proc-fs
Date: Sun, 15 Dec 2002 23:08:30 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212152308.30840.chris@chrishowells.co.uk>
References: <200212151709.58541.jonasge@gmx.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200212151709.58541.jonasge-hi6Y0CQ0nG0@public.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jonas Genannt <jonasge-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On Sunday 15 December 2002 16:09, Jonas Genannt wrote:
> But some notebooks (Toshiba Satellite 3000-514) does not offer the present
> rate in the proc-fs.
> My program needs the value!! How I program that I could calcualte the
> remaining time without the present rate?
>
> Or could I calcualte the present rate from the other values?

Well, you could monitor the remaining capacity, and see how long it takes to 
go down and by how much.

- -- 
Cheers, Chris Howells -- chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org, howells@kde.org
Web: http://chrishowells.co.uk, PGP key: http://chrishowells.co.uk/pgp.txt
KDE: http://www.koffice.org, http://printing.kde.org, http://usability.kde.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9/QtuF8Iu1zN5WiwRAgJYAKCaZ+X7pbXj7+2zmNcOT7/2rs+0+wCfYRPF
DffyEyYFZsgIAX5jbAFxzLs=
=OrdS
-----END PGP SIGNATURE-----



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
