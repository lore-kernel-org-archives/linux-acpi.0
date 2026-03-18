Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1513D9051;
	Wed, 18 Mar 2026 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842257; cv=none; b=u4Jb6Bw/n4ZzE9IJPLuW0NcFytuL7JyPHz/ECxcGvdxVtbOBCsHaPvddVoPvdEqsCFVNkKyaxKesRut1rguu2cMJG7ArzEy7YsW5PD/CG/s/qrSCX7h+PGCGRBCGoZLjTiRyd2tusdERiFO5QAu+hAE/SCzgG1KMaQwfzwADIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842257; c=relaxed/simple;
	bh=WG5rk3tDnJyynyppMKXALwoZh8V9AO9U0uTYJpF7qFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uhrjnk6NTIwx3HqMoyb2PKQwmoQbij6WpgoFaCCuTlem9/yfCxj3WzxcU6+oei3y4YvnW1s6+yzHXPBCwxb0rkMYhq5KtbCFGZ6ttT+B9DDPgCm774Y4pScaLPrGdb4BsXCCf1uy8Ge42ygSX/78Cik/AnDWJXt0I6DkAmCWJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC+WBpQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC+WBpQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A82C19421;
	Wed, 18 Mar 2026 13:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773842256;
	bh=WG5rk3tDnJyynyppMKXALwoZh8V9AO9U0uTYJpF7qFA=;
	h=From:To:Cc:Subject:Date:From;
	b=TC+WBpQQPAOj1VtLtR0otY96tRgOPIEwJXmGwo7CKJpQhaTG79QcyezQ7iqvKzW1a
	 7fxsEsKTmcq6kamrMZey+dlA7YXs1FZp2HYxSVo1iXucyKLIs0+v3ZepxPGlSr0cmA
	 nDYIw4ZAb7PCBS4Hh6g2wHeHjqXyOeRV8l2YESKILfWVxlcjgHgUVthzbQiQXON3hB
	 ioOYw5qgs8mzwwWG409VeJmFmudPK+/8Ob08KkdnKnIm4jDJXc3gV3Mm5ssiq8rukH
	 L0WkRmoMnpyWohbSW+KEZQZdRMIvlItuCBSVSMWp0Jmnn3dpOr0dIalkKy0RIZuG0q
	 aOv7GP01wW2oQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Jeremy Soller <jeremy@system76.com>,
 System76 Product Development <productdev@system76.com>
Subject:
 [PATCH v2 0/3] platform/x86: system76: Bind to a platform device instead of
 an ACPI one
Date: Wed, 18 Mar 2026 14:48:57 +0100
Message-ID: <4721148.LvFx2qVVIh@rafael.j.wysocki>
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

https://lore.kernel.org/linux-acpi/2841136.mvXUDI8C0e@rafael.j.wysocki/

adding one preparatory patch and updating the other patches to implement
the probe rollback code path slightly differently.

The original description of the patch series below is still mostly
applicable.

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

Patch [1/3] removes redundant devm_led_classdev_unregister() calls from
system76_remove().

Patch [2/3] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [3/3] converts the driver to using struct platform_driver for device
binding.

Thanks!



