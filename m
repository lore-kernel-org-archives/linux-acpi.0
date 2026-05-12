Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694B93E1717;
	Tue, 12 May 2026 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603430; cv=none; b=E/aEAi1qT5WCWzvq0o4/Q15W+nvcgamTseNDd/xMx9lfqf7y+yEE9EuWWhv47QgQNh+fwlR2qortoVArmumzS5dcXvWW+S3EH9VM2AhAg6fipCOTL8BIlHTZa9NXRWw+gmdzXqc7NIrge8ZtOlhhkx62y1pb5PqOgELs3+qswPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603430; c=relaxed/simple;
	bh=1ou0Z/biZbUrVhctWZqb9cyANBFEN59kkoI9R3EaQ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PBP9Gwfgwcwg8mn6wbNEIZ0k8nMi6b65m6/F7X0MqIkLbuoij0RnPKulStNsnFMD8vuoJv5PXshQh79r8/rl+OVPMAp3sB3+AQJBQbDeleRj61VMPWTlMIv/HpB5S+WuNDW4eldiVFau7yhGYZyTduxdbCZSYHFN5AkRDYpm2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JarZAgNr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JarZAgNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7EBC2BCB0;
	Tue, 12 May 2026 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778603430;
	bh=1ou0Z/biZbUrVhctWZqb9cyANBFEN59kkoI9R3EaQ/k=;
	h=From:To:Cc:Subject:Date:From;
	b=JarZAgNr5CR/1Y3K77CasemF6bw6LGu/LWlaOtOIawe+OA7cVOvLGa/Hh0puST2Nb
	 H2RE7JqTK+S/fmqaFIk0wlQpmU+LMg9GVuSF9hPnX7PhX5Pvr1AWgN6snvAdqbJFd4
	 9/IK1c+VpEIpl1ztHZBanpC2udQcmYPPtzjGlQz6+IrPPxpSQUsiE2bCcoyqdPGAfF
	 uQ/CGcKskJLko0Q2RraUcZmq2RQ9KXjWEOPDpk5jUqd4MNdOmEiyic96jRLvT0FtDU
	 K+BDldE4DGQnk4j9S7oO50HIaTKMvj6AIK8nOsBFsQI1alRGh/wPgrsgn7PRnRBys3
	 Di7K7iA2BF1+w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1] platform/surface: surfacepro3_button: Check ACPI_COMPANION()
Date: Tue, 12 May 2026 18:30:26 +0200
Message-ID: <23119222.EfDdHjke4D@rafael.j.wysocki>
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

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
surfacepro3_button driver.

Fixes: d913a5a12b40 ("platform/surface: surfacepro3_button: Convert to a platform driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/surface/surfacepro3_button.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -185,12 +185,15 @@ static bool surface_button_check_MSHW004
 
 static int surface_button_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct surface_button *button;
+	struct acpi_device *device;
 	struct input_dev *input;
-	const char *hid = acpi_device_hid(device);
 	int error;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	if (strncmp(acpi_device_bid(device), SURFACE_BUTTON_OBJ_NAME,
 	    strlen(SURFACE_BUTTON_OBJ_NAME)))
 		return -ENODEV;
@@ -210,7 +213,8 @@ static int surface_button_probe(struct p
 	}
 
 	strscpy(acpi_device_name(device), SURFACE_BUTTON_DEVICE_NAME);
-	snprintf(button->phys, sizeof(button->phys), "%s/buttons", hid);
+	snprintf(button->phys, sizeof(button->phys), "%s/buttons",
+		 acpi_device_hid(device));
 
 	input->name = acpi_device_name(device);
 	input->phys = button->phys;



