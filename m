From: Hartwig Felger <liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] ACPI poweroff fixes for 2.4.26-pre2
Date: Fri, 26 Mar 2004 09:53:38 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403260953.46691.liste@hgfelger.de>
References: <20040309233325.GA22953@alpha.home.local> <20040325230037.GK2179@elf.ucw.cz> <20040326055547.GA26599@alpha.home.local>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040326055547.GA26599-HkMpAodKYdnXX8ko2wsARw@public.gmane.org>
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
To: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Willy, Pavel and S=E9rgio,
I have a problem coming through on this list, altough I am subscribed...

Am Freitag, 26. M=E4rz 2004 06:55 schrieb Willy Tarreau:
> >...
> > IIRC there was patch that made acpi_system_save_state() do nothing at
> > all if !CONFIG_ACPI_SLEEP. I'm arguing thats very wrong.
>
> I 100% agree that it's dirty to call a fake function instead of not
> calling it at all. Indeed, one of my proposed patches removed the
> dependency on CONFIG_ACPI_SLEEP through a simple replacement of
> acpi_system_save_state() with two calls to pm_send_all() which does
> not depend on CONFIG_ACPI_SLEEP. I believe it was cleaner, but it's
> not what is included in BK right now... Here it is for reference.

The regression started with the vanilla-kernels 2.4.25 and 2.6.3, and did n=
ot=20
happen with the versions 2.4.24 and 2.6.2.
So I started to look at the differences and found out, that reverting this =
3=20
lines did revert the regression. I did not try to understand, what I did.

Andy Kleen started recently a new thread "Re: [ACPI] [PATCH] Handle disable=
d=20
local apic better" that made me think... I compiled a vanilla 2.6.4 (withou=
t=20
my patch, and with APIC disabled in config), et voila, everything is happy=
=20
again.

So we need not to look at my patch. I think it would be better to drive=20
forward Andy's work on handling APIC-disable in a correct manner.

Thanks for your discussion ;-)

http://bugme.osdl.org/show_bug.cgi?id=3D2183

Cheers
  hartwig felger

Hartwig Felger informatics

=2D --=20
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
=46or the pulic keys, please visit my page.
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAY++Y9bBoTzOf1pMRAupCAKCSRV0jjisoVYqqn3M17tQgtCMEEwCbBISe
HeQ2UNdvEbmqSkj4v9T/w3o=3D
=3DkBdT
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
