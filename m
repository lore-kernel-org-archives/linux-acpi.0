From: Luca Capello <luca@pca.it>
Subject: Critical temp shutdowns on ThinkPad X60 1706-GMG (was Re:
 [ibm-acpi-devel] Avoid critical temp shutdowns on specific ThinkPad T4x(p) and
 R50p)
Date: Thu, 31 Jul 2008 11:44:46 +0200
Message-ID: <87zlnyv14h.fsf_-_@gismo.pca.it>
References: <200807301556.01815.trenn@suse.de>
 <20080730175227.GA13850@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
 protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from victor.unige.ch ([129.194.9.224]:53380 "EHLO victor.unige.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbYGaKIG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 06:08:06 -0400
Received: from gismo.pca.it ([129.194.56.110])
 by victor.unige.ch (Sun Java(tm) System Messaging Server 6.3-5.02 (built Oct
 12 2007; 32bit)) with ESMTPSA id <0K4V00J0872VXU00@victor.unige.ch> for
 linux-acpi@vger.kernel.org; Thu, 31 Jul 2008 11:44:55 +0200 (MEST)
In-reply-to: <20080730175227.GA13850@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, lenb@kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Henrique!

On Wed, 30 Jul 2008 19:52:27 +0200, Henrique de Moraes Holschuh wrote:
> No X models have these issues? (the X models always had a slightly more
> advanced BIOS, so it is indeed possible that the bug was never on that
> branch of the code).

I've experienced critical temp shutdowns on my X60, model 1706-GMG, BIOS
7BETD5WW (2.16).  The first I've in my /var/log/syslog dating Mar 31st
and was on a Debian sid-amd64, kernel:

  2.6.25-rc7-amd64 (Debian 2.6.25~rc7-1~experimental.1~snapshot.10974)
  (waldi@debian.org) (gcc version 4.1.3 20070718 (prerelease) (Debian
  4.1.2-14+1)) #1 SMP Thu Mar 27 07:59:01 UTC 2008

Since then, I had 18 more shutdowns caused by critical temperature, with
different kernels, up to the latest 2.6.26 (still Debian kernels, not
upstream ones).

I've now a test case which shutdowns my X60: it's a `darcs pull` process
which hangs and then the temperature raises until 128=C2=B0C, so the laptop
shutdowns.

If anyone has any specific suggestion, starting from next Wednesday, Aug
6th, I can perform tests on a clean Debian sid-amd64 (if needed, I can
install an i386) and with vanilla kernels.

Thx, bye,
Gismo / Luca

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAQECAAYFAkiRiY4ACgkQZwOMsWhEDTPyfAP+LO436reecxgm3VBkBp5rvNj8
4AbUcUqA0aD/eu25vCAWc//WPfDn3PFqIyqqXpEl2c61h2SS1Ouv65oHyfOF12YY
iS+NWTzFlVvyp2LquzmG4zxLPfR/IX6GUIIOC7xoBm+F6roogvgTHhUxc3QIBR2L
B4a0/Ba4bXKTW/azZw4=
=VWBO
-----END PGP SIGNATURE-----
--=-=-=--
