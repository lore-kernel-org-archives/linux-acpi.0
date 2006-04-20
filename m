From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: how to back from suspend without shutdown
Date: Thu, 20 Apr 2006 11:20:59 +1000
Message-ID: <200604201121.03452.ncunningham@cyclades.com>
References: <1145454577.14935.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1261563.Mmq0F9tlP0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from b3162.static.pacific.net.au ([203.143.238.98]:39814 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750713AbWDTBWq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Apr 2006 21:22:46 -0400
In-Reply-To: <1145454577.14935.13.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: acpi devel <linux-acpi@vger.kernel.org>

--nextPart1261563.Mmq0F9tlP0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 19 April 2006 23:49, Sergio Monteiro Basto wrote:
> Hi everybody,
> I have a new laptop one HP Compaq NX6110 , that works quite well with
> suspend and hibernation.
>
> But after suspend , how I bring back computer ?, the only key that I
> know is power button, but after press power button and laptop wake-up,
> Begins the shutdown process because is triggered the power button
> shutdown .
> any ideas ?
>
> Other question klaptop let me choose performance profile:
>  userspace or performance, which one is better ? and why ?
>
> Klaptop allows also to define CPU throttling which is in 00% but I can
> choose 0,12 25, 37, 50, 62, 75 and 87. What is the propose of this
> settings ?
>
> thanks in advance ,

Try building acpi button support as a module and unloading it during the=20
cycle.

Regards,

Nigel

--nextPart1261563.Mmq0F9tlP0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBERuH/N0y+n1M3mo0RAi6sAJ9tPEulEgVYyn12OFySWtCEXnuFYgCg6OPl
wF2vpCADCppjrGVDvxhDZnc=
=O0u/
-----END PGP SIGNATURE-----

--nextPart1261563.Mmq0F9tlP0--
