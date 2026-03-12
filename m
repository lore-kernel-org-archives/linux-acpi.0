Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A61636EA97;
	Thu, 12 Mar 2026 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325720; cv=none; b=S/JiDTlTFC91Eh0idGvAPov6mt1kIRs1OnomynpMsNhjWt+hUymL9CsfrMqzz4LvejOseZv5oGzgRiUui48Iv8PMW/Q/lswKvv7h5b+8Osv/huHloXjTSvOQ+5UrN9HEGT7wHwRDeNEkNRj70B5YtnIJe1/UwlvdjL2QGNTtdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325720; c=relaxed/simple;
	bh=uCAxAWu/ay+lrXI8P72H3rciRG2KzufS+W7jYSeFcyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vki9kvejWuLTtR1xjhufs7qlp5syf6puw9zZSAp35HHybXoh0B8d9byIGyTa/M7ftt3RNMhn/cM5TyzpBU1bd9PEH4HU0KyGYutKwC2z4c/RwZVvcgkwHfQDxtibx2a+hrVyyMXaFpNGY+Ib4DpNmAPSjwiC0Sq+wEPhCjW7THI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+BSlWSZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+BSlWSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4B5C19424;
	Thu, 12 Mar 2026 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773325720;
	bh=uCAxAWu/ay+lrXI8P72H3rciRG2KzufS+W7jYSeFcyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+BSlWSZeYZq8JZXF6taD3N8spUnv6GS246oW8Xi1zltd0bCINJYfiuQWRm/x9OJc
	 PhUPgOAg+cZ/ig/aXaYxI4ByMkTizsaVRDVp+hQaTyB0oedcIibl6oikXQE0IVFT2x
	 EX0QkjP/hTDWUXCR02zF+ZZAVQldJ8lb1wW5EFrztP4Zxvz8K3qOQ8gvCPDuhQSgKl
	 irKuIPRsYaaaMI7um+zZmM3G5Axh62+gBr9xhtYEcNCQgi5wUKZfjDUZiG+SU2OJDs
	 XfLAkHiTR8jKEHq4YGiTxh0b/yGxnvoSQINWaRcGGZaWpHJx0Pj2XlWY0vWmbUMOi6
	 K9kf/kH7YmAZA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Jeremy Soller <jeremy@system76.com>,
 System76 Product Development <productdev@system76.com>
Subject:
 [PATCH v1 1/2] platform/x86: system76: Register ACPI notify handler directly
Date: Thu, 12 Mar 2026 15:13:50 +0100
Message-ID: <6265962.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2841136.mvXUDI8C0e@rafael.j.wysocki>
References: <2841136.mvXUDI8C0e@rafael.j.wysocki>
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
 drivers/platform/x86/system76_acpi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index 3da753b3d00d..35e294a55fa3 100644
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -644,11 +644,10 @@ static void input_key(struct system76_data *data, unsigned int code)
 }
 
 // Handle ACPI notification
-static void system76_notify(struct acpi_device *acpi_dev, u32 event)
+static void system76_notify(acpi_handle handle, u32 event, void *context)
 {
-	struct system76_data *data;
+	struct system76_data *data = context;
 
-	data = acpi_driver_data(acpi_dev);
 	switch (event) {
 	case 0x80:
 		kb_led_hotkey_hardware(data);
@@ -777,6 +776,15 @@ static int system76_add(struct acpi_device *acpi_dev)
 		system76_battery_init();
 	}
 
+	err = acpi_dev_install_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY,
+					      system76_notify, data);
+	if (err) {
+		if (data->has_open_ec)
+			system76_battery_exit();
+
+		goto error;
+	}
+
 	return 0;
 
 error:
@@ -792,6 +800,8 @@ static void system76_remove(struct acpi_device *acpi_dev)
 {
 	struct system76_data *data;
 
+	acpi_dev_remove_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY, system76_notify);
+
 	data = acpi_driver_data(acpi_dev);
 
 	if (data->has_open_ec) {
@@ -813,7 +823,6 @@ static struct acpi_driver system76_driver = {
 	.ops = {
 		.add = system76_add,
 		.remove = system76_remove,
-		.notify = system76_notify,
 	},
 };
 module_acpi_driver(system76_driver);
-- 
2.51.0




