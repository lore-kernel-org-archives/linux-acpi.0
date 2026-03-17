Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58E3254BD;
	Tue, 17 Mar 2026 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776720; cv=none; b=MEgK6JvVP+T8WF4v46J6kgb111vuBl3zysQOcOnTIcijmQEf2opiIFxTCpcH0FvETMiC6GfWjrUVm+5wm6A3csQa0fWUxlHFFpHlUBk0qt+kCg7Qp+y+8rH+qLJ7rsgszYf/iQbxFg9KcsMNsPI7+67+Ewxhv8xyd713f/ecUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776720; c=relaxed/simple;
	bh=rapqF7OZJHjD1yjhZLqCGhyR/WO1PMQthShAqfwmPrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XlYlc6q1igDtMIe8M+pKT2eHq7+MTEcAP6i6UscYu5iCg3WwICOlMJsufIzsj5R8A5DMOceA2ZgSFe/LTsvXX8t6nvUOJpmu63TgD2ToOMhGPnXT3+2+n1aa42+6cVWPBcr2AgljYWee+DfTKJ6tZUU3tN2t8akLrHnzlXk1ozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmNui2cN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmNui2cN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB9EC4CEF7;
	Tue, 17 Mar 2026 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773776719;
	bh=rapqF7OZJHjD1yjhZLqCGhyR/WO1PMQthShAqfwmPrY=;
	h=From:To:Cc:Subject:Date:From;
	b=mmNui2cNVMyW8Nx0xZ47SGnwhtlO5+Kzon7cpt7aAdClIBRPxjqzrK+ejWJxWRo6W
	 3WbCi8G9zN17YEt1Cr+Ob980kPsCMdRGfPjpZPLLLZP7xAN1vWs40I69ySDbx2CmTj
	 lnb84G7Bhb430hjF6uKs051tnM10HhSPFZpyw7YqDCXM26fdq5ZagjaNRpPopeiYfN
	 im2oEq/ByNTmqHIYccvYfJO6KmF0fak/JXKf+Y1DQtEHQ9HMvGgyDMZaUV3Ajz5Vnu
	 9p8fl2w4fH4cNb5RG8be7BeDUcxxPQsrsChOLScn2etwDy09OY37H4Wpv4g68uMjpi
	 d+ZxuwBseUG5w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v3 0/5] platform/x86: fujitsu: Bind drivers to platform devices
 instead of ACPI ones
Date: Tue, 17 Mar 2026 20:38:06 +0100
Message-ID: <5085647.31r3eYUQgx@rafael.j.wysocki>
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

This is an update of

https://lore.kernel.org/linux-acpi/12863082.O9o76ZdvQC@rafael.j.wysocki/

that updates an error code path issue in patch [3/5].  That change also
requires patch [5/5] to be modified, but the other patches are the same
as in v2 (and v1).

The patch series summary below still applies.

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

Patches [4-5/5] replace two instances of the struct acpi_driver
interface in the fujitsu-laptop driver with struct platform_driver.

Thanks!



