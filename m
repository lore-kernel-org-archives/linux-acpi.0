Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326332D97B7;
	Thu, 12 Mar 2026 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326088; cv=none; b=Xy24TeYhInYxL0dblU/qmS8A7Hqk4zlTll5uo7isnQh9+Q7OBx1VqWbWrzWiIAyQZMS5NOHsUj2CY5yqWW8cguSFXh6SFE9MbNu/Sw0d0cgO6Fmub3XmGgu2aVmGQjoTUnXCsdxfAHhHBh1hy41Fpw9fiMif1GDxaDbVEIrN4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326088; c=relaxed/simple;
	bh=sQIT+TdKp9fRyI1aY2xxIQB0uwiZ3BQ+3vvJRd1Mg4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RGgDA98+SuIglzyWezD9CFSlC1yrb/5PR0wDr/5B7V0D6HjtBqAnYxmV6CQ/OMuDfkS6OuUQj6grkaCP9aSMi8jvY9PBHwgKhUNyXwHG9AOZ/t6inuKDqXj8SttnFLKWaMFUUVMeUSWWImuSE+X7CQqzMKHKsk01vZUDVe0g+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rII1Zxbl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rII1Zxbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C926C2BC86;
	Thu, 12 Mar 2026 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773326087;
	bh=sQIT+TdKp9fRyI1aY2xxIQB0uwiZ3BQ+3vvJRd1Mg4c=;
	h=From:To:Cc:Subject:Date:From;
	b=rII1ZxblGS8bsTeUwzHA4BpIfBhc8aVQnm8RB1XVA027diZX5V+zm34RCRIOU9pHo
	 uZLzvU43aMybk/tyl5PT4kLhqFDuxJdOi0XS01pY57Ww+2eLNDx7OpSkfYpgouN4P9
	 ictj2g5s/by8nrUiuW1KbJoWGtSsimGI02IyVGpUqb6ckHWGkq64UEE3AYXNOu3piZ
	 dpHnXgO/FghbDlb1h0c4/+3lOk0ol2g+AUlvNtbXUqqrdZBuoGjqDo+lzdHCyuEIWp
	 nF93WnOCyUWrLljPMAy5XZi07lQuQLX8ZbWTMzdukFUSpTMYXgbMc8ZT0zlaJuiJf3
	 OMATq/dX6b3cA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Herton Ronaldo Krzesinski <herton@canonical.com>
Subject:
 [PATCH v1 0/2] platform/x86: topstar-laptop: Bind to a platform device
 instead of an ACPI one
Date: Thu, 12 Mar 2026 15:31:16 +0100
Message-ID: <3053187.e9J7NaK4W3@rafael.j.wysocki>
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

This series carries out driver conversion of the platform x86 Topstar
Laptop ACPI Extras driver.

Patch [1/2] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Thanks!



