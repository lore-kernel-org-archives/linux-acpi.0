Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133923D7A15;
	Thu, 21 May 2026 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372736; cv=none; b=aWrUQs9gbVDXfbZjnZkZpILDPFEU2270dzNxvCOXEGMLx1GUfUzdv3NkPXbrBMgdXRFrdc00Gs9B+LwlRNV1cbHesV5f2kfS5UhyVM26MZgZilaSpY2LhNeYRttNqXBRa8q4L6lE2ez+kaJgDze9/lkYEKEQtWz6MJhppW0R76I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372736; c=relaxed/simple;
	bh=ZFz5EZW8z69WUJOqclsCAqZnMqKT1yyLIo2aVCFYH3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dW5Z8wUOGrfOZSYTMM1xrqjIooWOT0pcSpYcPUlyHl/N0df+oSCtW+LldNLO51lQT6mrAlHoNtOdnbT2eLZi4CuqCwPgoNvtIAEnbYZiA1kToBWOSw1RSnWYc00BOIXPS7uhaNaRH1Fg7CzfclnBScVuVp5P0Z7DAES6ljGUmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkHCiBbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkHCiBbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D071F000E9;
	Thu, 21 May 2026 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372734;
	bh=OrEp4eXR05yvht2oqzbzM8phegaNlcx0+iUZSWvsXhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AkHCiBbxuL0+X9BMwPrmpxJFCrW6AFiAwxP10Hl7jotwsyBT/1X/r5LL1HJMHFxQT
	 0qTKFlgphfdvjDgvImnleLwBS5NDXWsUrc4ST13UjxmxiGcwAQ1HnW2NXXshX1e7Xm
	 VU6eLLCua4DBPxKlEU+Zcq2e+fH+MEO+SMEKujPdPnxjZ0Fsw6ZA606F+nuULj3tgU
	 hfMjikMCLNwALR7Hzs2RAaF5hvcWczssNo/8ZIZwOpvS1nzN09tDPHJjOxmYzZLKN9
	 G/1CS0txxPRJctZc8jArOOSxKT84SnHcONfXKp+eSFRDUIRFyXa5rZv8Wz8czO/qG9
	 ZP4rJXlyr+SQw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 11/17] ACPI: PAD: Switch over to devres-based resource management
Date: Thu, 21 May 2026 16:07:29 +0200
Message-ID: <1964581.CQOukoFCf9@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4739447.LvFx2qVVIh@rafael.j.wysocki>
References: <4739447.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Use the newly introduced devm_acpi_install_notify_handler() for
installing an ACPI notify handler and since that function checks the
ACPI companion of the owner device against NULL internally, remove the
the explicit ACPI companion check from acpi_pad_probe().

However, to prevent the notify handler from running acpi_pad_idle_cpus()
with the number of idle CPUs greater than zero after acpi_pad_remove()
has returned, add a bool static variable for synchronization between
the two.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pad.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 48c00ee61ed2..5792f93d3534 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -31,6 +31,8 @@
 static DEFINE_MUTEX(isolated_cpus_lock);
 static DEFINE_MUTEX(round_robin_lock);
 
+static bool acpi_pad_teardown;
+
 static unsigned int power_saving_mwait_eax;
 
 static unsigned char tsc_detected_unstable;
@@ -359,6 +361,9 @@ static int acpi_pad_pur(acpi_handle handle)
 	union acpi_object *package;
 	int num = -1;
 
+	if (unlikely(acpi_pad_teardown))
+		return -1;
+
 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_PUR", NULL, &buffer)))
 		return num;
 
@@ -418,22 +423,16 @@ static void acpi_pad_notify(acpi_handle handle, u32 event, void *data)
 
 static int acpi_pad_probe(struct platform_device *pdev)
 {
-	struct acpi_device *adev;
+	acpi_pad_teardown = false;
 
-	adev = ACPI_COMPANION(&pdev->dev);
-	if (!adev)
-		return -ENODEV;
-
-	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					       acpi_pad_notify, &pdev->dev);
+	return devm_acpi_install_notify_handler(&pdev->dev, ACPI_DEVICE_NOTIFY,
+						acpi_pad_notify, &pdev->dev);
 }
 
 static void acpi_pad_remove(struct platform_device *pdev)
 {
-	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
-				       ACPI_DEVICE_NOTIFY, acpi_pad_notify);
-
 	mutex_lock(&isolated_cpus_lock);
+	acpi_pad_teardown = true;
 	acpi_pad_idle_cpus(0);
 	mutex_unlock(&isolated_cpus_lock);
 }
-- 
2.51.0




