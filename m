Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D43D5674;
	Thu,  5 Mar 2026 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740107; cv=none; b=j+XIJPR42z2TPpw5XTvXzlYRp4hfkYdFNtNCtwN3MTkCcRdTKDVutmZDxL9H3vY6YHOwWAfpQHyiwrOXHIuhUtdpV932+mH6QizhRF59VaTYI3Vtn7+4fvfowSaGY4F6+vxO6dfQUPK68vJLVeIlSVXZvBEEkESm9qQ03iQyMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740107; c=relaxed/simple;
	bh=Q6ykonlFe2mgyaKN7sWNkRX7x30AtH4qyp5TZe1QvhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eTlKIeJObe9KG5i+LvQcvPcV+a9GIAogICtzBQyB8cdaEAF3jKndLDXoQPxojZJ34pCP3TzKVPBrFvJ7X01KeLEcxnt/BmirqsG3Wdreb0J5PEx/fyg+LPX+/YlqqNBZPT3dPuckvdK52SinZ3Ysd+cKzg2GRbsSdCA/sjVwn0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plcPweRy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plcPweRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D94C116C6;
	Thu,  5 Mar 2026 19:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772740107;
	bh=Q6ykonlFe2mgyaKN7sWNkRX7x30AtH4qyp5TZe1QvhQ=;
	h=From:To:Cc:Subject:Date:From;
	b=plcPweRyF2WVTBktlFd4LpsDSQgPNRsA4h+05M2DSTZyg8J4v2zRYcFbyrmvlNYeh
	 fkyOLRAmt0n0s8zHffZ5d4VBFzqT2e3mv9rUw6ym9UiSVx2zorBn/u46haKTt2eY9Y
	 qtoKoSDnuSvbFoCRvvSp7b5sJC7UFw+Bo/7t74rWnvrm+jJOBVZPifz32J4rg7Revs
	 f7FsKHT8S+sAdkiI1oX90uX86HDsNIDUJ+ovoPj6OxATi/9E+LcsjcGqp+zejJm5Rs
	 KaDtJqk0oweUXg5LBvTsNFuVLncc66K2uOEp62b2ESYQyhP8ysi4jzIEXKcch20H6p
	 zfg20Xz1EjwVg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v2 0/6] platform/chrome: Bind drivers to platform devices instead of
 ACPI ones
Date: Thu, 05 Mar 2026 20:34:58 +0100
Message-ID: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
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

This is a v2 of

https://lore.kernel.org/linux-acpi/2274474.Mh6RI2rZIc@rafael.j.wysocki/

addressing review comments on patches [2/6] and [4/6].

The series description below still applies.

This series is part of a larger effort to switch over all drivers using
the struct acpi_driver interface to the more common struct platform_driver
interface and eliminate the former.  The background is explained in
Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
the patch that introduced the above document:

https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/

The bottom line is that the kernel would be better off without struct
acpi_driver and so it is better to get rid of it.

This series carries out driver conversions of Chrome platform drivers.

Patche [1/6] converts the ChromeOS privacy screen driver to using struct
platform_driver for device binding.

Patche [2/6] fixes a wakeup source object leak on remove in the
chromeos_tbmc driver.

Patch [3/6] updates the chromeos_tbmc driver to install an ACPI notify
handler by itself instead of using the .notify() callback from struct
acpi_driver, which is requisite for the driver conversion.

Patche [4/6] converts the chromeos_tbmc driver to using struct platform_driver
for device binding.

Patch [5/6] updates the wilco_ec-event driver to install an ACPI notify
handler by itself instead of using the .notify() callback from struct
acpi_driver, which is requisite for the driver conversion.

Patche [6/6] converts the wilco_ec-event driver to using struct platform_driver
for device binding.

Thanks!



