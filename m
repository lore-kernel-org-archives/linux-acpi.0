Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07123AD52A;
	Wed, 13 May 2026 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698428; cv=none; b=QSWmMTHFdBrWFGN+iMGN1x7JVdCNECLZHmZuN2NEqmx7f8T1K6kHAQl4CaCom9Nves8pQ5fbGOBaGCI+LZberAqngFapRd/E5RSQnbkvFEncs9JjzJWdBpA25nnxryFxHZu6wtn5xo9EG/tKAWw2l6Jlm4ScliKqmaU4CwkMp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698428; c=relaxed/simple;
	bh=h67Nep+/LeB6jgt3BV4Gbz4JxruB2JJ7D0Ck6gBRITQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K6V82eBzcphlsZNstbv8FU1jSKrJbgOgdW2joQck+VTzb6s3r6RpVR1ZBzScirdU15T123sALq/gjhTvI8J1zo/RIiGZdX6x9+uNCWyztxtM7NBf1uvatyWCEDOQ2ojRL6ptoiDSDF7T/lp9JL+GeX4xy50WS3xs1LQSdD9JLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsjhyh+j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsjhyh+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363D4C19425;
	Wed, 13 May 2026 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778698427;
	bh=h67Nep+/LeB6jgt3BV4Gbz4JxruB2JJ7D0Ck6gBRITQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Zsjhyh+jlhhxPk8OajbQ32XMuwacs0fhf+ytXQSFlcFoT6WyQzhc4jEKzEIgpTtsC
	 GF+eaVVtBMHtndnLY0xWUKZL9ud7BYwrwzSEtf5gq0DpG7bgRzS/XvwvQiC9pYpaPL
	 DS2GWDhvCjmSx8joQB5y6bsGlTwem2pUeGCfr1gl2ZN7HxQWul2LRT7ydSfExJT9xz
	 ty9SygHx06I46YyLS5h5L60bjbxQ9LVubkJluYyl4qnIDdZBia8JWo6AA8GG1mGMrw
	 J+aFV/BskyPTkQHzzvpARNk976jLsD9wpzWfrg9Zj4SBDGi8AKm7izWDYooNt6XAba
	 Fm7vqa7RY5QIg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1] platform/x86: xo15-ebook: Use devres-based resource management
Date: Wed, 13 May 2026 20:53:44 +0200
Message-ID: <12913455.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Use devm_kzalloc() and devm_input_allocate_device() in
ebook_switch_probe() for allocating the button object and the
input device, respectively, to simplify the rollback path in
that function and ebook_switch_remove().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

As promised, on top of

https://lore.kernel.org/linux-acpi/2420444.ElGaqSPkdT@rafael.j.wysocki/

---
 drivers/platform/x86/xo15-ebook.c |   41 ++++++++++++--------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -82,29 +82,29 @@ static SIMPLE_DEV_PM_OPS(ebook_switch_pm
 
 static int ebook_switch_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	const struct acpi_device_id *id;
 	struct ebook_switch *button;
 	struct input_dev *input;
 	int error;
 
-	button = kzalloc_obj(struct ebook_switch);
+	button = devm_kzalloc(dev, sizeof(*button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, button);
 
-	button->input = input = input_allocate_device();
-	if (!input) {
-		error = -ENOMEM;
-		goto err_free_button;
-	}
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	button->input = input;
 
 	id = acpi_match_acpi_device(ebook_device_ids, device);
 	if (!id) {
-		dev_err(&pdev->dev, "Unsupported hid\n");
-		error = -ENODEV;
-		goto err_free_input;
+		dev_err(dev, "Unsupported hid\n");
+		return -ENODEV;
 	}
 
 	strscpy(acpi_device_name(device), XO15_EBOOK_DEVICE_NAME);
@@ -115,21 +115,20 @@ static int ebook_switch_probe(struct pla
 	input->name = acpi_device_name(device);
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
-	input->dev.parent = &pdev->dev;
 
 	input->evbit[0] = BIT_MASK(EV_SW);
 	set_bit(SW_TABLET_MODE, input->swbit);
 
 	error = input_register_device(input);
 	if (error)
-		goto err_free_input;
+		return error;
 
 	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						ebook_switch_notify, &pdev->dev);
+						ebook_switch_notify, dev);
 	if (error)
-		goto err_unregister_input;
+		return error;
 
-	ebook_send_state(&pdev->dev);
+	ebook_send_state(dev);
 
 	if (device->wakeup.flags.valid) {
 		/* Button's GPE is run-wake GPE */
@@ -139,16 +138,6 @@ static int ebook_switch_probe(struct pla
 	}
 
 	return 0;
-
-err_free_input:
-	input_free_device(input);
-err_free_button:
-	kfree(button);
-	return error;
-
-err_unregister_input:
-	input_unregister_device(input);
-	goto err_free_button;
 }
 
 static void ebook_switch_remove(struct platform_device *pdev)
@@ -162,8 +151,6 @@ static void ebook_switch_remove(struct p
 
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
 				       ebook_switch_notify);
-	input_unregister_device(button->input);
-	kfree(button);
 }
 
 static struct platform_driver xo15_ebook_driver = {



