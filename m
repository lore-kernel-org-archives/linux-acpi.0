Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3F3DC4A0;
	Wed, 18 Mar 2026 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844628; cv=none; b=YYKvGwYRvH3bsLCKRXvhMD6EuH5VVxTjOM77wVd7GS6uemEFSoeKezJOiXnQhzeTs5NoB1hCtX6VjJXXqjKYBWGQq29lV5M8zMPetArBMC9TU4ufvxEtETnvLCdTyrqksXWKd3TM4voTq2nVQZG+E/AS0khOS5zoLBmsfzjvkmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844628; c=relaxed/simple;
	bh=yfrJRAI46AU42HuA5KwpKI99bFSUZLmGQ/eBEHAXfCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H49UrLJcm0t86QP34omaX8+3+xnUK45IpQIssnXUtsqWXqOedIOZllghaAI68k4dvTA8Z8YCOIH1Y2mO5pwjJiXSR6ZpTwwnUec0ereaGoSV2hmC23p3vipVCO8Pejfb6eON3brXWmoNoHO/NxVzAvYkE3vOreD0NHxpxmyU3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz46dYm6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz46dYm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0975C2BCB1;
	Wed, 18 Mar 2026 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844628;
	bh=yfrJRAI46AU42HuA5KwpKI99bFSUZLmGQ/eBEHAXfCs=;
	h=From:To:Cc:Subject:Date:From;
	b=nz46dYm6dJNAsSQhP7NSnH66fdU3QOh+0RAM2UMnaOzXin4LP8H6ypaQKLFPHsooY
	 Pt0u1KNgP3LkmoZUh0rsTQ8682+M6UJX2ejfG394n5DA40ypKTcan7Srh6C942x2Ac
	 qJB/sff+qLapPLdYSDXWXLVXDrbOnsLNZ17Kd2HPxdDrDF0eMZ1TroiT5Hg1OWuiyp
	 uHrsu1UQu5Cmpsgk8pQcvxoqJ8x3E0YIv9Y8D0/aSUepB1v7A36S+f8V8NBlSUWDDc
	 DR6YLiATWWuMZ+IZ4XElNntJ0a+3MbIKPgja8PCSPPd2srUxMGkl0yEhQoaiy5Pee9
	 5cdGkZrQPxvSg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject:
 [PATCH v2 0/2] platform/x86: dell/dell-rbtn: Bind to a platform device
 instead of an ACPI one
Date: Wed, 18 Mar 2026 15:00:58 +0100
Message-ID: <2033052.PYKUYFuaPT@rafael.j.wysocki>
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

https://lore.kernel.org/linux-acpi/5071411.GXAFRqVoOG@rafael.j.wysocki/

adjusting the probe rollback path.

The original series description below is still applicable.

This series is part of a larger effort to switch over all drivers using
the struct acpi_driver interface to the more common struct platform_driver
interface and eliminate the former.  The background is explained in
Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
the patch that introduced the above document:

https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/

The bottom line is that the kernel would be better off without struct
acpi_driver and so it is better to get rid of it.

This series carries out driver conversion of the platform x86 Dell
Airplane Mode Switch driver.

Patch [1/2] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Thanks!



