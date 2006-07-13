From: Luca Capello <luca@pca.it>
Subject: Re: ACPI: SBS in linux-2.6.18-rc1 - Works for me!
Date: Thu, 13 Jul 2006 10:30:20 +0200
Message-ID: <87r70prjoj.fsf@gismo.pca.it>
References: <44B5FCEC.8040903@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha1; boundary="=-=-="
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mbox.unige.ch ([129.194.9.209]:6832 "EHLO mbox.unige.ch")
	by vger.kernel.org with ESMTP id S932440AbWGMIap (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jul 2006 04:30:45 -0400
Received: from conversion-daemon.mbox.unige.ch by mbox.unige.ch
 (Sun Java System Messaging Server 6.2-3.03 (built Jun 27 2005))
 id <0J2C00F01268BK00@mbox.unige.ch> (original mail from luca@pca.it)
 for linux-acpi@vger.kernel.org; Thu, 13 Jul 2006 10:30:44 +0200 (CEST)
Received: from gismo.pca.it ([129.194.56.110])
 by mbox.unige.ch (Sun Java System Messaging Server 6.2-3.03 (built Jun 27
 2005)) with ESMTP id <0J2C005G72B41XH0@mbox.unige.ch> for
 linux-acpi@vger.kernel.org; Thu, 13 Jul 2006 10:30:40 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-=-=

Hello!

On Thu, 13 Jul 2006 09:57:32 +0200, Berthold Cogel wrote:
> Perhaps there should be some logic in the configuration to disable
> the ac and battery modules. They are not needed if SBS is active.
>
> Is it possible to load sbs and i2c-ec automatically together with
> the other ACPI modules? On my Debian system I had to load the
> modules via /etc/modules.conf.

If you use the acpid to manage your ACPI events, please take a look at
/etc/default/acpid:

 # Specify modules to load on acpid's startup
 # MODULES may be uncommented to load "none", contain the string "all"
 # to load all acpi related modules or simply a space seperated list
 # of modules to be probed.
 MODULES="all"

BTW, even if I don't know anything about SBS, I guess it automatically
loads i2c-ec as it depends on it.

Thx, bye,
Gismo / Luca

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEtgSeVAp7Xm10JmkRAne1AJ0UfJqXtig81ajyL24xND9BNApTsACfUcbV
Lr0sPemjlHiqcjMsEcm6ags=
=4/yJ
-----END PGP SIGNATURE-----
--=-=-=--
