Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5823D904B;
	Wed, 18 Mar 2026 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842246; cv=none; b=rD9blKLAuRKn7BJalp5kY9SINVbeTD4fFYm0qnRI82APcggu1fBH9CCm1VleSWmGUC3c3QdCWQr0Pc2EwEC6ODHcq3K7/Ohiv98rRwgVbbs5Ed9ixsYZdASrUdLxpraYpypu78kBhUR2QAVl1gzNOMIkUU+Qkxj2uGgutPJEP40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842246; c=relaxed/simple;
	bh=n4A4A2Ew0Z3qzA5bt63+Ay+uzr7I1efb1TLldC5IM4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzT+1JJw9QDbY04p9rZhNhpfc0/8K2hJt7McLIgXrJZHgFo8SNy2FUrJwhgiUmVgqYE0cCJVQW1QB9yvNK/efxe4+YDJMmU7fStowAOtUCxvdVQYC2vSPOBJHyk4MexNlLXiNP8ELXOqsHZVqhpn7I+bsa47a7wlsTEiCY9ZcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNGQucLr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNGQucLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B60AC19424;
	Wed, 18 Mar 2026 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773842245;
	bh=n4A4A2Ew0Z3qzA5bt63+Ay+uzr7I1efb1TLldC5IM4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNGQucLrQRBryDRDXKmTn2IFNvtzHjdceUjmBAQtUUMfVL2LKvDBxiWQlSHsYoEUQ
	 JzSdSNyXB7dT63OdM6iMdqNIZhy5K+rZLYo2J0rkDrTNeNEkFaEc+2lQlVL7mM8QJw
	 KiST2J8ofBQXqJVlKoh1jCnEaFAkG5XliFtH8G5d9SeHALqZzJNa2LxxTD83oxy1BL
	 tFnFJyAKEjEZWs5N6daUQGZM24/yAidO84UG0QFlxFFIeH8YQyjO8ob47IwlgTpJQT
	 3rk5UQFJpApq73LpDhjR1eUFEOflnyLPNoTO+p+LO2n8FPoRb62Rg8tumnUxognd6c
	 Ky8jCHMSGk+ng==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Jeremy Soller <jeremy@system76.com>,
 System76 Product Development <productdev@system76.com>
Subject:
 [PATCH v2 2/3] platform/x86: system76: Register ACPI notify handler directly
Date: Wed, 18 Mar 2026 14:53:37 +0100
Message-ID: <13970743.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4721148.LvFx2qVVIh@rafael.j.wysocki>
References: <4721148.LvFx2qVVIh@rafael.j.wysocki>
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

v1 -> v2:
   * Rebase on top of [1/3]
   * Use the observation that the notify handler does not access memory
     allocated when data->has_open_ec is set and so it can be registered
     earlier, which allows the probe rollback path to be simplified

---
 drivers/platform/x86/system76_acpi.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index d8b64e2c2713..fc11427c36a5 100644
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
@@ -757,7 +756,12 @@ static int system76_add(struct acpi_device *acpi_dev)
 
 	err = input_register_device(data->input);
 	if (err)
-		goto error;
+		return err;
+
+	err = acpi_dev_install_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY,
+					      system76_notify, data);
+	if (err)
+		return err;
 
 	if (data->has_open_ec) {
 		err = system76_get_object(data, "NFAN", &data->nfan);
@@ -784,6 +788,7 @@ static int system76_add(struct acpi_device *acpi_dev)
 		kfree(data->ntmp);
 		kfree(data->nfan);
 	}
+	acpi_dev_remove_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY, system76_notify);
 	return err;
 }
 
@@ -800,6 +805,8 @@ static void system76_remove(struct acpi_device *acpi_dev)
 		kfree(data->ntmp);
 	}
 
+	acpi_dev_remove_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY, system76_notify);
+
 	system76_get(data, "FINI");
 }
 
@@ -810,7 +817,6 @@ static struct acpi_driver system76_driver = {
 	.ops = {
 		.add = system76_add,
 		.remove = system76_remove,
-		.notify = system76_notify,
 	},
 };
 module_acpi_driver(system76_driver);
-- 
2.51.0




