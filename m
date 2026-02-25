Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705DA2949E0;
	Wed, 25 Feb 2026 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053075; cv=none; b=hHSp1FwPVQdVaZdGfs8AJmiXaq6UaEr6HxlLoiLTRZp9pJ/LNEAuGXwDGjNioVPnaCOOUpQG4mSMiqVTf1c4iZBtimnbRqL/l09rgwYAaI+qsVyO5G4xyhtcKkc4VhhM8NtjT3kUH8CTYzk4V7gTctqIqKmQ8tsx0CCsI0qiWJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053075; c=relaxed/simple;
	bh=TKkUQyYe2s0rxotk+FJ/106vYELsLEwovz7QhLfHc34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FHmwvctuiaBohbEYWYnmFyB3X+1x940RkIg3Teq4LsNA84EM/ReENa7Xv26Bls1/PNd3iR6FxchNN4LQu2coysBSoui4+nIBw+hNZs6q8s1jUq2GNpMaBIqn4CL9uFJZOaNaBklgfwH9uv/dJsK23XosPoqlmZAdn3I5Dr142II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEp8hdRG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEp8hdRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B435FC19423;
	Wed, 25 Feb 2026 20:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772053075;
	bh=TKkUQyYe2s0rxotk+FJ/106vYELsLEwovz7QhLfHc34=;
	h=From:To:Cc:Subject:Date:From;
	b=CEp8hdRGsdslq0USgMo/bjmpG97bHvEyNQeIHGRNAQpOLxwyh76wJ9TYmxCpFSGt9
	 0xd7xb8y1oyZUukw1GbXIrBTrGZQ7ru23SkHAegPtp+7Ks3eU74NWvhkQsPpdU9NhO
	 5eRHN1MM8RY+2rsvdyRdreX248HhdGDNIReoYb7QbfD0NHy4kW1Z2NwD32Lps8VY/g
	 khvrUhKAiEPudkEp1qLIlNsqUJOLrSRNhI5ADUkioNy1FZXD9gPhGa9zf7ASgSLxIx
	 gKfpV3KFB31UAQkzrgA7vU3jqCrfqjp6KXPkYZNmYushPMRpIsn5/WrIyuHpxTVIpj
	 8vhqGu7fNSIkQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v1 0/5] platform/x86: fujitsu: Bind drivers to platform devices
 instead of ACPI ones
Date: Wed, 25 Feb 2026 21:41:09 +0100
Message-ID: <1968442.tdWV9SEqCh@rafael.j.wysocki>
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

This series carries out driver conversions of the platform x86 drivers
for Fujitsu platforms.

Patch [1/5] converts the fujitsu-tablet to a proper platform one based
on the struct platform_driver interface.

Patch [2/5] rearranges the code in the fujitsu-laptop driver to avoid
introducing forward declarations of some functions in the subsequent
patches.

Patch [3/5] updates the fujitsu-laptop driver to install ACPI notify
handlers by itself instead of using .notify() callbacks from struct
acpi_driver, which is requisite for the driver conversion.

Patches [4-5/5] replaces two instances of the struct acpi_driver
interface in the fujitsu-laptop driver with struct platform_driver.

Thanks!



