Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266293803D6;
	Mon, 11 May 2026 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530575; cv=none; b=DWOBXQHbLL43HedNl7pAMTVdAdPj6/gUujdzmv37x3Tknhikk8Aoj6ji76U1gk2ESK8ZH4QKpgAqc+I5P7X8Z08zW2JWe/gtlqxhkLSVxzfjK0/1GqsAuzpPwMkkvneBwhvk9FZzmgyoPb/nrKV6QrNs9xYOU1lNdiHS2wCWSHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530575; c=relaxed/simple;
	bh=V8KYA4djs2U8M9PUDjehe337KL1Zb+IzOHjnGi88Ea0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nPmikDyLAofBsJAE//2hj/2X/Co3bm9L6HFHdKK7IffCVCS7vFcFBUoHoRw7PR+WA9wuMTH3DIIIoAC7dMg9DT0fU/TU+Tc+FrQfOwwAKGEm12I2Pj5soGtzQFacTsjWqIWPheGy1rSdUzsoDnftducJImlqr3J+lpvGn+P0cVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5QeB96+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5QeB96+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA95C2BCB0;
	Mon, 11 May 2026 20:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530575;
	bh=V8KYA4djs2U8M9PUDjehe337KL1Zb+IzOHjnGi88Ea0=;
	h=From:To:Cc:Subject:Date:From;
	b=o5QeB96+hNyTXiCKsRPkHBSXv/GCGCAG3ABLNOsFFICCx5l8XMTvj2tfQEyko9MAc
	 N9Qv4DANZlmM4pSgT+vyXZe5s4zUSiUaEhaPWkk62hieyi8wtcEV6ggsIJ1Ju620hI
	 bGpesLiLmogaZDCZt01OsByIrmqiRm7RG2B8S5dyloCC48cax1jTovLFtw4MeCLjtE
	 qC7tOfeyeuzTaXxTO+Cn+vdh3jYN7EiMBa+KQAaTiya3ckLBrT+18K5xFcpq06qZMW
	 FCd4oYdReK3HUtCoIIlme0Lc1uFkYb5XyMX8EAK2MpiRDXyy2dbsF505TKlof52cF0
	 av/1PsFSKS5Dg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 00/10] platform/x86: classmate-laptop: Bind to platform devices
 instead of ACPI ones
Date: Mon, 11 May 2026 22:01:45 +0200
Message-ID: <3415394.44csPzL39Z@rafael.j.wysocki>
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

https://lore.kernel.org/linux-acpi/1956046.tdWV9SEqCh@rafael.j.wysocki/

sent mostly because I have realized that using devm_kzalloc() in the first
patch simplifies things going forward, but also it adds ACPI companion
checks against NULL at probe time that were missing previously.

This series is part of a larger effort to switch over all drivers using
the struct acpi_driver interface to the more common struct platform_driver
interface and eliminate the former.  The background is explained in
Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
the patch that introduced the above document:

https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/

The bottom line is that the kernel would be better off without struct
acpi_driver and so it is better to get rid of it.

This series carries out driver conversion of 5 subdrivers in the platform x86
classmate-laptop driver.

The first 5 patches in the series are preliminary.

Patch [01/10] converts two subdrivers in classmate-laptop to using
devm_kzalloc() for allocating memory which helps to avoid memory leaks
during driver removal.

Patch [02/10] modifies 2 subdrivers in classmate-laptop so that their probe
rollback code ordering is the same as the removal one.

Patches [03-04/10] change the type of the first argument in 2 helper functions
in classmate-laptop and rename them.

Patch [05/10] updates classmate-laptop subdrivers to install their own ACPI
notify handlers instead of using the .notify() callback in struct acpi_driver.

The remaining patches convert the classmate-laptop subdrivers to platform
drivers, one at a time.

Patch [06/10] converts the accel-v4 subdriver in classmate-laptop to using
struct platform_driver for device binding.

Patch [07/10] converts the accel subdriver in classmate-laptop to using
struct platform_driver for device binding.

Patch [08/10] converts the tablet subdriver in classmate-laptop to using
struct platform_driver for device binding.

Patch [09/10] converts the ipml subdriver in classmate-laptop to using
struct platform_driver for device binding.

Patch [10/10] converts the keys subdriver in classmate-laptop to using
struct platform_driver for device binding.

Thanks!



