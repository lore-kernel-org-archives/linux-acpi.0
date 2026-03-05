Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3352287257;
	Thu,  5 Mar 2026 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740092; cv=none; b=m6MXoB+yCT4zA7E4BCKrcjRC8yv390vEt1zAd3HZbLltxLdLekTAre9WtKGj3+EwXhuy3p+GF0Ve3G0Bht7F6l4FKatpad0ZP5+Jtv4hY6nBNoKCPglNZ/rT8f1l+P7fvYJALLgxsCN173zZOChPYf4FGAmT+dZkFWncciWrZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740092; c=relaxed/simple;
	bh=yawNC3/TxNcH+OB5pG83WCAh7HJ5dwYdwe7kKNkMnHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WI0iTi+z38hBGYVgMoknC5p2CUGUZZzD75GdYR7F31T3oc4mXI3SZIgkOuql42D1XMKaX45DLWfnV8295N4vwUS3Il6sW4/1FKX/YEHOT89OxhasdsIPXcEWgqOZX7fj/NedTABmaRVCYI0t5Slk/7UrU/9bylmtSm4Cow4bJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2gQWeK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2gQWeK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476A6C116C6;
	Thu,  5 Mar 2026 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772740091;
	bh=yawNC3/TxNcH+OB5pG83WCAh7HJ5dwYdwe7kKNkMnHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2gQWeK/YxvQLY+ypXqzCLQO8gAzDmT72p4teuVRmGyw3RWriocml+AS3/s62v3ht
	 ols8cNDUkf9By9fBf0sV5LHMJ8BKIBY4kBTgWMUvLy9XiLfKyJRd6DUs2/Hp3+J5/A
	 bzEuapQkhy+z068TgJ4VoOkcQfs2+xpBrKI+OSSPQ0AtTV9DXnqXXq32edIWhOq+sV
	 +HZu2qns05di6nKmRp5xt/0L8HgbdOMEKrHFMaXGze0QWTPIghIgPZaihBhEnIVfKF
	 4WI4FbP50MnyzvyDeAXXidag+PAMqsbNcLrl/Oyq8R8TkO9hru8tVgX88OmaWe0gOz
	 wXWS9sX2u+tTg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v2 5/6] platform/chrome: wilco_ec: event: Register ACPI notify handler
Date: Thu, 05 Mar 2026 20:43:59 +0100
Message-ID: <7931926.EvYhyI6sBW@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
References: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
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

v1 -> v2: No changes

---
 drivers/platform/chrome/wilco_ec/event.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 743cd4839bff..f4500dd05f93 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -253,14 +253,16 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
 
 /**
  * event_device_notify() - Callback when EC generates an event over ACPI.
- * @adev: The device that the event is coming from.
+ * @handle: ACPI handle of the device that the event is coming from.
  * @value: Value passed to Notify() in ACPI.
+ * @data: Notify handler data.
  *
  * This function will read the events from the device and enqueue them.
  */
-static void event_device_notify(struct acpi_device *adev, u32 value)
+static void event_device_notify(acpi_handle handle, u32 value, void *data)
 {
 	struct acpi_buffer event_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = data;
 	union acpi_object *obj;
 	acpi_status status;
 
@@ -489,8 +491,16 @@ static int event_device_add(struct acpi_device *adev)
 	if (error)
 		goto free_dev_data;
 
+	/* Install an ACPI notify handler. */
+	error = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+						event_device_notify, adev);
+	if (error)
+		goto free_cdev;
+
 	return 0;
 
+free_cdev:
+	cdev_device_del(&dev_data->cdev, &dev_data->dev);
 free_dev_data:
 	hangup_device(dev_data);
 free_minor:
@@ -502,6 +512,8 @@ static void event_device_remove(struct acpi_device *adev)
 {
 	struct event_device_data *dev_data = adev->driver_data;
 
+	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+				       event_device_notify);
 	cdev_device_del(&dev_data->cdev, &dev_data->dev);
 	ida_free(&event_ida, MINOR(dev_data->dev.devt));
 	hangup_device(dev_data);
@@ -519,7 +531,6 @@ static struct acpi_driver event_driver = {
 	.ids = event_acpi_ids,
 	.ops = {
 		.add = event_device_add,
-		.notify = event_device_notify,
 		.remove = event_device_remove,
 	},
 };
-- 
2.51.0




