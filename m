From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [2.6.24-rc1][BUG] Oops on battery removal
Date: Fri, 2 Nov 2007 14:26:40 +0100
Message-ID: <200711021426.40728.eike-kernel@sf-tec.de>
References: <200711020803.49608.eike-kernel@sf-tec.de> <200711021250.03555.eike-kernel@sf-tec.de> <472B1F53.5080902@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1403349.ezhppFNXXx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:55570 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbXKBN0q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Nov 2007 09:26:46 -0400
In-Reply-To: <472B1F53.5080902@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>

--nextPart1403349.ezhppFNXXx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Alexey Starikovskiy wrote:
> Rolf Eike Beer wrote:
> > Alexey Starikovskiy wrote:
> >> Rolf Eike Beer wrote:
> >>> Rolf Eike Beer wrote:
> >>>> Hi,
> >>>>
> >>>> this happened while I removed my battery on bootup. Complete dmesg is
> >>>> attached. Kernel is 2.6.24-rc1-git of yesterday (last commit was
> >>>> d919fd433b5823d1cf9d0688eb2eec183de9b74c).
> >>>
> >>> Ok, I found out that it has nothing to do with the actual removal as it
> >>> seems. When I start the laptop with battery already detached I get the
> >>> same error.
> >>
> >> Please check if this patch helps.
> >
> > It made things worse:
>
> How about this patch?

Ehm, that is the same patch as before!

Btw: it has an empty From: line

Eike

--nextPart1403349.ezhppFNXXx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBHKyWQXKSJPmm5/E4RAiihAJ9CcFxF6eiD96ytMRkqTCPdTG18nACfYqGm
rRLhKx/Zam2tY3x8uovp2ZU=
=lelq
-----END PGP SIGNATURE-----

--nextPart1403349.ezhppFNXXx--
