Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE52FD1B5;
	Tue, 24 Mar 2026 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382626; cv=none; b=TYCxlPSQpnAgJcLVvudl0yRW9FBIcu0sR5vbot/RuC6RLPkOBFtSUie/jq4eMfQLkGGIHPzD2T9sXTmsUzBfXmsO0PwjKqJPH2vsa50ywt4jRHxWM/Gr7UEuKB049lAN7L8LE64QKgrpalbdX4c/ElrQpu44U6hsaK1blXUtsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382626; c=relaxed/simple;
	bh=L9a/xeuUyT+Ibk7uFyVZx39vg3UXnepPVaRg/GyWsIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FAlOqkLlErRxPTDV+GQHi2r9XZylcHH5lDnUpNFyF/SZBcq0hlb041/GTJyPM8Xi5i7iQUPOIcQBfYwptqCbm40YT/O1vEXK95SW5xqkP5W1Y/eGqbp3UTQJAj2K8O8ogf+D2B4/j0s5zUm/ePcIqBLR2dLoAHYH+7F3E97WCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMFwY88q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMFwY88q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55229C19424;
	Tue, 24 Mar 2026 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774382625;
	bh=L9a/xeuUyT+Ibk7uFyVZx39vg3UXnepPVaRg/GyWsIw=;
	h=From:To:Cc:Subject:Date:From;
	b=BMFwY88qcwxpO63yHf8FfixrH580Ebr878eED9mTwm4g0gkdBnp6HirphVYY+Mtmb
	 7jYQwTNHIG4s+NoXu7OUeKpYY6kbdK9YoY+ufH3cAcgxvS0QzHqUawD/CffGdX0Ylb
	 zjcIsX1cicqnP3gFOaG63n3HmQDXdgO1VycrCjzIw/FK7dcXilBqVV8AGpKW6mSck/
	 BuAlPNiNR3df25UiZAHwpB1twWElLVITrG6JIaUziREGWQZJvxQzbb/h3H2/I9BEow
	 jRFpx5GEtBb+A7peScZgZ3JRz8Apw8JofyH/If6eplk8W7kX5JPjPs410iOMT3LPYG
	 I/OLks4rlzl5Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 0/7] platform/x86: toshiba: Bind to platform devices instead of
 ACPI ones
Date: Tue, 24 Mar 2026 20:57:18 +0100
Message-ID: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
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

This series carries out driver conversion of the platform x86 Toshiba drivers.

Patch [1/7] relocates a function in the toshiba_acpi driver to avoid having
to add a forward declaration of it subsequently.

Patch [2/7] updates the toshiba_acpi driver to install an ACPI notify handler
by itself instead of using the .notify() callback from struct acpi_driver,
which is requisite for the driver conversion.

Patch [3/7] converts the toshiba_acpi driver to using struct platform_driver
for device binding.

Patch [4/7] updates the toshiba_bluetooth driver to install an ACPI notify
handler by itself instead of using the .notify() callback from struct
acpi_driver, which is requisite for the driver conversion.

Patch [5/7] converts the toshiba_bluetooth driver to using struct
platform_driver for device binding.

Patch [6/7] updates the toshiba_haps driver to install an ACPI notify handler
by itself instead of using the .notify() callback from struct acpi_driver,
which is requisite for the driver conversion.

Patch [7/7] converts the toshiba_haps driver to using struct platform_driver
for device binding.

Thanks!



