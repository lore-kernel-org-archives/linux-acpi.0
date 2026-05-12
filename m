Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EFC3B1037;
	Tue, 12 May 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595569; cv=none; b=mJzLY5p8H5Kjdvne6119M/35ztmRV/SIa5fYETBtRcbUpPtF4+wZkepK5J+5V4b05UwvOPhYeHKZPqr8YMfzkIUVSU3YlrYFZIXz9pm3ftuWjHrW9W7xiKsi2W2VbFoN4j8UPxkJIwa/XKm/L8puB8z4p8Mik7OZtaN9Nml3BwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595569; c=relaxed/simple;
	bh=M00Vvi1LUzRwd8T6JtZ1syr05U3z/HiDIk8TB5gIWAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GQpsNg3HQjpEY3jxiuGBvw0+wqz0nES0fzD/CTWwABvNoBYV2xdhc/kYbVxf9T/LmjFbCvMjdPkU8N3iCKOlhytYFY7RYsUc/tNCs78LXe5pg6xlAHGQWbIk0P5jXiGClcWngYFaGx2JYa8qvEv7mnPRDQ2QRK45bMx9wL6QvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puY7xDYR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puY7xDYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD33C2BCB0;
	Tue, 12 May 2026 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595569;
	bh=M00Vvi1LUzRwd8T6JtZ1syr05U3z/HiDIk8TB5gIWAE=;
	h=From:To:Cc:Subject:Date:From;
	b=puY7xDYRZtimw9zSSqX+GEf18F7yXaG1Ctwt3iiWgJSvob8jGqNGr9JvGaHZs69fb
	 J7aAOfWXheds+xesNQcf0hKWxe+8gdHBcPJGb4PxEQX1ygt7m3/oEOQBmMIwdy9UW2
	 AqIPZxKHN4mfWHwFDSh2bwXiIvqFfcQ0WqS3F70ay3gD06rbw5fSCiAW7Uu9w8y/y1
	 xp9LjAWuADKdssg2ZVSdJzEbbsYFIQ/djJil3RDxlFDieZqrTJyytw3MM1qZF4CkL3
	 RWbuanCEK1B8CuGyr/q8F7AOGuYUT0gRJuJWGT3fyQ0S9eMBt/eNAS/0YwmoUgLdTQ
	 RMPW6PEMDLFvA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <denis.benato@linux.dev>,
 Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>,
 Matan Ziv-Av <matan@svgalib.org>, Kenneth Chan <kenneth.t.chan@gmail.com>,
 Mattia Dongili <malattia@linux.it>, Jeremy Soller <jeremy@system76.com>,
 Azael Avalos <coproscefalo@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v2 00/16] platform/x86: Check ACPI_COMPANION() against NULL during
 probe
Date: Tue, 12 May 2026 16:01:43 +0200
Message-ID: <12904885.O9o76ZdvQC@rafael.j.wysocki>
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

This series replaces

https://lore.kernel.org/linux-acpi/5990022.DvuYhMxLoT@rafael.j.wysocki/

and, as a whole, it makes exactly the same code changes.

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, requisite ACPI_COMPANION() or ACPI_HANDLE() checks against NULL
are added to multiple platform/x86 drivers that have been converted to platform
drivers from ACPI drivers recently.

Thanks!



