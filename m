From: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Subject: Failure w/ latest ACPI patch...
Date: Mon, 29 Jul 2002 21:03:41 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729210341.B11837@tarnation.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After applying the 20020726 patch to the 2.4.18 kernel, my Sony
Vaio R505E locked up during boot. It locks up somewhere after
loading the usb controller and before initializing the HID driver
for the usb mouse which was attached.

The version of the kernel was a clean 2.4.18 with just the ACPI
patch and a patch for agpgart to support high-resolution modes
in X on the i830 chipset.

Other than this, I am running a re-configured, re-built kernel
based off of Red Hat's latest 2.4.18-5 kernel sources (which is
basically the 2.4.19 release candidate + ac fixes + tons of other
patches). While this kernel boots up fine, it fails to assign an
IRQ to several devices which should have IRQs of 9 (at least, they
do in Windows- where all the PCI devices are apparently assigned
IRQ of 9, for better or worse).

I notice that in the acpi-patched version, there is some (possibly
BIOS?) message before the actual dmesg output gets printed, and
for at least one of those devices for which an IRQ is not found, it
says it will use IRQ 255. Incidentally, there are 3 USB controllers
on the laptop, and in the RH-based kernel, only 2 get loaded properly,
while the third does not have an IRQ assigned to it (perhaps this is
related to the lock-up during HID initialization in the acpi-patched
kernel).

Unfortunately, because the boot sequence does not complete, I don't
have the output of dmesg available for the failed boot (I can always
attach one for the RH-based kernel, if anyone would like to see that).

BTW, I'm trying to find userland utilities which will allow me to put
the laptop into the varying suspend states (including hibernate-- I
have preserved the Windows partition where the hibernate file is
located). I can't seem to find any one that is ACPI-compatible. Any
pointers?

--=20

Aaron Gaudio                           prothontar @ tarnation.dyndns.org
                   http://tarnation.dyndns.org/~aaron
                            ----------------
  "From fullness, aspect. From aspect, being. From being, emptiness."

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1F5e0ACgkQwXDG7ZQN91epAQCfTEXfUNgR5hbQxnHnk9afAjdW
RTYAniPbbMoR+DJdj9/GdM+BLLEwUWpJ
=1AW4
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=3D31
