From: Yves-Alexis Perez <corsac@debian.org>
Subject: Huge wakeups number from i1915
Date: Tue, 02 Dec 2008 17:48:21 +0100
Message-ID: <1228236501.3873.2.camel@hidalgo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vKFTqnD7YfR1xNBGHsrG"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:36100 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbYLBQsM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Dec 2008 11:48:12 -0500
Received: from hidalgo.corsac.net (ARennes-358-1-82-147.w90-54.abo.wanadoo.fr [90.54.17.147])
	by molly.corsac.net (Postfix) with ESMTP id 07F0E82E44
	for <linux-acpi@vger.kernel.org>; Tue,  2 Dec 2008 17:48:10 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


--=-vKFTqnD7YfR1xNBGHsrG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, I have a problem with 2.6.28-rc6-00209-g6a12141. Not sure if I
should mail to acpi@ or drm.

=46rom time to time (I noticed this resuming from hibernation, but it just
appeared without that), I get huge wakeups from i915 module, and huge
power consumption on my Thinkpad T61 with intel 965:

corsac@hidalgo: sudo powertop -d
PowerTOP 1.10    (C) 2007, 2008 Intel Corporation=20

Collecting data for 15 seconds=20


Cn	          Avg residency
C0 (cpu running)        (60,9%)
C0		  0,0ms ( 0,0%)
C1		  0,0ms ( 0,0%)
C2		  0,0ms (39,1%)
C4		  0,0ms ( 0,0%)
P-states (frequencies)
Wakeups-from-idle per second : 41769,4	interval: 15,0s
Power usage (ACPI estimate): 33,1W (0,9 hours)=20
Top causes for wakeups:
  99,8% (85712,2)       <interrupt> : i915@pci:0000:00:02.0=20


Not sure what I can do about this but it's a bit painful when running on
battery :/

If I need to provide more info or ask on another list, please say so :)

Cheers and thanks,
--=20
Yves-Alexis

--=-vKFTqnD7YfR1xNBGHsrG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk1ZtEACgkQTUTAIMXAW67JlACfUKq3/LasylFVAQvxvJ6OXfrq
xwIAoItdV2JvGA21XyxKfZOYSTUco5x4
=FA9t
-----END PGP SIGNATURE-----

--=-vKFTqnD7YfR1xNBGHsrG--
