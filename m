From: Gunter Ohrner <G.Ohrner-6V9naDJErT6662+jY7v6MhvVK+yQ3ZXh@public.gmane.org>
Subject: Re: ACPI support for Apollo Pro 133A (2.6.0-test11) ?
Date: Fri, 5 Dec 2003 21:35:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200312052135.11817@mail.CustomCDROM.de>
References: <3FD043CF.10704@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FD043CF.10704-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
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

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Freitag, 5. Dezember 2003 09:37 schrieb Bharata B Rao:
> Does this mean that I can't ever do suspend to RAM or DISK given that
> there is no BIOS update available for this. The BIOS used is Phoenix

Suspend to disk using swsusp does not require BIOS support, it does not eve=
n=20
reqire ACPI at all, so it should just work. (More or less, it's not 100%=20
reliable yet but pretty usable on most machines.)

Greetings,

  Gunter

=2D --=20
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+                   PGP-verschl=FCsselte Mails bevorzugt!                 +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
"The obvious mathematical breakthrough would be development of an easy=20
way to factor large prime numbers."        -- Bill Gates from The Road=20
Ahead, p265
+-+-+-+-+-+-+-+-+-+-+-+-+ http://www.lspace.org +-+-+-+-+-+-+-+-+-+-+-+-+
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/0Ov+0ORHvREo8l8RAk8cAJ4uAd8DIiCDECUvWIwTah+nW8Uo8gCfei0i
A07Kni4/V+/AU3/xBpHie4o=3D
=3DshFS
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
