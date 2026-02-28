Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4445BD59;
	Sat, 28 Feb 2026 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291609; cv=none; b=OKTaC4dqd5o2x3wIfcv/kcydyLmhNCjBK7hHmyGZdY7PJVBRTFVis6CeJ1qZBb+qW8Mr39Q6bf6N5kR/UOyRC/cn5Rzj6XnXjKhojurZiRH+b1h2qlqYoBL7AqzPU4jG4Yan007rhnDlDB8jqr/7SjBr3GRbarbB64tsV3XLDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291609; c=relaxed/simple;
	bh=Dcj5XSusjpBUWlJoE51CNZ+xiv9mHuVUuqJjDCZfUk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cnFmKJw8xkVGndcWCZ6KKNfRdiRNyJ5pGTbUKYr3zY8bHK6IOut0TzJ/KZSxPWfDw9Sxji6j3BMYx146QluySyqZOuIf6rdmoI3sTxPIHYMmQZHlsXuCMmZkoD62AAmvPU9gu/cKeQep+uGHt5mQerItSo8VW4auuJDJmhnSHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcJeT7qu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcJeT7qu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1BBC116D0;
	Sat, 28 Feb 2026 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772291609;
	bh=Dcj5XSusjpBUWlJoE51CNZ+xiv9mHuVUuqJjDCZfUk0=;
	h=From:To:Cc:Subject:Date:From;
	b=UcJeT7quOHPnRTq4rmaa4PSLYWCFAWYZfBRQ6j3G/xIrDEw0w8VpVhECrC49Hskpm
	 I2UPwcNGyGpjbdUo+S+T7GjjBi87vxm/6ZDss0QTZss3WBKopCLcv7NvlKv7G2phR0
	 Q1d2K0YRHOE7KYJY4wippIizK92VTkj17/r7m8SD09Nqvlg8WtAGf4tTqEEaKH6mMj
	 qtwR9Z0/Yii8unpg2MfjjXGwlb9igt31xCgpPUQN80cy9bOlFsBGB+PNjjI6Cp4Hru
	 GbjZuHVSQ/xK/llvnBoW+mSciM1c8+9O+Q8tQ361687y/iZkKSeIzMmhkxY2i52dSp
	 DBGEHKAl2Rzwg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <benato.denis96@gmail.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject:
 [PATCH v1 0/4] platform/x86: asus: Bind drivers to platform devices instead
 of ACPI ones
Date: Sat, 28 Feb 2026 16:09:20 +0100
Message-ID: <5971620.DvuYhMxLoT@rafael.j.wysocki>
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

This series carries out driver conversions of the platform x86 drivers
for Asus platforms.

Patch [1/4] updates the asus-laptop driver to install an ACPI notify
handler by itself instead of using the .notify() callback from struct
acpi_driver, which is requisite for the driver conversion.

Patche [2/4] converts the asus-laptop driver to using struct platform_driver
for device binding.

Patch [3/4] updates the asus-wireless driver to install an ACPI notify
handler by itself instead of using the .notify() callback from struct
acpi_driver, which is requisite for the driver conversion.

Patche [4/4] converts the asus-wireless driver to using struct platform_driver
for device binding.

Thanks!



