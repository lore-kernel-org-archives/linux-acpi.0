From: Pierre Ossman <drzeus-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: suspend-to-ram hangs on HP NX7010
Date: Tue, 15 Jun 2004 00:58:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40CE2DB0.9050208@drzeus.cx>
References: <40C6FD44.7090606@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_athena.drzeus.cx-26496-1087253942-0001-2"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40C6FD44.7090606-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_athena.drzeus.cx-26496-1087253942-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Some updates.
I've been fiddling around with this during the weekend but haven't made 
much progress. Removing all modules, in case they were causing problems, 
didn't help.
I have, however, pinpointed where in the kernel it hangs. It stops while 
writing the SLP_EN bit. I guess that's where it should actually go into 
sleep mode. The bit is set in two registers but the hang is when it 
writes the first one. Changing the order of them still causes the first 
one to hang (B in that case). I also tried combining SLP_TYPx and SLP_EN 
but again, hang during the first write.
I'm out of ideas now so I *really* need some tips on what to try next. 
There is nothing more to debug around the crash-point so the problem 
must be somewhere during the preparation.

Rgds
Pierre

--=_athena.drzeus.cx-26496-1087253942-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAzi2z7b8eESbyJLgRAuukAKDRuLiJUY6Z31j2WZ1VYRcjXysxCQCgsTcK
BuEsXR3Xrq+frvWLT8eXdc8=
=Z3dX
-----END PGP SIGNATURE-----

--=_athena.drzeus.cx-26496-1087253942-0001-2--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
