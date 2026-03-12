Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F139935B;
	Thu, 12 Mar 2026 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313580; cv=none; b=N2HX6j/fFmeLx5Ub5haaltRUFnVWgDa5cokHNGZ3rs/veGxpg6qlA562oL42LgOYJahfWFMU7RVXrgnhLbRvXD3dsqqwQ/5nCHamulAtVJIxirLdjmekZs7O8Zcg/H6VOG2J8U5zFjyKGUB+vPhUa/OUrAR0YDTrFUx6mQ5YF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313580; c=relaxed/simple;
	bh=Y+mt2SRPYDxmRNnkR6bXv+/c4vkkaEnIrY4zwnlhvno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qHGuQB4O4sZ56vZkJa4YNwA66F3/r76+/8P6ev6rCQzGpuXK/I4JSlpzSa6Ukn4w3VNFDZcBDtKH5TL5ya2rnsZQAxqLc33zzibkAdUb3zEdx5/PzZNYugYvLn2yAvpX0ea2umRKAeBkhCy35c+KylwKddiasy4gosKj2ZpA1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/Tg5AFL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/Tg5AFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A50C116C6;
	Thu, 12 Mar 2026 11:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773313580;
	bh=Y+mt2SRPYDxmRNnkR6bXv+/c4vkkaEnIrY4zwnlhvno=;
	h=From:To:Cc:Subject:Date:From;
	b=i/Tg5AFLdcgZR6Yfn2cfIi0d8w7XlKSHGrXnmDde9vdTfH8TPczIlGktTF3jgxWDQ
	 jmltYsb7xw+OuJjYo+3FhpUPjdO3BOzof75a4VQxYzVlP1Kkh2ZIKZJbKOeeelIpsz
	 z6g75T81Q9yIImP26g7E6lrr2kDWxcdpcRdMhXL9o5H7hwoz/2unO7Z88cjp1/3hp0
	 zLRnvHrQ5FJLk/NlWKZvuAXGJJmtKdAO+rBDFS94iY14SvK0d+foT0QUm6XaqciP16
	 vxzIwsgzPG1CpT++5xqc+6GWFRoPPsL+pGGpmO6AyZ1Fuzf8Fzeu5lfxHq+PaV0XLZ
	 7Wa4/sWID9UJQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject:
 [PATCH v1 0/2] platform/x86: dell/dell-rbtn: Bind to a platform device
 instead of an ACPI one
Date: Thu, 12 Mar 2026 12:01:56 +0100
Message-ID: <5071411.GXAFRqVoOG@rafael.j.wysocki>
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

This series carries out driver conversion of the platform x86 Dell
Airplane Mode Switch driver.

Patch [1/2] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Thanks!



