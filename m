Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A9478879;
	Sat, 28 Feb 2026 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292204; cv=none; b=sVCJKQLSBqJ4rvh47BS7pbTXWeapNH/1toDMUYYp1mzONRZMuq5kCEfrEgphbCDih2TBcC1vzET3kO4DurSaZM5yV7Yh+RNfudfmRF0kyK5mLp9CmAbGZfJbN+0Ur1PUAdGYs7N4vi+b1SxEg2MubxHPc9wbx5TVe7fEoyIyCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292204; c=relaxed/simple;
	bh=NAo3gqYBmHdld4EswaUCvURmw367+eERnJq58448l9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rrIQvLKTnxQtSgzJPl5uRZjR38DyNEGu4enA45R2gnL7ysaNSstcr/UKD9T+01I7UKhr6cm2OLNMWs3gZ/5ZtxMkgN6f8lEK3cjUTvh0ixouYhWgRM3nAIPKEXZo7UHHEgaLeihvQD3+ljpk1IoR+aUaLqGMtJn6mhmAZlFRJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djxrA5pr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djxrA5pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE77AC116D0;
	Sat, 28 Feb 2026 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772292204;
	bh=NAo3gqYBmHdld4EswaUCvURmw367+eERnJq58448l9M=;
	h=From:To:Cc:Subject:Date:From;
	b=djxrA5prWmTI1NDlmSW26shelNNheqzIJCkoNZmH0F2No3dxBHXPmmzmMzyoiCPxL
	 vUMV9WBx86Nj0uHxqGjHq4+zRBZicq+40MZebCHvvX451BufzE15glKxmsJHjTgrXY
	 KBqQqKy/xWmvGEcz63QGhUCH0a9MRZaqi81OetL/t4CQZbelLAjOYB02Q4ZpR7BLVY
	 mLfyzBFg1lzo/ZMiv3lX5BfSc/u8sd56hR3Aszl6V2TTphVJh+81XMD4ald+J8/WDk
	 wszDEu0ev0O+mgpTILLEF0/H1GmFQfYCD0vtN0foxStz6vWdkOuO7CblBB4qMbOZvw
	 xmUZ5xwfzVdRQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <benato.denis96@gmail.com>
Subject:
 [PATCH v1 0/2] platform/x86: eeepc-laptop: Bind to a platform device instead
 of an ACPI one
Date: Sat, 28 Feb 2026 16:21:17 +0100
Message-ID: <7916328.EvYhyI6sBW@rafael.j.wysocki>
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

This series carries out driver conversion of the platform x86 eeepc-laptop
driver.

Patch [1/2] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Thanks!



