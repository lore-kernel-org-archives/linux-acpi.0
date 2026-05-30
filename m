Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1890345CAB;
	Sat, 30 May 2026 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780134033; cv=none; b=gHArLWUwZhAno6G9emGdGam18BiezqqtlLhsrpz83AgP8sWojKS+WHazJwogzB46UrLF999O0psB8V4OWSh6LoP4lAvZN6g9JpMmPMyB8uK7Mmy2cQEck305qhocHGDETMrm1Mza9zOyETs3CfhBTKVmLI4nIxTGiP1XueUQBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780134033; c=relaxed/simple;
	bh=kUTwPGPqSZ5r2oSc2cjnVOl2CrgPD/WqeFzes/cUk7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfjUAkCgRqW3wv8SomQurS+q8rgwLEoqPYlRKx8q6V2S3oroqhjvX6bu9I/XtysgAufMTHe7TI1ll9xOZHddXQAEBrHqpJjeSD2LR3F9v7NSbR9QMlkFEX4NNZn7gaL+kUAsvCPX1EYIn14AvTqcx3wwMY1nrN/MowIfSJDBmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fnO7y4Vs; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fnO7y4Vs"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6135E27AC3;
	Sat, 30 May 2026 11:40:28 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xm7zx3vduy67; Sat, 30 May 2026 11:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780134027; bh=kUTwPGPqSZ5r2oSc2cjnVOl2CrgPD/WqeFzes/cUk7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fnO7y4VsJ958MHfrFplEeegx3qnvChDo4rIQ/UG8gE8VCqzGAOSXVvqgowAJg09WQ
	 ruZDy/X7ZOZIbAoV8aBF6eX5q7DQLO5xp2FYjpv8bG3gXJ4jgba5AGPqrpH7ETxYnG
	 e8kA+V8SXnlTv9knnUgqD4B8MGtA0vpj7045+tm/vXScZ6EapR0rV15FFtoTmVdmsN
	 UcprQ+wQtrczd1IIzNAKlpQnyigS5lGxMY6FLLT9efarXK5LXVkp9NUdgYo/ReCfcz
	 u7cu9vWQn0n+wrgrFbWQWXkSMk8eBAhWH7++eG8GxOqLk15hRB6lGZAx0Pd4rEQjZk
	 Z18LmbN9Brklw==
From: Marco Scardovi <scardracs@disroot.org>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <scardracs@disroot.org>
Subject: [PATCH 2/2] gpiolib: acpi: fix out-of-bounds pointer arithmetic in acpi_gpio_package_count
Date: Sat, 30 May 2026 11:40:12 +0200
Message-ID: <20260530094012.184276-3-scardracs@disroot.org>
In-Reply-To: <20260530094012.184276-1-scardracs@disroot.org>
References: <20260530094012.184276-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When counting GPIOs in an ACPI package, encountering a reference or
string causes the element pointer to be advanced by 3 (element += 3)
and then by 1 (element++).

If a malformed ACPI package contains fewer than 4 remaining elements
when a reference or string is processed, this pointer arithmetic
advances the element pointer past the end of the package elements
array. This results in undefined behavior and can cause out-of-bounds
reads.

Fix this by ensuring at least 4 elements remain in the package before
advancing the element pointer, returning -EPROTO if the package
structure is invalid.

Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/gpio/gpiolib-acpi-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 049e4cbc14ed..494dcd166aef 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1310,6 +1310,8 @@ static int acpi_gpio_package_count(const union acpi_object *obj)
 		switch (element->type) {
 		case ACPI_TYPE_LOCAL_REFERENCE:
 		case ACPI_TYPE_STRING:
+			if (end - element < 4)
+				return -EPROTO;
 			element += 3;
 			fallthrough;
 		case ACPI_TYPE_INTEGER:
-- 
2.54.0

