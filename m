Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737EF3DC4D9;
	Mon,  1 Jun 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334019; cv=none; b=R0eI5ipbU9bzC6/FbA0eXfPWI0FaVftmubmC7AdZAuA3q3PHuQFgfKsZvO35QpHokmfBhUN51I6OtMnup89EhohnPlMimm5wpgEPy3HaZqcUzQftnqW5qjaK9/rLMHJvT61HaV8ck26qIl4nVpqUvH27+MlFrKpt+mzlXO3qJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334019; c=relaxed/simple;
	bh=2FiR+DiscdTLLNqM5DJirZfJm2DjV49YcCgIbLpEuyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCrzQNEq5rYRpd1Do2SYyasRP2QhOA7hGn6zimnAIwK9+n2olQDlLdepg0YN/ugeC+X7Fd22v//JHjO00d7vq5n6YfisRkuhiyeCBSfH58UzKTF5/YO2xwWb4TqHuFHONd2f7nigUrgomdCMglpKTJEhTiitFolyBYteqR8O+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGidGvhY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGidGvhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EED1F00893;
	Mon,  1 Jun 2026 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334018;
	bh=3e49syeeK/ptZEW4bn5jYPl44JBmzDYL6MFXKt6MOUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iGidGvhYmH3acfRiP+r5O0+mAwIMDAYjVGqViDcSosKdgkOCZPHiWCtrMR6S35j2i
	 4ppxhrep4BFh2jqJsKDPimfRYEYnPBihGhZwD3hB5/W/NN9joySYYZwzqfTZNTJ0DN
	 YvCkID40QxVbVPEhHiJ92VlnUcl92Uo3kyPe/SrGRTjbEW+JCTkmoAzFF529IXvXVW
	 zcl4ZjATBGwoRFUMAmahsO9kRORcuskz4dYm5WaMdypmbi+MG0tzwLi2ysYZ7opFgi
	 5JMkqWpBUKLsxm2vh3UR3ETSlBf5E79xMSFhrwCCcVEvO7vAzUiKV9QzPuEQK3VSd8
	 TTGQsjBBsJTfg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 08/15] ACPI: button: Use local pointer to platform device dev field
 in probe
Date: Mon, 01 Jun 2026 19:01:41 +0200
Message-ID: <2049596.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12913564.O9o76ZdvQC@rafael.j.wysocki>
References: <12913564.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To avoid dereferencing pdev to get to the target platform device's
dev field in multiple places in acpi_button_probe(), use a local pointer
to that field.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 236eb025bb0d..9fe8d212b606 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -541,6 +541,7 @@ static int acpi_lid_input_open(struct input_dev *input)
 
 static int acpi_button_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	acpi_notify_handler handler;
 	struct acpi_device *device;
 	struct acpi_button *button;
@@ -550,7 +551,7 @@ static int acpi_button_probe(struct platform_device *pdev)
 	const char *hid;
 	int error = 0;
 
-	device = ACPI_COMPANION(&pdev->dev);
+	device = ACPI_COMPANION(dev);
 	if (!device)
 		return -ENODEV;
 
@@ -565,7 +566,7 @@ static int acpi_button_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, button);
 
-	button->dev = &pdev->dev;
+	button->dev = dev;
 	button->adev = device;
 	button->input = input = input_allocate_device();
 	if (!input) {
@@ -615,7 +616,7 @@ static int acpi_button_probe(struct platform_device *pdev)
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = button->type;
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = dev;
 
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
-- 
2.51.0




