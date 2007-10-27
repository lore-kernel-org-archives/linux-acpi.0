From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [2.624-rc1 regression] lost battery information
Date: Sat, 27 Oct 2007 20:49:10 +0400
Message-ID: <200710272049.11969.arvidjaar@mail.ru>
References: <200710262024.06012.arvidjaar@mail.ru> <200710271855.52866.arvidjaar@mail.ru> <47235727.30808@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2516943.8kO8jsetPJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx34.mail.ru ([194.67.23.200]:20598 "EHLO mx34.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbXJ0QtR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 27 Oct 2007 12:49:17 -0400
In-Reply-To: <47235727.30808@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Frans Pop <elendil@planet.nl>

--nextPart2516943.8kO8jsetPJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 27 October 2007, Alexey Starikovskiy wrote:
> As you wish... :) Please check the attached patch.
>

Not sure why you need to reimplement acpi_extract_package, but ...

Tested-by: Andrey Borzenkov <arvidjaar@mail.ru>

--nextPart2516943.8kO8jsetPJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHI2wHR6LMutpd94wRAprvAJ4wX4OVrjqYEfqEyJJpc+ZksinWlgCeL8Ly
GnV7/diYr7hk8BJTInEmxuI=
=u/P7
-----END PGP SIGNATURE-----

--nextPart2516943.8kO8jsetPJ--
