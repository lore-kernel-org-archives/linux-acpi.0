From: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Subject: Re: Failure w/ latest ACPI patch...
Date: Tue, 30 Jul 2002 22:14:52 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730221452.A22709@tarnation.dyndns.org>
References: <20020729210341.B11837@tarnation.dyndns.org> <20020730165433.A1445@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020730165433.A1445-JhLEnvuH02M@public.gmane.org>; from devel-JhLEnvuH02M@public.gmane.org on Tue, Jul 30, 2002 at 04:54:33PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Linux ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And lo, upon Tue, Jul 30, 2002 at 04:54:33PM +0200, Dominik Brodowski spake=
th thusly:
> Hi,
>=20
> Intersting problem you're reporting here:
>=20
> On Mon, Jul 29, 2002 at 09:03:41PM -0400, Aaron Gaudio wrote:
> > I notice that in the acpi-patched version, there is some (possibly
> > BIOS?) message before the actual dmesg output gets printed
> Even before "uncompressing kernel...." ???=20

Sorry, I should have been clearer. I meant that it froze up before
I could save the dmesg output to a file to attach. I could see the
actual dmesg output on screen.

>=20
> , and
> > for at least one of those devices for which an IRQ is not found, it
> > says it will use IRQ 255.
> That's BAD. IRQ 255 does not exist on any known laptop, I dare to say.=20
>=20
> > Unfortunately, because the boot sequence does not complete, I don't
> > have the output of dmesg available for the failed boot (I can always
> > attach one for the RH-based kernel, if anyone would like to see that).
> Could you pass pci=3Dnoacpi to the ACPI kernel, and try if it boots, plea=
se?
>

Actually, thanks to advice from Ted Serreyn, it turns out the problem
was that the ACPI was in fact working :) The USB controller that previously
was not getting loaded with an IRQ was now (IRQ 9, like everything else),
and that USB controller happened to be the one for the memory stick on
the laptop. The memory stick apparently is not supported yet in the
stock kernel. Ted turned me on to a patch to enable this device, and,
upon applying it, I was able to complete the boot successfully. Now I'm
fighting to get my DVD drive to be recognized over FireWire :)
=20

--=20

Aaron Gaudio                           prothontar @ tarnation.dyndns.org
                   http://tarnation.dyndns.org/~aaron
                            ----------------
  "From fullness, aspect. From aspect, being. From being, emptiness."

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1HSBwACgkQwXDG7ZQN91fWPQCgjQzt1+rirogysS4Zl6b6+5d9
eowAoJnQycfTkVhIeK98qf1+cA99wf4q
=7bzC
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=3D31
