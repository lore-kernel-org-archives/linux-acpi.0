Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D13F2107;
	Wed, 18 Mar 2026 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862925; cv=none; b=rwLEowMKXjQog3PY6UCQGbYcLFTeE09qMCHLmRQqTlT7H3bsFN48U5z47RvvoRjZTwXlkaDhNxcRiysbFDf0BO2wOUu+JVo91pXWqkRTcgUUHmjoUJD+LY8GzLuW891JbIwnPWKGGoAkdc2qYLjemOA520kv2qx9RbH0HkKCUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862925; c=relaxed/simple;
	bh=HXCYjnNmWNLffvrghRShw/mNCBqk1SRIyT8c8XR4iXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XnWi8fOu1Mv0HmPfsBB8U5it0bgHK2XuMeU9/LzRMQLBBcA+jvi4uZGF6r71eU6YmP4AZZfsWMiP8f4Cev4NzEqe3Kn//lXo3JIb+SKvbl8scmzNL9VVg6sVhR388xGTAF7oq1m41r6C0jTmBGIsvx3vt9KqUP6W7/78dENCWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4mqNgAn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4mqNgAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1795C19421;
	Wed, 18 Mar 2026 19:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773862925;
	bh=HXCYjnNmWNLffvrghRShw/mNCBqk1SRIyT8c8XR4iXM=;
	h=From:To:Cc:Subject:Date:From;
	b=n4mqNgAnA3HP7iqN6wIxrv1fp86qb89uaFKI1yzbc24YTledvkinVJuTsRiOkWgVm
	 +raDj0DWgtCD9+zhPq9rfEQ4NSt5AW2cn6LJMKr9ZXDrsUaUp6rZSfBz70Ex4U2lOm
	 y/f8s6R5FcSaQiN02aJAh68bAABnLN/8TSn6JN01UYb3YECF2Z8WuJf5I6FkWGiRFR
	 5PmImE7lVS/TMIWt3voqqzY9EA7bCI1GsSRbvM/wqGW4RpkU0oaa03T72ueq6F+EYl
	 BRcPjkiDOdSV7bV8hVG3nLQt+wHVMt9ZR+TuSFkY5+4iZ37hr5s6Rl5aPOLE2/oShk
	 aESwWxc1gIMHw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v2 0/4] platform/x86: panasonic-laptop: Bind to a platform device
 instead of an ACPI one
Date: Wed, 18 Mar 2026 20:32:58 +0100
Message-ID: <5979471.DvuYhMxLoT@rafael.j.wysocki>
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

https://lore.kernel.org/linux-acpi/3616223.QJadu78ljV@rafael.j.wysocki/

adding one patch and updating one patch to fix the driver removal
code ordering.

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

Patch [1/4] fixes the rollback path in acpi_pcc_hotkey_add() and rearranges
the driver removal code ordering to match it.

Patch [2/4] removes some redundant checks from the driver.

Patch [3/4] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [4/4] converts the driver to using struct platform_driver for device
binding.

Thanks!



