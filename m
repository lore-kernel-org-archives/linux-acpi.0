From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Request for additional arm64 branch in linux-next
Date: Wed, 29 Apr 2015 07:25:18 +1000
Message-ID: <20150429072518.73450a68@canb.auug.org.au>
References: <20150325172002.GN24636@arm.com>
	<20150326111055.273aa644@canb.auug.org.au>
	<20150428163552.GB14963@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BKRHUUSx6gR/R1OzEVxHoKX"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:38291 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965977AbbD1VZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 17:25:26 -0400
In-Reply-To: <20150428163552.GB14963@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "msalter@redhat.com" <msalter@redhat.com>

--Sig_/BKRHUUSx6gR/R1OzEVxHoKX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Tue, 28 Apr 2015 17:35:52 +0100 Will Deacon <will.deacon@arm.com> wrote:
>
> Just to say that, since the ACPI support code for arm64 was merged in the
> recent merge window, this branch is no longer required and can be dropped
> from linux-next.

Thanks for letting me know.  I have removed it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/BKRHUUSx6gR/R1OzEVxHoKX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVP/rEAAoJEMDTa8Ir7ZwVKzkP/iua19+70s28gGDFoMIDFdZv
4gHFC06tBc28O2q/cIieyJX/jt9tSPIIkVGlD9l2BjpvI8zQrwfnTViYu+yAThQK
Jcr1lNOGhhj4cz/N+NXQtjmSDSwvUBY0mpZ1+z9VJWhECiuWFfgqvrDJpb1lgjuz
EamQr++LKHpzt1HMXYjKRLpUP0Y17+LvakbsXz6ke8wI2TunK9MPpKWNQrZeruzv
dPm2uAd5TVoxRdFN0e95IA7K/X7BJmtsI8Bf1vQj27hHIES6jMbF29gc+EqI3bCe
8QTn4qgc+h9r1BMKJbhy97Aqis6Pk3fJvIPnbK+zsaXZ4L/pcykHVp+mmhu8jC29
jZjc9DvxWC4Z3HC/Z51oXQ/LYcq6f7PhpaloyfAIkpLU89FzmYqk13E8GIvCwpJr
BwP+VM7la20KXbEzfp0ictW269StvVN1jwnPAISeS+X/zEkXbXL7e4scc/4wisff
bqbAui9iVuPmwb5cS2IMnWrY0sGCYCFwXpN2jsCBxxtNx+fFuX6VCDFfP5/xMjMX
NRHhKLssofHV7lXM0uuRzTjW7OWHlaqUAGUT0jm2Saa2m6RI2m8b/gMPUm4W6BgG
54RCafe/rY8bDxCnJMyod3Eqj+3BO/ESQY3ffHdFB3SXt7tr+VAvp/HhcvoSOa5A
kX0wyRytLHOGilLVb2UD
=AjeV
-----END PGP SIGNATURE-----

--Sig_/BKRHUUSx6gR/R1OzEVxHoKX--
