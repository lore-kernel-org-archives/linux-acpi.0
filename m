Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92FF41325B;
	Fri,  8 May 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262357; cv=none; b=nXXrvsT9AxX/sbXhEmyJ/oi0zOzZgt1XV5w1MpRK+FdQ+Kzq9XDp2WEeGiRTHdjSyihaGNORB87NjBMCFzShpn/mjGFz6EKhwWPReyf1dhWUlu2xMZ0uaSHdNefsRriTXGJ/dAaJ9bG/9OXi7PyczygYdoF49SNtFIkEBsP175c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262357; c=relaxed/simple;
	bh=vhSZJ/EhtYAqABvDlLMU7DhXENSIqSjgW+dsIQMkkAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQMWjYljjTGZOa199kPdCRXFYIKV+7L2kpBu79RLiSH06mXmfkK373+VP5FI8ejyiM4qETx8LscLr6UpPSqoPyFg3fuqYd0vlVpNKxMlLzGg66+TJrXkg3tiXVxpRxJGgl4M9zcTuQwTsxQfFyguw9et1jPDeT00HBo37MohG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaEglozC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaEglozC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB24C2BCC9;
	Fri,  8 May 2026 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262357;
	bh=vhSZJ/EhtYAqABvDlLMU7DhXENSIqSjgW+dsIQMkkAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaEglozCPA5At/T0Wa9Pnqn9SgRuNEgNPwVY/NSjubJLlWMeqwvOHSjy0ZXLvRxC2
	 MNIa34s0k09VmN2+LyVq1ATKk1jkwS8m1Dxv7Ogu90KMLd+7zs3dUgjMNARC4SFuiX
	 6CvgwrcI7Ph9oQqFXvaulHTGsowUANPyq3hDp+srK3ioaNTf2JE80LSKO8VcB9oBvf
	 XeNsaX8/C7JVcgdc0UfgYl4Ki5M2TAzKaK/kwxY7BpL+gdcepDmFHs4iHcuZiPhkml
	 CqxwQXBTK3b4dXto58ufakGLqxNPJbX78Ohstx/s2gaz+24muxZxPwoPYB+k5pQMUL
	 YZO0NN0MTBEHQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 1/4] platform/x86: xo15-ebook: Fix wakeup source and GPE handling
Date: Fri, 08 May 2026 19:40:31 +0200
Message-ID: <1966125.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2420444.ElGaqSPkdT@rafael.j.wysocki>
References: <2420444.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The device_set_wakeup_enable() call in ebook_switch_add() doesn't
actually do anything because power.can_wakeup is not set for ACPI
device objects.  Moreover, had it done anything, it would have
registered a wakeup source object that wouldn't have been used
going forward and that wakeup source would have been leaked after
driver removal because ebook_switch_remove() doesn't clean it up.
Accordingly, remove that call from ebook_switch_add().

Also prevent leaking an enabled ACPI GPE after removing the driver by
adding appropriate cleanup code to ebook_switch_remove().

Fixes: 89ca11771a4b ("OLPC XO-1.5 ebook switch driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/xo15-ebook.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 4d1b1b310cc5..1568169b7872 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -38,6 +38,7 @@ MODULE_DEVICE_TABLE(acpi, ebook_device_ids);
 struct ebook_switch {
 	struct input_dev *input;
 	char phys[32];			/* for input device */
+	bool gpe_enabled;
 };
 
 static int ebook_send_state(struct acpi_device *device)
@@ -128,7 +129,7 @@ static int ebook_switch_add(struct acpi_device *device)
 		/* Button's GPE is run-wake GPE */
 		acpi_enable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
-		device_set_wakeup_enable(&device->dev, true);
+		button->gpe_enabled = true;
 	}
 
 	return 0;
@@ -144,6 +145,10 @@ static void ebook_switch_remove(struct acpi_device *device)
 {
 	struct ebook_switch *button = acpi_driver_data(device);
 
+	if (button->gpe_enabled)
+		acpi_disable_gpe(device->wakeup.gpe_device,
+				 device->wakeup.gpe_number);
+
 	input_unregister_device(button->input);
 	kfree(button);
 }



