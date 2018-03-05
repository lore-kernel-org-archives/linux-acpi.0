From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 10/13] arm64: topology: rename cluster_id
Date: Mon, 5 Mar 2018 12:24:29 +0000
Message-ID: <20180305122429.GA25758@sirena.org.uk>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-11-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180228220619.6992-11-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, mark.rutland@arm.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, catalin.marinas@arm.com, palmer@sifive.com, will.deacon@arm.com, linux-riscv@lists.infradead.org, morten.rasmussen@arm.com, vkilari@codeaurora.org, lorenzo.pieralisi@arm.com, ahs3@redhat.com, lenb@kernel.org, john.garry@huawei.com, wangxiongfeng2@huawei.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com
List-Id: linux-acpi@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2018 at 04:06:16PM -0600, Jeremy Linton wrote:

> Lets match the name of the arm64 topology field
> to the kernel macro that uses it.

I called it cluster ID in the code because that's what the documentation
for MPIDR called it IIRC.  Googling around suggests that this naming may
be being used by some of the DynamiQ stuff.

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdNvwACgkQJNaLcl1U
h9Ailwf/Qwu+y7xdbT7GgtW6ui93DR1UZAYyz6x9z58aVSxR9X96WSBLHdgEW3P1
3ieteClAVIxkmHxNDB6yEIw8895FcPrpZlLWbyAJTaDF/PdNd+AL0w99J+MC5yfR
It/terKGKUUbvdTOqK4ej7y2Bj+Q9kxt2/deRtpFVemBI0RI3IjCh14CsVb8+BqB
pCC8zWnDyrkp9YieLANgKCS5gFg6uJtRjo7gXSa/crPFrLLBX1acz7evv+2repu+
36Qn1o/j2K4NvmA80Q1Du/Xz/zh9P+X/v+zBgXu/j2J8rj10jE8Mfjpv+t/SG52n
AFYjinG601pr5pUrfarlII6W7ge0MA==
=zkjJ
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
