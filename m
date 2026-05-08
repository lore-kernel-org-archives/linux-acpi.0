Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464642E9ED6;
	Fri,  8 May 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263331; cv=none; b=od6MernAFy+Y3esat4uf0XiLUNRyk9z3xHEp0nN/3n2QKnX4CirGm9wiwiZA/O7fBz+INEhixAIqrGx3wuQD9NNpbh/Xx91cwzl7KhGCgE+0ZvdDihkGIN1oUkg/mfmV28mZYMox/k/LAfSsSp8OVdVH7uqMr7UMWnLgVg4r6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263331; c=relaxed/simple;
	bh=VwrKx6vrLciQY03HCA5btamEKhDOFQ+dbjukPU18hLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBOGe1c9tFDBHqvtmnv6ZRaAeKA7EUf0b1Ui5/r8IyQKls5kq+mg5jqgAYl4tP/S/DLed/to8Tnd+VDRXmBpGfD/aHjZrcmeSCuzOfYRJyBsc6ZLk9YxudQAlKnj8TFfKzcH6i0ohjBjiKalyX0RCyz12/DaGH2JMT6CYtn4HPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy82qJXz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy82qJXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4212C2BCB0;
	Fri,  8 May 2026 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778263330;
	bh=VwrKx6vrLciQY03HCA5btamEKhDOFQ+dbjukPU18hLo=;
	h=From:To:Cc:Subject:Date:From;
	b=Iy82qJXzGMB2eUMfLPSYsOj7TvSRBU7sAtdE9K135bp8TRaJ0CJBazgQkxmWFr7Sp
	 lo6vhOV+420HSiHeHzhySNM9Z5wK7qSu26yq6f3E/K6rnqYyDQpYY4Hacn1vAyTwY7
	 4cLaLLsiNvVCCkpX888oIGopgSgCBO4Fp/r2GlDRGw6/u8wvuQgrhp6EvHfAbCYrgu
	 yiwoyQ2gOaLJKn+P8ic2Z4edq/NpMHuZe5g9cr1u/gvH//PdueSay1VUHbIfTdvXb2
	 f9gL/ngdrBf8Jo2J1BR/nl6gfFV8qwoxY4/8fc2BROHeMPb/zoXULzMVVjVh7W3WA1
	 HewngfKpNHmfg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: x86 Maintainers <x86@kernel.org>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Subject:
 [PATCH v1 0/2] x86/platform/olpc: xo15: Bind to a platform device instead of
 an ACPI one
Date: Fri, 08 May 2026 19:59:27 +0200
Message-ID: <1868425.VLH7GnMWUR@rafael.j.wysocki>
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

This series carries out driver conversion of the x86 platform OLPC XO 1.5
driver.

Patch [1/2] fixes a possible wakeup source object leak on driver removal.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Off topic: I'm not really sure why the driver is there in arch/x86 because
there really is nothing specific to x86 in it other than relying on some
ACPI hardware to be present, but that's more about the platform than about
the arch.  I guess it my as well be moved to platform/x86/ (there is one
xo15-related driver in there already).

Thanks!



