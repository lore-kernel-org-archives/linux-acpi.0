Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7863DB646;
	Wed, 18 Mar 2026 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844624; cv=none; b=pE/kjCDYuETbhyTXbp6MBkJMIRStk2y98fNylBmha1ALh+ECkoINK4fS8729ASvu5qOpa27TD5MsDOgPDiNHasCFCjelC9BvhEPa6AdC+xq9z8iEIsribyY+bOd5jSX8b+GwyXm5Qb00yaK5knmWltPx7EsshrWoMNzrs57bQUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844624; c=relaxed/simple;
	bh=+vKaDJRlLuIU1kZaVRGtIwdXcNYoZs9OQ8FUWKWq6HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icjHK62w+n+wwIXA9jBRFYSM5XV8zsPNukmBdePLH2knEHvNdJPd5dWHOxGmYcZHxJKLz5fJMs69BN6e/BXobUPD1ubmeFIJHTPXTx1RTnfoDiQkLq1gI59JIpd0z0rnlS+9jnlyUL2z+H4ePX16sqiD55lZtZPgXVW2Mcm3UYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhxzxqKz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhxzxqKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CEDC2BCB0;
	Wed, 18 Mar 2026 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844624;
	bh=+vKaDJRlLuIU1kZaVRGtIwdXcNYoZs9OQ8FUWKWq6HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhxzxqKz44Zp87ErYpjXsUCBzxSmJ45IffHeQZ1xbL/HwquClA2yN3AiM37RpCaO0
	 DgpYd3eT58NVgzKw+e9dlymUE49oUTMGlWUIqtGzInkBGnmof42cmGJYNh9bw/xGF1
	 GYhywc1WVyWAfMhZuxBdjiNtVcDJKHaM+ppczFRi4eqrGUKaFVOY+F7HLJAmkehtnq
	 0cW3xASjHgPiOjcI/rrdv5kYzggUJ+jdr7/gPyt6NcExNIFv9o26NOVRWyjMH9mkyn
	 tFmaPIwngC5nehLWUXxIZPWRbFlPBsVjsfSlm8Bmo5SeGl6o4BIUEJ8wdIknU0zLe/
	 EBJEMMqx4gs0Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject:
 [PATCH v2 1/2] platform/x86: dell/dell-rbtn: Register ACPI notify handler
 directly
Date: Wed, 18 Mar 2026 15:35:05 +0100
Message-ID: <9591832.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2033052.PYKUYFuaPT@rafael.j.wysocki>
References: <2033052.PYKUYFuaPT@rafael.j.wysocki>
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

v1 -> v2: Adjust the probe rollback path with a new label (Ilpo)

---
 drivers/platform/x86/dell/dell-rbtn.c | 50 ++++++++++++++++++---------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index a415c432d4c3..b9038d9ddcad 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -207,7 +207,7 @@ static void rbtn_input_event(struct rbtn_data *rbtn_data)
 
 static int rbtn_add(struct acpi_device *device);
 static void rbtn_remove(struct acpi_device *device);
-static void rbtn_notify(struct acpi_device *device, u32 event);
+static void rbtn_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id rbtn_ids[] = {
 	{ "DELRBTN", 0 },
@@ -293,7 +293,6 @@ static struct acpi_driver rbtn_driver = {
 	.ops = {
 		.add = rbtn_add,
 		.remove = rbtn_remove,
-		.notify = rbtn_notify,
 	},
 };
 
@@ -382,6 +381,22 @@ EXPORT_SYMBOL_GPL(dell_rbtn_notifier_unregister);
  * acpi driver functions
  */
 
+static void rbtn_cleanup(struct acpi_device *device)
+{
+	struct rbtn_data *rbtn_data = device->driver_data;
+
+	switch (rbtn_data->type) {
+	case RBTN_TOGGLE:
+		rbtn_input_exit(rbtn_data);
+		break;
+	case RBTN_SLIDER:
+		rbtn_rfkill_exit(device);
+		break;
+	default:
+		break;
+	}
+}
+
 static int rbtn_add(struct acpi_device *device)
 {
 	struct rbtn_data *rbtn_data;
@@ -422,31 +437,32 @@ static int rbtn_add(struct acpi_device *device)
 		break;
 	}
 	if (ret)
-		rbtn_acquire(device, false);
+		goto err;
+
+	ret = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					      rbtn_notify, device);
+	if (ret)
+		goto err_cleanup;
 
+	return 0;
+
+err_cleanup:
+	rbtn_cleanup(device);
+err:
+	rbtn_acquire(device, false);
 	return ret;
 }
 
 static void rbtn_remove(struct acpi_device *device)
 {
-	struct rbtn_data *rbtn_data = device->driver_data;
-
-	switch (rbtn_data->type) {
-	case RBTN_TOGGLE:
-		rbtn_input_exit(rbtn_data);
-		break;
-	case RBTN_SLIDER:
-		rbtn_rfkill_exit(device);
-		break;
-	default:
-		break;
-	}
-
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
+	rbtn_cleanup(device);
 	rbtn_acquire(device, false);
 }
 
-static void rbtn_notify(struct acpi_device *device, u32 event)
+static void rbtn_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct rbtn_data *rbtn_data = device->driver_data;
 
 	/*
-- 
2.51.0




