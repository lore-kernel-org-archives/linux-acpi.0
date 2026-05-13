Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B00388878;
	Wed, 13 May 2026 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638940; cv=none; b=XwvUs6lhbsA6J9Vz3f1CnqrP9YaptsFbDrZuVIUXn8WeWOEBuYAfhpa3klQPCQ+5u0VQ3tRMA4zRdZTiZioiEiBevPbdX5jeF1+jGyav0qIeaYN56F3iG+3ESHSSq9chpZcW9x5wQEVfQwyALUW2ALep3NuEmyMhb9EGmvWsmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638940; c=relaxed/simple;
	bh=zfdfbDuowTrXp7HhXYyygoNc22j93nrjHdwYMEVqXYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HITnptCi+jXy+1HhUYihlim4/axgjqPvLpcp4gmuQY5zRZ243NYz+FuqsyIZrkBeS2G5YRUYAvlUVpTbpKKdjoQK3qszt+CRSxm4eNRsEcsH6n4U+HP7W4hF3mXOKJUmU00CARH5a9fUUa7makga8jHTvJdey4ZUVQ235HWSeUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6UxdXX7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6UxdXX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8661DC2BCB0;
	Wed, 13 May 2026 02:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778638939;
	bh=zfdfbDuowTrXp7HhXYyygoNc22j93nrjHdwYMEVqXYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6UxdXX7YkWMSz1Vhx+ue3H93GTISymWoR3G2vWaBHeSXKXmIUkiTAM7WRIxwrzXG
	 GtoJOWJ8FMPF6GUYx1wdC3pGb6152JZXDTuLaYSfrdzNINAIULdB+TL0rjdSHNJxHD
	 nXam+tmNpQoyyFvyGh4A02tecVwbEZxkFTcgAAT0y9KMLCtLSloA3xMsbAwBtjtHHs
	 xYGILhzxDse5phECC/BlwktXdE93+n0NSS+Vm10tLTxK3KfqxebTZifGxX0CtfyOQp
	 l+VlSUiuOPZChOsaER0ipnw/j0qkEZtnVU69mdgwlgr1al0NV6M5r3DBWOV1DprtOF
	 1wJZHi5QmfJvg==
Date: Wed, 13 May 2026 02:22:16 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v1 0/3] platform/chrome: Check ACPI_COMPANION() against
 NULL at probe time
Message-ID: <agPgWFhTfLoJSSeX@google.com>
References: <3710526.iIbC2pHGDl@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3710526.iIbC2pHGDl@rafael.j.wysocki>

On Tue, May 12, 2026 at 06:34:06PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series fixes up three platform/chrome drivers recently converted to
> platform drivers to make them check the devices' ACPI companion objects at
> probe time.
> 
> Thanks!
> 

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/3] platform/chrome: chromeos_privacy_screen: Check ACPI_COMPANION()
      commit: 8a4a217f617b1ac2f8c095f33efd67d947ddb2cf
[2/3] platform/chrome: chromeos_tbmc: Check ACPI_COMPANION()
      commit: c15dbae7c856fb53cc6ffb86c6c64ebb816d07c8
[3/3] platform/chrome: wilco_ec: event: Check ACPI_COMPANION()
      commit: 51dcff9796fd486d7abf01081ca62e4072789e9d

Thanks!
