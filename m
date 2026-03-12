Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD93B5830;
	Thu, 12 Mar 2026 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314579; cv=none; b=D6VdQu4YXYReXy7qN4Lw89DNXdbawpWuYB0dTwvlQLQv28GMXmDg2FlKHVvu6LUrsC1p4Hxklll+ta1thiB5ahcMdCQ3WR7DXQW1CeWr68lkndQbx6pdFqlbm2KcXDrWccMDgB+KMTM3yqXpgbNiJhdm7lCbvH3w/NJbAxRmK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314579; c=relaxed/simple;
	bh=v8Frv5nY3jv4FQM5NSxeEik2y4mIOkm0mY+NZcN251w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LHgId0Kc5LmhGR3Ajm1sFBEQ0FQkGM1ta2pBRLlzbblLgGxlEsdQ/hSej+4xiHdK9ApnCcLIWvNxff3oT7vqqwhJY6p26oTuiid/aIzgVViFlR1wgUzk0vtLZPMLRTDLMfLRFu55mCQocIort1N9oB67QZsjxrBkU3r34cmtPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDfFFqOO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDfFFqOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF338C116C6;
	Thu, 12 Mar 2026 11:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314579;
	bh=v8Frv5nY3jv4FQM5NSxeEik2y4mIOkm0mY+NZcN251w=;
	h=From:To:Cc:Subject:Date:From;
	b=EDfFFqOOt2/io3awp8pldOoJcZwCGIxwVNZ2Adci8Icta6gApvQkoJ06Xk+mnmHrw
	 IN35wliGrhQ1D+7jUu5FC5ECTjSMucDe9Ly3Oi9X1AdgcoCCJ79Jc8hVSrvNsOXE4C
	 TP3YavvyFzJ9xjU2KlgQ1J2LdGM/lvORbPTk41OUhEvz+DQJ0uH2W/I0nfP3L+T8up
	 4GlcGo3GRfHR1avMCqZQJ1BvZT+HtaCG6jlMzzRmozbVbY81zlIumRK7wuHW9tL0SA
	 e5YUxrkKtmYRvLA4T1qmvSurYNy0zUgRXAxo266qeZoiRbuesBRW4NPzb7FpOn3aUy
	 Mbr8yttseWcEA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v1 0/3] platform/x86: panasonic-laptop: Bind to a platform device
 instead of an ACPI one
Date: Thu, 12 Mar 2026 12:19:11 +0100
Message-ID: <3616223.QJadu78ljV@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series is part of a larger effort to switch over all drivers using
the struct acpi_driver interface to the more common struct platform_driver
interface and eliminate the former.  The background is explained in
Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
the patch that introduced the above document:

https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/

The bottom line is that the kernel would be better off without struct
acpi_driver and so it is better to get rid of it.

This series carries out driver conversion of the platform x86 Panasonic
hotkey and LCD brightness control driver.

Patch [1/3] removes some redundant checks from the driver.

Patch [2/3] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [3/3] converts the driver to using struct platform_driver for device
binding.

Thanks!



