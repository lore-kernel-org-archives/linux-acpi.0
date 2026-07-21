Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF973546C7;
	Wed, 22 Jul 2026 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727253; cv=none; b=G/R9UkswDQz2UL9POZsOAEHpXiZ++zt+sDICSXZfMLsxKKOSHTQ7O0QvDs27QZ+UomF4giJD9q9CeKGGAxNaBM2EV2CwCXKMWws/iltThotRpqtVSq2jRp+4DMNlcpZHDOTWnJmHzM6T1NkMIk4QReUviYMIBEeBC3cXWZl5ZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727253; c=relaxed/simple;
	bh=9fbFYhKprTp2YpUX7Llzd5qK0QBSvK1K8S4Otd1lCro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qg4Jup/mbi9vvcm8qE8eZowHFBO7aOGHtNUO5I0EBJddl4dzyX8A9zGl9mumyWrqqyZ0JRNIrs2NLRTVofaBeIJC8rcyWI2rFoydPJOlREb3oRlvh9tXIdWm8JnaWy4g1MFdinye53TxGNGwE/kHU9imQb422pJRvKFolV4Qxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOpadXON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOpadXON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300051F00AC4;
	Wed, 22 Jul 2026 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784727250;
	bh=RQZW+0HRVhe9UFcSH7cql90O01oghIj/tpScM/IVxcQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QOpadXONRHyVXUFg7dTRcEjiNS0tcCIJmY40e9Oc5uWTlPpo++m/wKeynV6ZckVDO
	 i+s5YAr41uY7jgSgSinMGIVez94+R40HQu8bn/gINjMnKz0vIEbGnXfIZ+6z/gNAh4
	 BzZVeiRlQTvTbvW94bAszKsPmkzfi+b+FRyQ3XXwPRiqJzwH3wa+MlNO05jz6mOM69
	 clsmKiBcKtMNEJ5OPbcSLweOVdGJMBDaJ+5GrLPHw5KglJaz3lJUaAn5MdGRrG0ouk
	 NLRIOCamIVfaKrcDSCedp8lo/X0ghwbJermM2rVYE6Xmxesm8EreToyz4JeT8EP73q
	 N7K1KPXc77d0A==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Marco Giunta <marco_giunta@outlook.it>
Cc: perex@perex.cz, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
 hansg@kernel.org, ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, wangweidong.a@awinic.com, 
 nadim@symbolic.software, imitoy@imitoy.top, munzirtaha@gmail.com, 
 yakov.till@gmail.com
In-Reply-To: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Subject: Re: (subset) [PATCH 0/8] ALSA: hda: Add AW88399 HDA side codec
 driver for Lenovo Legion
Message-Id: <178465795610.260430.18004285185903429400.b4-ty@b4>
Date: Tue, 21 Jul 2026 19:19:16 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9fbFYhKprTp2YpUX7Llzd5qK0QBSvK1K8S4Otd1lCro=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqYMbONts59xPaurX1cc1uvm9SLXwvd1M2nY7Iq
 AKBkP+pYtmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamDGzgAKCRAk1otyXVSH
 0HcGCACGbecZ0k+pRjDpGj53snVGx6aBTcCQHgPe/Qpl4PcUGI49IyBw5GUO7N2blDHfF+op33b
 Mcy1k+FEqQpEyg81hdEEez4muBONiGHlJWzSk0At67rKUBa4vv1y77EDfnL2K7meyXt6t7BRsWr
 aRtkV7ifLspvO5kSq+RFvB0Kf3znT48QBTxoRtHHiiD4sLTVUMQCORkhl8/FWyM60zLwxwYrl6t
 /mq/Bd87HEPYQ8cxxqTdhAPMFSoSWCWml6f8ySVDl7Lej+zApKIzfkyN1zqIOHUU7aNJGG22b0H
 yrK2mBiCbno2GGCZQnqDAukY0XVAhCE5c8Rv4+jdFl+L72A/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 17 Jul 2026 15:25:02 +0200, Marco Giunta wrote:
> ALSA: hda: Add AW88399 HDA side codec driver for Lenovo Legion
> 
> Several Lenovo Legion laptops (Pro 7i 16IAX10H, Y9000P IAX10,
> Pro 7 16AFR10H, R9000P ADR10) use AWINIC AW88399 smart amplifiers
> to drive their bass woofers, connected via I2C as side codecs
> to a Realtek ALC287 HDA codec.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/8] ASoC: aw88399: extract shared device library
      https://git.kernel.org/broonie/sound/c/7fa44519a2a3
[2/8] ASoC: aw88399: derive channel from I2C address on ACPI systems
      https://git.kernel.org/broonie/sound/c/df5654d73061
[3/8] ASoC: aw88399: add per-instance BSTS status bypass flag
      https://git.kernel.org/broonie/sound/c/b4530a3e4895
[4/8] ASoC: aw88399: add firmware reload flag for resume
      https://git.kernel.org/broonie/sound/c/b5e1d685fb9c
[5/8] ASoC: aw88399: add channel setter for HDA side codec
      https://git.kernel.org/broonie/sound/c/15c9fdb3c39d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

