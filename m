Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44B37BE66;
	Thu,  7 May 2026 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184914; cv=none; b=BNJFZWQF4+A1B3BFvX2y8WhAOKnX7x+0czqJTVvnfmzR1UqADlN+tJv/2UPAuSNKOS4mgKgiR63I0I4W5IcbiD74WTRVEswnj9neEkEedpYqm8X8bUNlPZvrfucBaRw1SxN/FWjWoj/KnFY4hXxTP8EUC3fhPpXisOQTP5sG420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184914; c=relaxed/simple;
	bh=dJy2TNsDKOBvIPqw3U8c4PVZtFjUMbLQxMLJgSEDxYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=exeT7uHz/Od4MlqMidEtSVTvlJILYIRMXA3uCk8sOra4h9n3v5DBYcTEX8akWemCCJi2TFe3GLSg9IrX6icGlr7egilVq7Keheuy/o2YQ1/jWmb1fZzt4m9eyPfzrWV3WE5GeA/slmyKaFFiyumuNcwPUbPxsNkRIoA2j53ag3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMOmpT22; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMOmpT22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20828C2BCC4;
	Thu,  7 May 2026 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778184914;
	bh=dJy2TNsDKOBvIPqw3U8c4PVZtFjUMbLQxMLJgSEDxYs=;
	h=From:To:Cc:Subject:Date:From;
	b=uMOmpT22Mza/YdOqLnXP+J7ZPWbM3ouh1Z8mzC39A7/CeE17DwgIUVr/5gcoIJkpI
	 Yk7Lr3+bJIX4FVtefOBj4D9fPl21DXyemc8mKaNy8o4v3w9ExczqvcEREcGSFPCMdW
	 Z8w3p7boP0kI76DDsQqz9dQSEgH801kwexUSunODYqpY5+Nl+mP+KlHzpiL1/9dENW
	 LEqvDoqBgmBVxYPrY26LO+kcjjcDCSGRQMiz4aNn75WDOuRnF5Huu8sKrVBwqA9D4R
	 BB0tuoAVxyjjyPmYa8ocFqj4xw58j3jENdqkG6J/6rqv//XYqvcYaFJ5e51r+5Bn0d
	 8PxZH28F+sumQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v1 00/10] platform/x86: classmate-laptop: Bind to platform devices
 instead of ACPI ones
Date: Thu, 07 May 2026 21:58:48 +0200
Message-ID: <1956046.tdWV9SEqCh@rafael.j.wysocki>
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

This series carries out driver conversion of 5 subdrivers in the platform x86
classmate-laptop driver.

The first 5 patches in the series are preliminary.

Patch [01/10] updates remove callbacks of 2 subdrivers in classmate-laptop
to free memory allocated during initialization as appropriate.

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



