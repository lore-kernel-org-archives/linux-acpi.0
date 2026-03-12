Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66202366565;
	Thu, 12 Mar 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325724; cv=none; b=KjeYg126LTHaFR4p61bUCw2DoblnB/DBxUFC9PQE6jojw80pfeaXIBKRDtYeG9dJWBewl2vmDSzpJ+WIV3nxgono7YLiAHlamnwmAU65sD5Dav5bXPkZm/JN1XdJxAuhr8L5DzEABBB4Cm/31Fsiie0nM5eh6xlC8SzRxGS5IPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325724; c=relaxed/simple;
	bh=lvoinxXso+iQjx8nFGmAjMMiW6KQQ26RoJK5oZMDTl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S0/RsW1JVo83Jy5F6e8byxhLJrpA6Dx5yIJw06nrsRQ3uOXvzddsCKrXDRYN/x8RuSxEkmrXOH4/wfu3P4k2hEYHk9OIigP+j4S+sdC0WG/y29R7ktW40slqvRI3d8wSrVd4dSlWljkD+1XAP9WVOMLXintqAxeZ14XDLZBjeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZBMva96; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZBMva96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ABBC19424;
	Thu, 12 Mar 2026 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773325724;
	bh=lvoinxXso+iQjx8nFGmAjMMiW6KQQ26RoJK5oZMDTl0=;
	h=From:To:Cc:Subject:Date:From;
	b=aZBMva96cvQVWvuBT/RnD4hmzJFsSPcOelJW0qLdW8ssrPc0XeVj9fvdUvUYtAI7K
	 Kf+l15XlkbqARmYSj+0K4kTzQxgv5ja4g8DHVRcY0OUU/m60bPrBBfTMZQlchxFn2p
	 asSa0MRwlsA/j29AhMZQSIldLJ575nxsOleK2n8MpxNYFtFQFEz1rS+ectb/PQMuin
	 uJvzNPiAymut5hm4Fz24YGzEz6L45/CXSFov6U/Oe97SeUvgY/XhRuWhjA8EjMh065
	 ODTkwMmaTkOAQTKJy18IuJqgFeXGhguhtPrZ3N5lEHnRV7ywojTHWo+9NSAXwUUf06
	 KSbDlF+kiDE8A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Jeremy Soller <jeremy@system76.com>,
 System76 Product Development <productdev@system76.com>
Subject:
 [PATCH v1 0/2] platform/x86: system76: Bind to a platform device instead of
 an ACPI one
Date: Thu, 12 Mar 2026 15:09:26 +0100
Message-ID: <2841136.mvXUDI8C0e@rafael.j.wysocki>
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

This series carries out driver conversion of the platform x86 System76
ACPI driver.

Patch [1/2] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Thanks!



