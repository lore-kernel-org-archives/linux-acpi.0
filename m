From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] Fix not loading acpi-cpufreq driver regression
Date: Mon, 25 Jun 2012 15:05:14 +0100
Message-ID: <1340633114.741.92.camel@deadeye.wl.decadent.org.uk>
References: <201206251300.10957.trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-wsHH99wP9rPfReXfHBOj"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41966 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756922Ab2FYOF1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jun 2012 10:05:27 -0400
In-Reply-To: <201206251300.10957.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, stable@vger.kernel.org, wallak@free.fr, len.brown@intel.com, Jiri Slaby <jslaby@suse.cz>


--=-wsHH99wP9rPfReXfHBOj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 13:00 +0200, Thomas Renninger wrote:
> ACPI processor: Only blindly return apic id 0 for real UP systems
>=20
> This fixes a "not loading acpi-cpufreq driver" regression introduced
> by git commit d640113fe80e45ebd4a5b4 on SMP systems where the processor
> core with ACPI id zero is disabled
> (typically should be the case because of hyperthreading).
> The regression got spread through stable kernels.
> On 3.0.X it got introduced via 3.0.18.
>=20
> Such platforms may be rare, but do exist. This problem has been
> observed on a:
> HP Proliant BL280c G6 blade
> This patch restricts the introduced workaround to platforms
> with nr_cpu_ids <=3D 1.

This is not the correct way to submit a patch to stable.  See
Documentation/stable_kernel_rules.txt.

Also, patches to mainline should be made against mainline, not the
distribution branch you have to hand.

[...]
> -                * Ignores apic_id and always return 0 for CPU0's handle.
> +                * Ignores apic_id and always returns 0 for the processor
> +                * handle with apic id 0 if nr_cpu_ids is 1.
> +                * This should be the case if SMP tables are not found.
[...]

Second 'apic id' should be 'acpi_id'.

Ben.

--=20
Ben Hutchings
Lowery's Law:
             If it jams, force it. If it breaks, it needed replacing anyway=
.

--=-wsHH99wP9rPfReXfHBOj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAT+hwGue/yOyVhhEJAQqEtxAAuhYWoodWMCAlmYH1PENI3UtEF0Y3cD4n
xWJZ+Zvz2svidB/17RGfH4QtTgZgDOTXOIpfPqtVfSRcHcSlutpTDKxX8Hfd2/ef
mIVux3PlUtwK5ODEC73QwVstVIZLb9huDVMOz6lfM9vcS9H4iSmYqvwQ7Fn2OsF8
CIeF8gcL5d9N+KmQqTxsTvDMB3vK0PSp9slsvCrBQFvztl+uUlvaGUEBd4OHwnhP
PT4+PBnfooVbr16ypvhYIbVnk3VihnVmwzNpdaNNE+0IpGCyv26qZIueiZhyNTn6
IjlIoZFr4jEsUItzbl0SwXI2N5RK+ijNx+EqdRkrKi+soGI/LAcpjbjgnIQL0mAf
GQoznOqdxR38Eyn4eAGZWH1iqRaH7Sk47/qaTI1EtDcTsOwb+q+PyQLRk/GVYSwG
dBxxNeMxENWZhOXT35e1k0AeEYC0vB5sDyAeRE0uLbqlesP7QVqTUjrTRNwwygKc
rBDP6uR8vUwTjGDvOxL9Rl1valOiHDuydK8fBs85EYvQ86ZuyO651dZrdhfY6yDk
gKAqAiTWT7iKIL21ZZVp4l0jdq+uPyQicH47T3t9u8Uk/vEoq4UeTrWKFARf47rO
enWzWatwowo4ivnWa1bNX912yAPEJODcxE84KOSezll8Mqhc7FdF+RFftPAfpTp4
c+xHZV38h8E=
=Vrgl
-----END PGP SIGNATURE-----

--=-wsHH99wP9rPfReXfHBOj--
