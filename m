From: Luca Capello <luca@pca.it>
Subject: [BUG?] Critical temperature shutdowns on ThinkPad X60 1706-GMG
Date: Thu, 05 Feb 2009 18:29:25 +0100
Message-ID: <878wokssga.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
 protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from victor.unige.ch ([129.194.9.224]:64000 "EHLO victor.unige.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585AbZBES3p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Feb 2009 13:29:45 -0500
Received: from gismo.pca.it ([129.194.56.110])
 by victor.unige.ch (Sun Java(tm) System Messaging Server 6.3-5.02 (built Oct
 12 2007; 32bit)) with ESMTPSA id <0KEL00M1TSLHA100@victor.unige.ch> for
 linux-acpi@vger.kernel.org; Thu, 05 Feb 2009 18:29:41 +0100 (MET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ML Linux-ACPI <linux-acpi@vger.kernel.org>

--=-=-=

Hi there!

In July 2008 I reported a problem about critical temperature shutdowns:

  http://news.gmane.org/find-root.php?message_id=%3c87zlnyv14h.fsf%5f%2d%5f%40gismo.pca.it%3e

Since I was not the only one experiencing it, reading the mailing list I
had the impression it had been solved since then.

And indeed I do not remember I have experienced it again.  However, the
last week it reappeared, probably because in the meantime I have not
used my laptop at full power :-(

Anyway, here we are:

- I got 6 "Critical temperature reached (128 C), shutting down"
  experiences since January 30th

- when I know that temperature could rise (e.g. using QEMU to build
  Debian packages for armel), I usually set the fan at maximum speed

    $ echo -n "level full-speed" >/proc/acpi/ibm/fan

  However, the last time (10 minutes ago) happened even with that
  setting and my setup was:

  * my usual Emacs session
  * Conkeror
  * a git-buildpackage process (basically building a Debian package from
    a Git repository and inside a chroot)
  * the Openmoko FreeRunner was plugged to the left USB port and charging
  * on one of the right port there was an Eutronsec SIMReaderCombo,
    basically an OmniKey CardMan 6121 USB SIM-sized smartcard reader
    coupled with a 2GB flash memory (in my case this is SLC, more
    information at http://www.eutronsec.it/ )
  * the laptop is placed on a scientific laboratory desk and the airflow
    from the fan grid is free to circulate
  * the laptop is on AC power with no battery inserted

- the last was on Debian kernel 2.6.28-1~experimental.1~snapshot.12674;
  since I am preparing for FOSDEM, I do not have time right now to test
  a vanilla kernel, but I will do starting from next Monday.  Which
  kernel version should I test first, 2.6.28.3?

That is all, I think.  Feel free to ask for more inforation/test.

Thx, bye,
Gismo / Luca

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAQECAAYFAkmLIfYACgkQZwOMsWhEDTPh/QQA0YOjHznp7aA20mBv2MUfnPuR
QB3hchfcLy/ExOQGN8gBYsRBBMsBTisfniVHbuvFy6EbbU1l9/HIi74a85V8tga6
TnkkqsRntNhIO9P4mXjXz8sZd+Z7qVY7iETwIE87pLDLUglqe+QQWFOHLsaeMtRU
DM1kZpcmTN3tqzQtHzs=
=+uim
-----END PGP SIGNATURE-----
--=-=-=--
