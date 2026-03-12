Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD039DBE9;
	Thu, 12 Mar 2026 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314107; cv=none; b=Y93jhq/HDxD2X3ve1jwVue3wM8bQNeBnpwUpV91QVleoj578PcMLRdVNLwYOz0zcr5ReV6NIVZ/Lj1XuLGMmCAjSLSsZRRaCfX7UzAhLlYXD4QFgsAIhIkz8IOvTlV/WFst1djWb8Op1FPyZZIn1TByEdAxFbwXczqvYXXkbA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314107; c=relaxed/simple;
	bh=8r7oSw2Rd+D+2DHz3qz1Eica+rN+Pc/nfExbZmktYdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H/ZVc1N8rRAS3v8bNcGh0gFIHlPBzHePpKctEdwMW4Tb1xbny0Cqt/Sr8s7JuWttmBfB2j69ZgQy2OCEfGE54tuiBs+tOdsvUwDBMy0Fb1RtEHp7gmvJnKB/r3PRnEfKkXefH+h1HKCd5ozkna0osZW0cd9ZN4ZPsVr8TVMAJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj1su1oI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj1su1oI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B22AC4CEF7;
	Thu, 12 Mar 2026 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314106;
	bh=8r7oSw2Rd+D+2DHz3qz1Eica+rN+Pc/nfExbZmktYdk=;
	h=From:To:Cc:Subject:Date:From;
	b=Bj1su1oIQaBae3O0IZZ891VfJHj1d61vR7F/41eCp2gTbti8d4EGdyNRJkNdYs/IJ
	 Q6WQXikVuHr8/SNuHhtW+RUijM0YQ0n4WR75ef1ji7pd8yNlNsRQEy9UO8bi4zR8fR
	 HsT2ZDjWoZ2jMlLfvvaDAegGqsecWygXpaGH5Ltu5bPCbDtmuYHxJWAQvRE+/xSSw+
	 +G1CgzYDEBoFDFg7Y+U+pQTgHXYyyD1qtC6+QXvtXa04CPbsgtQE57gVsaNbEPGCoP
	 boJC6NXNxkbbJVplBUMJTrUNb1oS2RjAbB+9RpTMRR8755Hvbdz/uwdXj7zEwFZLIG
	 xF1XJncHO7GFg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Matan Ziv-Av <matan@svgalib.org>
Subject:
 [PATCH v1 0/2] platform/x86: lg-laptop: Bind to a platform device instead of
 an ACPI one
Date: Thu, 12 Mar 2026 12:13:05 +0100
Message-ID: <3698311.iIbC2pHGDl@rafael.j.wysocki>
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

This series carries out driver conversion of the platform x86 LG Gram ACPI
features and hotkeys driver.

Patch [1/2] drops a debug-only .notify() callback from the driver, which is
requisite for the driver conversion.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Thanks!



