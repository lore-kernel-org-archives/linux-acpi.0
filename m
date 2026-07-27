Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207C0323416;
	Mon, 27 Jul 2026 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153433; cv=none; b=ECnfqvn4l7W6kXMmAfuIWxKSNoQNgzMNt7IESVPBRGewgUXcgAct+b6OWH7mMnIibE0P+QfqDYI6qWRuGewKChB5n4NkFebr8CC4dhtHZN9ypP8u7tFNTdKVfldZxRLDAT74daciJiakMolnZLjkAtFnuqFiIIK+DHDeIsxetgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153433; c=relaxed/simple;
	bh=QZ7J9GEKKU0tiUYyGlfAOZClTIzKKMxb5eJR0V3eGuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHtoV6MI1WcQVWTo8kLg9Cs7BS6r09O2iQ3xeXH3rKJqXwyt3L+Jgq44mtCOwFhAPmNFE9eDWhDQJH4ChYaZFOTeYZUXSSr3miTaHgkjHMvsp49Q6XEad1kFHdupWwPdAM9J3bmv40y1jaw34+hGZ6Y4rwFYyd/TB+pF6OcjJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2tPCQ/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2tPCQ/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8131F000E9;
	Mon, 27 Jul 2026 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785153431;
	bh=lz7aqFjfuxew01pZPfuvHynhqmWSfxijKJmqQXTiYfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l2tPCQ/30nFIeFjMpBf4i6dwX0DDUnMOK6cPXfDIIg4SvlXjvjfMIONkqUOAvNcKI
	 o+cLi2rF7hZeACfnfIMsOL6VJs1TIcZHgx8xKMXdGrrKvq4SZkiaPzhxnj9slalr49
	 F7Xrlzij6VKigOcKOwzMXVLsTSaRCkl78zsgT7OyYOgzumSYlzYYFS+8FM9Ds0rpPz
	 UeOrfg/6d8HkXD31ysBJJ0pRJ8nBPNjk64tbTp4Mmy1jhIAeDcAQ1ORSQD5ALYTZYG
	 9SsaCz7dOvvZzURGmtpSozb6NVvF52Z2iCoozdbKsHds7M3WzxxvqDGWt66efgGBBw
	 UlgLLPYsBtGig==
Date: Mon, 27 Jul 2026 12:57:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Marco Giunta <marco_giunta@outlook.it>
Cc: tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	rafael@kernel.org, lenb@kernel.org, hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, wangweidong.a@awinic.com,
	nadim@symbolic.software, imitoy@imitoy.top, munzirtaha@gmail.com,
	yakov.till@gmail.com
Subject: Re: [PATCH 0/8] ALSA: hda: Add AW88399 HDA side codec driver for
 Lenovo Legion
Message-ID: <06572961-d2c6-4de5-9102-2b5fc6d5ef5d@sirena.org.uk>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x1jyvfTe3pCirNzp"
Content-Disposition: inline
In-Reply-To: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Cookie: It's OKAY -- I'm an INTELLECTUAL, too.


--x1jyvfTe3pCirNzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 17, 2026 at 03:25:02PM +0200, Marco Giunta wrote:
> Several Lenovo Legion laptops (Pro 7i 16IAX10H, Y9000P IAX10,
> Pro 7 16AFR10H, R9000P ADR10) use AWINIC AW88399 smart amplifiers
> to drive their bass woofers, connected via I2C as side codecs
> to a Realtek ALC287 HDA codec.

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-aw88339-lib

for you to fetch changes up to 15c9fdb3c39d5073463ffa746cc64ad9682c875f:

  ASoC: aw88399: add channel setter for HDA side codec (2026-07-21 19:16:08 +0100)

----------------------------------------------------------------
ASoC: Add AW88399 HDA side codec driver for Lenovo Legion

In order to support AW88399 HDA side codec used on the Lenovo Legion we
need updates to it's ASoC driver.

----------------------------------------------------------------
Marco Giunta (5):
      ASoC: aw88399: extract shared device library
      ASoC: aw88399: derive channel from I2C address on ACPI systems
      ASoC: aw88399: add per-instance BSTS status bypass flag
      ASoC: aw88399: add firmware reload flag for resume
      ASoC: aw88399: add channel setter for HDA side codec

 include/sound/aw88399.h        |  621 ++++++++++++++++++
 sound/soc/codecs/Kconfig       |    5 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/aw88399-lib.c | 1411 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/aw88399.c     | 1349 --------------------------------------
 sound/soc/codecs/aw88399.h     |  582 +----------------
 6 files changed, 2041 insertions(+), 1929 deletions(-)
 create mode 100644 include/sound/aw88399.h
 create mode 100644 sound/soc/codecs/aw88399-lib.c

--x1jyvfTe3pCirNzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpnR5EACgkQJNaLcl1U
h9Ar7Qf+LUkk62xnAHzaptw3xw7XmAUbLO8oS2y7X0x0FvaJRClXV9LTTtn8/CQN
rmpFg1/wT/SVdLFRa7NC+FRawZN3KDyi/goNOD7wMHuVOYBffDeROyySaBf8+94R
MhNRPiOEcUO1XwqqaPbLowRLOD5V6PRIG2Vp3G3FFBruXsINubWLbfwHFvfs2j+Z
Wgi6yIK+xsFkIl3Bxd4ES8xOEsV4nXx+R4sXxRvQVYZlYq6ZAOZqtQSDsIL2WjRP
cVpns8taVeEz7aMJxhlc2ZemAERTyszYq/aVvEWEMaj8V+HLk7/zaZLClvMwGzw8
uAoh84AKzuTGPYGC1FLz6RUNt0zL2w==
=zE12
-----END PGP SIGNATURE-----

--x1jyvfTe3pCirNzp--
