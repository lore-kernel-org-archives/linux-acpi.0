From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: ACPI + 3c556 - the saga continues
Date: Wed, 16 Jul 2003 13:21:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030716112140.GE4313@enigma.daemon.sh>
References: <3F152331.9080803@relex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F152331.9080803-343whMTK1pU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello yaroslav..

* Yaroslav Rastrigin <yarick-343whMTK1pU@public.gmane.org> [2003-07-16 12:42 +0200]:

> What conditions should be met for ACPI event to appear in /proc/acpi/even=
t=20
> ?
> When I'm manually triggering LID microswitch ,f.e,  I'm seeing lot's of=
=20
> ACPI
> activity in logs (with upped debug level), and I could see _LID method
> executed, but nothing appears in /proc/acpi/event, and I can't make acpid
> to suspend machine when LID is closed.
> Moreover, there are no events in /proc/acpi/event at all, alhough ACPI
> subsystem notices and handles them. Did I screwed something in my setup ,=
=20
> and
> if yes, then what to look for ?

do you know of acpid? check
http://acpid.sourceforge.net
this daemon usually logs output from /proc/acpi/event to /var/log/acpid
(among other things).

and how did you try to access p/a/event? a "tail -f" does not work, but
"cat" does.

hth,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FTVEreHfL3pi+bQRAhXlAJ92Bbe1fsy2tDzxAYklua6UW0AL0gCghYWA
bV4oBM8fPILPTUXoskluVVo=
=4fcG
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
