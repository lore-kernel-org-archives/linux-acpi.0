Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DFC40F8CC;
	Wed, 10 Jun 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106147; cv=none; b=TO9e0lWpXN18penMn08OlDVwfZkL27eiyloOyaTQcPhQ+0UZwfitTKHwCZ6KE9lmYEMthXgcvr7fNuFntVn3kmcExp+rIiyTQVEqT01AANgoQhGeKSa3nNrmVLlfgAzRqApe3O0fmudVLZIiVdN2yEEh8IlZYSZtwKautr509JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106147; c=relaxed/simple;
	bh=02qHKq/wpjrU3Zpo+QXsFmqiJeihLt2qusX03B77E08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d80XgkX+qxTtP6c5AmruheyLifDVGWkGcg0rX19Up8hUBqtYj/Npvk1Vn1f0ijJOqksVo8HrhRiL/kylD/Zi68ji1Y0VVT3+95kJ92ILYW83YhB9OGNBfg7QlMuBIFFRT8sro26/ToboQYKGoV8Juyr2UxTBmzriTp4w3XakM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kEpSL967; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kEpSL967"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 82ED126FC5;
	Wed, 10 Jun 2026 17:42:24 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zq8J03xMRTJR; Wed, 10 Jun 2026 17:42:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781106143; bh=02qHKq/wpjrU3Zpo+QXsFmqiJeihLt2qusX03B77E08=;
	h=From:To:Cc:Subject:Date;
	b=kEpSL9675VQ0x9ALIGY7PCDomcC3pCHP/JMyV1426y6hEcB0A//AUCcWPGJo+sJ41
	 HbKF8YGXL0ZRl5QNpgeGG1m7PJ3TJEBZ+qh84jBzkrG1XtrTV8ZaHzYmugobQ02pdF
	 d/+kvDYNMtmtl0k0YAQCDgBWxUzisIORF7bWodpL2NqXhqGYBfCdqEGrSAAI+viNYb
	 E4b/qDD4zHkZ8cyS50Jwt7J7rtXqTrqHMWZojXUv5Q6tNQ0JKpEiU2ONcCt7NUcPzD
	 rQlBcs6axdy7QzbZubIVFpy1I9dDERqar7GfddCpjziA9hMYuYvo5a3aUBYYhAgmPH
	 5/xw22LozPpmA==
From: Marco Scardovi <scardracs@disroot.org>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] gpiolib: acpi: Add robust bounds-checking and safe address handling
Date: Wed, 10 Jun 2026 17:42:02 +0200
Message-ID: <20260610154204.110379-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

The series adds explicit bounds checking for GPIO pin accesses and
ensures safe handling of ACPI addresses in OperationRegion handlers,
without referring to truncation or wrap-around behavior, which does
not apply.

Changes in v6:
- Rebased onto next-20260609.
- Corrected commit messages to describe bounds checking and
  safe ACPI GPIO address handling.
- Removed references to truncation or wrap-around behavior.
- No code changes compared to v5.

Changes in v5:
- Changed the types of length and loop counter 'i' to unsigned int in
  acpi_gpio_adr_space_handler() to prevent signedness mismatches.
- Replaced the min() macro in the length calculation with an
  overflow-safe check (bits > agpio->pin_table_length - pin_index)
  to prevent integer overflow.
- See v5 series at:
  https://lore.kernel.org/linux-gpio/20260602113529.52570-1-scardracs@disroot.org/

Changes in v4:
- Dropped the connection resource leak fix to keep the series focused
  strictly on bounds-checking and address validation.
- See v4 series at:
  https://lore.kernel.org/linux-gpio/20260531120816.17255-1-scardracs@disroot.org/

Changes in v3:
- Fixed a global over-cleanup bug in the error path of the OpRegion
  handler.
- See v3 series at:
  https://lore.kernel.org/linux-gpio/20260520074955.55443-1-mscardovi95@gmail.com/

Changes in v2:
- Split the original single patch into two distinct patches: one for
  bounds checking in the event/wakeup path, and one for safe
  handling of ACPI addresses.
- See v2 series at:
  https://lore.kernel.org/linux-gpio/20260519070039.9280-1-mscardovi95@gmail.com/

Changes in v1:
- Initial submission of the refactored, hardened, and modularized
  ACPI GPIO core.
- See v1 series at:
  https://lore.kernel.org/linux-gpio/20260518075357.112584-1-mscardovi95@gmail.com/

Marco Scardovi (2):
  gpiolib: acpi: Add robust bounds-checking for GPIO pin resources
  gpiolib: acpi: Prevent out-of-bounds pin access in OperationRegion
    handler

 drivers/gpio/gpiolib-acpi-core.c | 38 +++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

-- 
2.54.0

