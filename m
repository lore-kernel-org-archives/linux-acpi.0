Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5F423172;
	Fri,  8 May 2026 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262361; cv=none; b=R9E8G+ru/3VRZGStBHeMbtNlfVwGO/+f8wLefv4/ZBvzz6HBxFSXLWpQdDxmpN84XXzhnuwfGYPdEkfBxlegqNkLEm9rWextJmWs61JL9IxLIz3ig1lgvla4gW9fxDy9Fq7ZoPQ4iSvXzUmbh8kr94sZAJDqIyuFEFJnhqY9VwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262361; c=relaxed/simple;
	bh=dJR9nNad2bWkAwUzoEtLtG0zANlH91hPM+7eTojA13w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fgrpMS2+cRuqUvwV/UhugJ/zX2zrGH38uocK053nQaS3yxFOzjZmptxaEKvDcOxGyJeVCsfzEK15WbjRQBN11BanRM9kHJ4dBYw7SfnxQcVPQAsKYkHUTc1dqadKz/zlJ+dIP3j4PsWWyDGyaWcHULPrT4QCvnZ3YhPYVZjJT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0rDA2hz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0rDA2hz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E78FC2BCC9;
	Fri,  8 May 2026 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262361;
	bh=dJR9nNad2bWkAwUzoEtLtG0zANlH91hPM+7eTojA13w=;
	h=From:To:Cc:Subject:Date:From;
	b=r0rDA2hzWP4EukRpfAAMUhyPHS/x7dunWgtHfivJTb6ydVmpw6vfyMqiY5XZjny/K
	 LGZSRldKTlj31jTalXCZdJ558Ty5v4CQD6Ctd77r+wXZG0zubcYETIcpQuGM6s44Dr
	 8F6sLNE2/8L4OdmwlfCmcsfCSaGcmXRC7/VDMU/275KDSvEE4d05rWPd8anGw+qbh1
	 6yws7bB1ikxISIkqwnTSt91HxALyKeaVeTtpU/ElGIvn2IGeek6v65Jtyps4xjg1uA
	 eDgbglg6E8gAsyCYsrCvyUawsJXOFRONMRcOPiM6XoY9MEaUFvS4ukvwK04j9sl/F8
	 5P13/jAEo14nw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 0/4] platform/x86: xo15-ebook: Bind to a platform device instead of
 an ACPI one
Date: Fri, 08 May 2026 19:38:39 +0200
Message-ID: <2420444.ElGaqSPkdT@rafael.j.wysocki>
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

This series carries out driver conversion of the platform x86 xo15-ebook
driver on top of 3 preliminary changes.

Patch [1/4] fixes the handling of a wakeup source and ACPI GPE in the
driver during probe and removal.

Patch [2/4] cleans up label formatting in ebook_switch_add().

Patch [3/4] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [4/4] converts the driver to using struct platform_driver for device
binding.

Thanks!



