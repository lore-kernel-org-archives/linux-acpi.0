Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C34657E8;
	Sat, 28 Feb 2026 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292516; cv=none; b=FM8YrK3nfY/LRpuJqteLrUBwpHYDtUiCQM1n5vvjWJlsk+xlCQsLI/DW+9femwtEZAi3qZU0A4XbPwmMBlEFbnpY87Dso0o+cL6D3koda4aUx2ZUcLroGfcy/2R7xQnFV9CSGm7QMPAocLknbYXtl2CXVrrUqEMs//GFj65pMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292516; c=relaxed/simple;
	bh=7oW2onT3UZGPzUeQ6Dn/ZfePiMTDMDwaQUaM5RW31KE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A34v6uER2d6KgRYbwq7RzUg7fKYcQVh/B9/tz96LRZ2osNkZjIYBVGWZCdbbI4EtaZsQ8kd3YmmL+GzBqSUr/lWDoUZOGlxRmZ3UUe5pQu1nD89/FhvMz/59yHOnZhhUF8bIMkbT9ggm4pj7ffaSw2e3TclK2rwrumDAJrOYdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkfHgMYt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkfHgMYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5788C19421;
	Sat, 28 Feb 2026 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772292516;
	bh=7oW2onT3UZGPzUeQ6Dn/ZfePiMTDMDwaQUaM5RW31KE=;
	h=From:To:Cc:Subject:Date:From;
	b=QkfHgMYtbLqoPPBl7B1HZO2tkhuIXdVis1N4ieAElQOqcqFpRg2R5cFw0aIDOC9n6
	 jjJEjXvIVHiyI0aWS2XgMSDAEdnS5frDNKCmfD2NNauuEUgZOBgdeQuEasofqeG5uA
	 rdHk+P/0kr6WqT0Dv8SsV+yKABktU+XrRPkKWX+gVG4Xn1RHbYGHaVMzKusAhuvTHq
	 jDsWTg9OO4F0X2JJ7RVht2NIenNIf7sZL0jia7aex3DPCcTNMVTdrg937uEYSwFg2y
	 LMXu9HltfUZpku2QJuYEOTTnkDL2JVCDNtMdlD4ulPOqY0NXWgfavbbmcipECbvbuz
	 e39zoRFVSsHqA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 0/2] platform/x86: intel: Bind to platform devices instead of ACPI
 ones
Date: Sat, 28 Feb 2026 16:26:44 +0100
Message-ID: <8692017.NyiUUSuA9g@rafael.j.wysocki>
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

This series carries out driver conversion of two platform x86 Intel
drivers, intel-rst (patch [1/2] and intel-smartconnect (patch [2/2]).

Thanks!



