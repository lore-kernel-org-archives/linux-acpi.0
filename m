Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0DF43636A;
	Fri, 15 May 2026 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845653; cv=none; b=iqxVqK322xCXY8Q85f9nDkIZ0iLKqzYlUeeqpI/R8maPRxrUhiS89JPUoqbNjpcsld0xhJ/oLg2Md9bGt44a7Q+hD3xIrK30TbhrbGPcPSUP02PlneU3kvDnXqXljpyDbfmsl3IF024SW2mftxEVaYapWXaxOmp6DBDaikOtUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845653; c=relaxed/simple;
	bh=IHy6tCCL6ZboGN6XiT9mrdDppkHa9GfP65Sh+0zol1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MvA9tznQBYzpY/YZWQX7UwsIfNUYqbHYnvRgfBxL5W6TBc/TNp83rjT6dtwb2PrWAq+O8htRuUZiurv+DgCohaTQw3C2nyhAUizF/sCQ+vBI4Om68ZvIfHW24dT0kLQn0Ad8uvXeA0CvFq0tYDNuL4AY9tjZ5zijy5UqPOyBIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG8E7XbG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG8E7XbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E78C2BCB8;
	Fri, 15 May 2026 11:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778845653;
	bh=IHy6tCCL6ZboGN6XiT9mrdDppkHa9GfP65Sh+0zol1g=;
	h=From:To:Cc:Subject:Date:From;
	b=pG8E7XbG6uMsr4TOp31ODdvYiRZp+lbJ8ue3eQow6PhqKykU6CFDuh4PuSaEEOfzW
	 pLAkfHNiK3hWidJS611fHC+K9uGuyoelu+s9G+vj+Tua3v1JgvurDGNiqt2ImKUpoV
	 K1V+2wStsYzrGL8cqcQ30TWNnOTrZoW1FCDi2HSrpZ/vUQ7XcV2zGoqOJ98hbBeSVc
	 ZeZpj1JnJh9Udyrbr7oGcjEOZhVjjZ1dLTNJcMWWgQ2WCmJc7qj6wZGxUexs50oiuz
	 EhHe+F/frYelmeI8/6VwvAFEk9+9H94W/vg2Cr29JStRdDvT+0RYXeMoGrVF5+pOrZ
	 3YVlUCNJiDmYQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v2] platform/x86: xo15-ebook: Use devres-based resource management
Date: Fri, 15 May 2026 13:47:29 +0200
Message-ID: <6015220.DvuYhMxLoT@rafael.j.wysocki>
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

v1 -> v2: Use dev_err_probe() after failing acpi_match_acpi_device() (Andy)

Applies on top of the driver conversion series

https://lore.kernel.org/linux-acpi/2420444.ElGaqSPkdT@rafael.j.wysocki/

---
 drivers/platform/x86/xo15-ebook.c |   43 ++++++++++++--------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -82,30 +82,28 @@ static SIMPLE_DEV_PM_OPS(ebook_switch_pm
 
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
-	if (!id) {
-		dev_err(&pdev->dev, "Unsupported hid\n");
-		error = -ENODEV;
-		goto err_free_input;
-	}
+	if (!id)
+		return dev_err_probe(dev, -ENODEV, "Unsupported hid\n");
 
 	strscpy(acpi_device_name(device), XO15_EBOOK_DEVICE_NAME);
 	strscpy(acpi_device_class(device), XO15_EBOOK_CLASS "/" XO15_EBOOK_SUBCLASS);
@@ -115,21 +113,20 @@ static int ebook_switch_probe(struct pla
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
@@ -139,16 +136,6 @@ static int ebook_switch_probe(struct pla
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
@@ -162,8 +149,6 @@ static void ebook_switch_remove(struct p
 
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
 				       ebook_switch_notify);
-	input_unregister_device(button->input);
-	kfree(button);
 }
 
 static struct platform_driver xo15_ebook_driver = {



