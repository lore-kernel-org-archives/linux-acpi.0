Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AE03DB62A;
	Tue,  2 Jun 2026 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400149; cv=none; b=bqXuGtiK2UeYPNo5rPOpkPuuHEOsENPcD5lb1smNei9R21U3Y9UU7fuE8jEXdDmB7qedEyRQQMvm5ck+8Era4JBAxv3h//bQE4Y6cC9opD2tUn5wgjnW/E61MR1VQk2euVHE2GBktDIB1mypji4BQTbMSLK0iPqwA9i8dJiOFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400149; c=relaxed/simple;
	bh=TjwWVdwib0ZQBloSbHHqWYju7lPBY5ugZ3j4GxE6If4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAeHDe8zGRO+TTed8MNviuScmhuMlF0S7C/eSUTFnYJwsttck1TfphzXS6JSb+iEltOZgDxbR81Mcgscnsr8xWXmhVDxghTUAKhCCcXEZbfRRy9tXiHcpvWRBzCLYxnf5JONGExCrhQL2HL3+VzkvrpTCdRdA51DCGte66/2VVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XMzVwmgK; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XMzVwmgK"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4AD18276E9;
	Tue,  2 Jun 2026 13:35:43 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AitEPwiF-lhp; Tue,  2 Jun 2026 13:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780400142; bh=TjwWVdwib0ZQBloSbHHqWYju7lPBY5ugZ3j4GxE6If4=;
	h=From:To:Cc:Subject:Date;
	b=XMzVwmgK4EDZItKjUMOkHJaipWVN3otcIrySfky3gJI/EM+rFHMKU/RTy8kCcthnv
	 IHBFBqUOTC/BdvK7u4PRZQ28bUFHmVvhf+fpnrWhBNcH/QeYUQdhnMUDNLrXrY9beB
	 E2DfICV3yxXkMdQEUb8FZ8NM7Opxe49Cx1Sq3csF1W3GQN62IiJrfkLVFkq2nP8cdi
	 9j2FMSPbbSfdZREWlN38eGprgelDP3/SKcBzwB0CNAQ84bZmw/+nzB/0H++VReykm6
	 zwWebq73l5mYDYAf2aDIIjYEbZ6zI9MVAp5npLev6VRjJ3EuRtpNRo1fOsTbddMPSI
	 151fAtdHVK/Hg==
From: Marco Scardovi <scardracs@disroot.org>
To: andriy.shevchenko@linux.intel.com,
	mika.westerberg@linux.intel.com
Cc: brgl@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] gpiolib: acpi: Add bounds-checking and address validation
Date: Tue,  2 Jun 2026 13:32:18 +0200
Message-ID: <20260602113529.52570-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

after some thinking and following Mika and Andy's reviews I've come up with
a new version of the series.

This series adds defensive hardening in the ACPI GPIO path, focusing on
bounds checking and safe handling of GPIO resources and ACPI addresses.

Drop the previously proposed GPIO connection handling changes in the ACPI
OperationRegion path, following review feedback.

This also closes the old threads completely and drop my @gmail account
as it is not related to my linux stuffs.

Changes in v5:

* Add bounds checking for GPIO pin resource accesses in ACPI GPIO helpers
  to prevent out-of-bounds access on malformed or empty pin tables.
* Validate ACPI address in acpi_gpio_adr_space_handler() before converting
  it to a GPIO index, preventing truncation-induced wraparound.
* Improve type safety and overflow handling in length calculation and loop
  bounds in the OperationRegion handler.

Changes in v4:

* Dropped connection resource leak fix to keep focus on validation.
* See v4 series at:
  https://lore.kernel.org/linux-gpio/20260531120816.17255-1-scardracs@disroot.org/

Changes in v3:

* Fixed global over-cleanup bug in OpRegion error path.
* See v3 series at:
  https://lore.kernel.org/linux-gpio/20260520074955.55443-1-mscardovi95@gmail.com/

Changes in v2:

* Dropped gpiolib-acpi-core.c modularization (out of scope).
* Split series into bounds checking and address truncation fixes.
* See v2 series at:
  https://lore.kernel.org/linux-gpio/20260519070039.9280-1-mscardovi95@gmail.com/

Changes in v1:

* Initial ACPI GPIO hardening series.

Marco Scardovi (2):
gpiolib: acpi: Add robust bounds-checking for GPIO pin resources
gpiolib: acpi: prevent address truncation in OperationRegion handler

drivers/gpio/gpiolib-acpi-core.c | 40 +++++++++++++++++++++++++-------
1 file changed, 32 insertions(+), 8 deletions(-)

--
2.54.0

