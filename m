Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27A3B9DB9;
	Thu, 12 Mar 2026 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315056; cv=none; b=lFQ5B7q+6XHThv9QNHO91bzF2wsq13U+U3xK9oV8jPznHu7jnrqA7j+NOy5fSNfI6tKmUMLhm9qlc/j+CvufH+sT52xSXFblaITG03wZ8NQ/NmDiy59BCShNtcDXKx7AX5ut41MdOnxKGB44HMIYNzxob7bgL7Qy4ZIr7gT3Wic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315056; c=relaxed/simple;
	bh=8G79AZ4xvGj2cpl62V3jw2Gjwtl44n0GMajyrJqwkRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eeXIYhYW2AWUycGU69ZPapCkjszgNqNFJFkHKZn1jioYCkisyw+KMFgaKZwegoOXzLwLxlKaHq1qT0csNeDr+DMFiF0IdlKYGrvu9Kf2mSj0nDm8YDmNBL/rNLtMn906LUcmIJATqM1qp+oiI206c+CScm8hRMX1+4v9I2WqwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATUfpq6h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATUfpq6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE38C4CEF7;
	Thu, 12 Mar 2026 11:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773315055;
	bh=8G79AZ4xvGj2cpl62V3jw2Gjwtl44n0GMajyrJqwkRc=;
	h=From:To:Cc:Subject:Date:From;
	b=ATUfpq6hutHCmSQ0xyUZYaRq0jSRPDlfAHXM6PpY+zf3is9mTy3s58j/+m7PbqWzv
	 8TPe4uKBPoJJ+hAxOgsS0KyabBmDmr1Hu2G9cAu0egWB6YaEJl7UwCkibxJbzivydn
	 sVk1YnKxD4/q5CVNhJh8fduMj2T+CYMsgxgAolt9JMzqvNK7X22yBgnc1dyphbDJds
	 s0CHuwrK24CK5dEpkFY/urvINnf1mvYXtt7CihHEjcm55XLFfPeQLchTjD650kozgR
	 +6oGdfE2mgO+lI+o/zB3ljVnHeevgSNWiUwSr9PGgl5HcMEH3K7oTpDbdb/7G/FiWI
	 BpZ7etzOKqmbQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Mattia Dongili <malattia@linux.it>
Subject:
 [PATCH v1 0/3] platform/x86: sony-laptop: Bind to a platform device instead
 of an ACPI one
Date: Thu, 12 Mar 2026 12:28:06 +0100
Message-ID: <2284006.Icojqenx9y@rafael.j.wysocki>
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

This series carries out driver conversion of the platform x86 Sony
Notebook Control driver.

Patch [1/3] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [2/3] converts the NC part of the driver to using struct
platform_driver for device binding.

Patch [3/3] converts the PIC part of the driver to using struct
platform_driver for device binding.

Thanks!



