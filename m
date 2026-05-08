Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7540FDB4;
	Fri,  8 May 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262350; cv=none; b=LZ51nL/aIaZpjbv81X9cmz1hN0gTU/EnQqyHNeyTjgFSXITx1AOjoC9ZKvF1Vz6//8sq6vxra/WOvXQaYe9NvjiW+/6ps9fGO81hMy/llDUZxCOJ83/gSu5wVnu6yhyOkfc0ur9MSj8aCdX5Bx4+EM3l+2sGiJ16o9/W/Dq7vFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262350; c=relaxed/simple;
	bh=I77KWIULm/FCMr0k7INBqqPiz9/Mez6FhRQlbnlegWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQU0nlaSzlI24SAmf5p9zAmGOG5zsEVWNGaXtaJwpdfG8QoyENqHhBctkWne0iCkhQ2QA+YExu9t1W+GR20k9DyR/NsOkQGMwfs7RqyQGXlOdwRZ6w7+O//h+zD0fdyOh4IqnOzuhrFr7T/Uf4Aktz55yJ/UhOUaXbeJqZtT3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzBnMApC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzBnMApC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A21C2BCC7;
	Fri,  8 May 2026 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262350;
	bh=I77KWIULm/FCMr0k7INBqqPiz9/Mez6FhRQlbnlegWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YzBnMApC+T7CDrD6n7trOD9wR0oXSIyxM48hh7yp/M0IuOTFxuLRXf5CNU6DDLvrO
	 WP/6C0/eiwxIe/WUo8CvJLOXpKUU9U/H9VzdSv1DbATJPnXmD9XHvMVUoYebZTb9tP
	 zRQvBTsv+4aX/cMDy2vNfBYHC0plAZZk5CGJCrGfRIY+gU4vdXz8LQQfQevgEqA795
	 VVi1g/hUbA21BPuhQGwcFm6Vy+Ii3P+fr2W+/1GOfGUmFzFMh2n5Qm2LJQAGmanvEn
	 9G55qQDa08WupLmLkS4lOWYQzkQKKju7fn4mXmcWY3k2vmzKi11hK3e3X9bWOMCBHv
	 W52WT7qFSQaLA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 3/4] platform/x86: xo15-ebook: Register ACPI notify handler
 directly
Date: Fri, 08 May 2026 19:43:13 +0200
Message-ID: <3420768.aeNJFYEL58@rafael.j.wysocki>
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

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/xo15-ebook.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 616f4bb3461a..8af1b9078db8 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -57,16 +57,15 @@ static int ebook_send_state(struct acpi_device *device)
 	return 0;
 }
 
-static void ebook_switch_notify(struct acpi_device *device, u32 event)
+static void ebook_switch_notify(acpi_handle handle, u32 event, void *data)
 {
 	switch (event) {
 	case ACPI_FIXED_HARDWARE_EVENT:
 	case XO15_EBOOK_NOTIFY_STATUS:
-		ebook_send_state(device);
+		ebook_send_state(data);
 		break;
 	default:
-		acpi_handle_debug(device->handle,
-				  "Unsupported event [0x%x]\n", event);
+		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
 		break;
 	}
 }
@@ -123,6 +122,11 @@ static int ebook_switch_add(struct acpi_device *device)
 	if (error)
 		goto err_free_input;
 
+	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+						ebook_switch_notify, device);
+	if (error)
+		goto err_unregister_input;
+
 	ebook_send_state(device);
 
 	if (device->wakeup.flags.valid) {
@@ -139,6 +143,10 @@ static int ebook_switch_add(struct acpi_device *device)
 err_free_button:
 	kfree(button);
 	return error;
+
+err_unregister_input:
+	input_unregister_device(input);
+	goto err_free_button;
 }
 
 static void ebook_switch_remove(struct acpi_device *device)
@@ -149,6 +157,8 @@ static void ebook_switch_remove(struct acpi_device *device)
 		acpi_disable_gpe(device->wakeup.gpe_device,
 				 device->wakeup.gpe_number);
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       ebook_switch_notify);
 	input_unregister_device(button->input);
 	kfree(button);
 }
@@ -160,7 +170,6 @@ static struct acpi_driver xo15_ebook_driver = {
 	.ops = {
 		.add = ebook_switch_add,
 		.remove = ebook_switch_remove,
-		.notify = ebook_switch_notify,
 	},
 	.drv.pm = &ebook_switch_pm,
 };



