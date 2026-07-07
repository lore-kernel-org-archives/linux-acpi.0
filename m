Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C2372661;
	Tue,  7 Jul 2026 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422763; cv=none; b=H53zrN7hbAasb8+ME8/QLhoyfQVFrNhVXx0vCVqjFP/taJb4As4d5c5EE0mVM3+fiTTuzeip8dnZY3UJNFiCnb7rXFz+u9Tdua9sEAUuUkgZLi4bl6c1qal/Z39+Z7Nne01oHipfmI5Dl+f8WAykN9JxbHBRbnEQ1exQYHj9clg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422763; c=relaxed/simple;
	bh=3E+FfDZekyWexjqd33VIDTatlPwxH3hlxzLBG1ppbzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cm4h8WuV4rtdVT8XO751d86SPqKqs0Wh4BWNkrh+Duzp37hTa7M5ENbsHg+oi10GwV36JJMrll4L1uCOvkCcFngmL8umoD9zApJNE5FIutX/fa1EAwa6qJUJ/zwzMzdYGPlF5FjPelH2dLknYkIzuhtdBB/48oMZikI8GeudClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8OMVCVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8OMVCVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F111F00A3A;
	Tue,  7 Jul 2026 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783422759;
	bh=pyvhNuRWC45cC/GsxP7LT3Pbqsqw0s7MbBgV7p5Lw6I=;
	h=From:To:Cc:Subject:Date;
	b=A8OMVCVIufsat+nLnqVjAGKap0VJ6V50dHh/KlnalbxucKsi79i8QkahNxint3bRw
	 XcoSSitElqi24sqN4D1a3l0KZHKl9INLntN4dl6lh/DflcfZiaqZdHcpbEGQ1fWIy0
	 ZZOvmW7t56AqhA27auJ7as8dtQcFV+hyUywJF5WueqOglI62wPx4vWZ+MzxaHfjNGd
	 hyyVb2o4b5Mxm2nVjwj8H5ma5ewKw4Lo8c4bMgT16UVtdZEudi7vFbrkgbaG22SMr3
	 UBZQbPiUBNlUBrtmA+9uoccplWd9vhbCQhv71dq4W1OdpHswkav783vyLxtcPlKuvs
	 jJZGidzP26Obg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>,
 Maximilian Luz <luzmaximilian@gmail.com>
Subject:
 [PATCH v2] platform/surface: surfacepro3_button: Stop setting
 acpi_device_name()
Date: Tue, 07 Jul 2026 13:12:35 +0200
Message-ID: <12927239.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] platform/surface: surfacepro3_button: Stop setting acpi_device_name()

The driver sets acpi_device_name() to initialize an input class device
name initialization and print a message on probe success, but the input
class device name can be set directly to the "Surface Pro 3/4 Buttons"
string literal and used for printing the message.

Make the driver do so, stop setting acpi_device_name() in it and drop
the symbol specifically defined for this purpose.

No intentional functional impact.

This will facilitate the removal of device_name from struct
acpi_device_pnp in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
---

v1 -> v2:
   * Use input->name for printing the final message in
     surface_button_probe() (Andy)
   * Add R-by from Yu

---
 drivers/platform/surface/surfacepro3_button.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -20,7 +20,6 @@
 #define SURFACE_PRO3_BUTTON_HID		"MSHW0028"
 #define SURFACE_PRO4_BUTTON_HID		"MSHW0040"
 #define SURFACE_BUTTON_OBJ_NAME		"VGBI"
-#define SURFACE_BUTTON_DEVICE_NAME	"Surface Pro 3/4 Buttons"
 
 #define MSHW0040_DSM_REVISION		0x01
 #define MSHW0040_DSM_GET_OMPR		0x02	// get OEM Platform Revision
@@ -212,11 +211,10 @@ static int surface_button_probe(struct p
 		goto err_free_button;
 	}
 
-	strscpy(acpi_device_name(device), SURFACE_BUTTON_DEVICE_NAME);
 	snprintf(button->phys, sizeof(button->phys), "%s/buttons",
 		 acpi_device_hid(device));
 
-	input->name = acpi_device_name(device);
+	input->name = "Surface Pro 3/4 Buttons";
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
 	input->dev.parent = &pdev->dev;
@@ -239,8 +237,8 @@ static int surface_button_probe(struct p
 		goto err_free_button;
 	}
 
-	dev_info(&pdev->dev, "%s [%s]\n", acpi_device_name(device),
-		 acpi_device_bid(device));
+	dev_info(&pdev->dev, "%s [%s]\n", input->name, acpi_device_bid(device));
+
 	return 0;
 
  err_free_input:



