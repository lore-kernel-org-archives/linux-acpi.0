From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Request for additional arm64 branch in linux-next
Date: Thu, 26 Mar 2015 11:10:55 +1100
Message-ID: <20150326111055.273aa644@canb.auug.org.au>
References: <20150325172002.GN24636@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wQEtbBlWIOHjlL5gTPx5.xe"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:60587 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbbCZALB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Mar 2015 20:11:01 -0400
In-Reply-To: <20150325172002.GN24636@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, grant.likely@linaro.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, msalter@redhat.com

--Sig_/wQEtbBlWIOHjlL5gTPx5.xe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Wed, 25 Mar 2015 17:20:03 +0000 Will Deacon <will.deacon@arm.com> wrote:
>
> We've got a series of patches introducing ACPI support for arm64 that
> are tentatively targetting the 4.1 merge window. Whilst there are
> face-to-face discussions set to happen in the next day or so around this
> topic, could you please pull this into linux-next under the assumption
> that we decide to go ahead for mainline inclusion?
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/=
acpi
>=20
> I've kept the series separate from the usual arm64 branch (for-next/core)
> but they merge without conflicts. Merging with today's next, I see two
> trivial Kconfig conflicts (resolution below).

Added from today (and thanks for the hints).  Will this be merged via
another tree, or go directly to Linus?

> I'll let you know when the branch is no longer needed.

Excellent.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/wQEtbBlWIOHjlL5gTPx5.xe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVE06TAAoJEMDTa8Ir7ZwVevgP/RWbH8tGiFS5vOrPDca7qICw
PEozvmYlgn0JGcw5yExe3g3hMayWxRhPFcIEieT+bZQa0pnDwZpqo5TTzg+0oR6k
nnzL+j5lgAUFA56HFBKjllcDUBFEY5SiQMhIVs2M6Dm4H44xGiDeaO10jgd8C7aY
LoAvJMN1CT07Q1TCdW9lunNVM9VE4Y48CjUnFqsDNuh23uDsB5mH6mADxiJnvmv9
PAJ1Sz2fgaWuKyJ9+85y4pLnN9Y3XyK8WfZ40ISLAeK36KGIrf+6Br69zSfCmFzA
VP2FcR4a+Ht5xeoECD4k70g6NNG9NvbFmyM1+iDJlMjnGwiUMZH3wbiEpP7uqfYf
a8werexFOlzDPJW24sCvnWAMCofu1VZh5g79ieLJVlUVLilkPWr23ZWyb5jk33TM
f+MIACC8nwtuZCNp31jsv9SrK0ICM7jxuiy/ok6MGZP0Ue9QWNsJAD7pW7LOve2o
cTQlW8gTurZwxW0HxFT7VDmiRW+c0hBFhFvdiMXTqOLvuCPwlJsWnFZCH62n6fk/
Z9YFjhkVnfsMOEhdDqxY8LIMP9UuTJ6Hf5JYqEIyyXwZY9Ob0suAeWv+YAJbZa24
psH1VFhzLCUw2O2UAKvRMDy0URklhmEJVFwMSyj5sTqeTP1fc2hdmK8iE25YOTZf
9CsbZxjcufQF7wWLZSU3
=AKVs
-----END PGP SIGNATURE-----

--Sig_/wQEtbBlWIOHjlL5gTPx5.xe--
