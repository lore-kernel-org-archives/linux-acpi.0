From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] Fix not loading acpi-cpufreq driver regression
Date: Mon, 25 Jun 2012 15:45:24 +0100
Message-ID: <1340635524.741.94.camel@deadeye.wl.decadent.org.uk>
References: <201206251300.10957.trenn@suse.de>
	 <1340633114.741.92.camel@deadeye.wl.decadent.org.uk>
	 <201206251639.39892.trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ddgPP4GDqyz2JZJRktkg"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42294 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755632Ab2FYOpc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jun 2012 10:45:32 -0400
In-Reply-To: <201206251639.39892.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, stable@vger.kernel.org, wallak@free.fr, len.brown@intel.com, Jiri Slaby <jslaby@suse.cz>


--=-ddgPP4GDqyz2JZJRktkg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 16:39 +0200, Thomas Renninger wrote:
> ...
> > > Such platforms may be rare, but do exist. This problem has been
> > > observed on a:
> > > HP Proliant BL280c G6 blade
> > > This patch restricts the introduced workaround to platforms
> > > with nr_cpu_ids <=3D 1.
> >=20
> > This is not the correct way to submit a patch to stable.  See
> > Documentation/stable_kernel_rules.txt.
> I guess I should add
> CC: stable@vger.kernel.org
> in the signed-off area, not in the mail header?
[...]

Right.  You may put it in the mail header, but it *must* be in the
commit message so that it can be picked up after it lands in Linus's
tree.

Ben.

--=20
Ben Hutchings
Lowery's Law:
             If it jams, force it. If it breaks, it needed replacing anyway=
.

--=-ddgPP4GDqyz2JZJRktkg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAT+h5hOe/yOyVhhEJAQpHcA//ZbKRVQTFMoG9FBn9TT3WR22Hv7E/abg+
UPBhIhpHKDSfcpMMfr/mnn61C7Za2lf4a/yEuZ8KX7b1LxtmTe3J+HiubZlq9Xqx
wPalfEqafN8Hbwyn2tBSDosdpxZ166MDHlTBWReFobBQBrSSFEftdnum0A7DEX5R
Qh39p8ryEDB1avuOEVy1fy/lLPGqBKSdlb4Lm/nIGz77+4FNhuigAfR0kuV+ni0+
4pdVJHVsOg+yfXPCyZ0GwSyoO6udY/ziQZFJbYH+cWs9WLqDbklUhS9d7hgJeH57
yfayn3ypvlRnTzKpdHDpeP/OeQUBtTh4uT5SLe6LvKT/vIpQUwZFddN/nvT897v0
s4zoNs+L3KFeHFwmuSbXdimMYAhQohBVyEIdQ4jdRAiogYEvRydgfMnmbRPv7noN
Qez5p4Uc4EUejzP8ODCbAc9h+EWMnr+l+vFLm18Y32f3xdCNwX2D6DhACiudNDCw
xQ3RKsWsuuB/c3AHbQ4fNjH6QU8TSv8LotHQ9TZyg/s8lT3yj9EeolvblypelJBy
5PZSO41pt8LmgbLJG1YtZIaHs9yC8FJ767DdMgJBw1cSfcPDsXhmIQROeQrSl0Oc
LfE86lrKZYYovHld6JoWsypUD6gMT11MHe8k34v26b2P09jizOazugHJgAb1CGNV
VJC3SUAkgT4=
=/HZD
-----END PGP SIGNATURE-----

--=-ddgPP4GDqyz2JZJRktkg--
