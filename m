From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [2.6.24-rc1 regression] AC adapter state does not change after resume
Date: Wed, 31 Oct 2007 07:20:05 +0300
Message-ID: <200710310720.06521.arvidjaar@mail.ru>
References: <200710302324.52822.arvidjaar@mail.ru> <200710302224.55947.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1221205.B19QMBgaJ9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx34.mail.ru ([194.67.23.200]:9210 "EHLO mx34.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbXJaEUJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Oct 2007 00:20:09 -0400
In-Reply-To: <200710302224.55947.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart1221205.B19QMBgaJ9
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 31 October 2007, Rafael J. Wysocki wrote:
> On Tuesday, 30 October 2007 21:24, Andrey Borzenkov wrote:
> > I suspect new ACPI AC adapter code but have to add some printk's to be
> > sure.
> >
> > To reproduce - plug in AC cord, suspend, unplug, resume - kpowersave and
> > sysfs still show AC adapter online. Or other way round.
>
> Is this a resume from RAM or from disk?
>

RAM

> Does 2.6.23 work correctly?
>

yes

--nextPart1221205.B19QMBgaJ9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHKAJ2R6LMutpd94wRAsWuAJ0RxyKl51oExo0gvzO2XIgwTq8MDgCeJvIB
wZk0whT7GR3e/rXD8o5YLIM=
=boh1
-----END PGP SIGNATURE-----

--nextPart1221205.B19QMBgaJ9--
