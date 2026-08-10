Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C43C1966;
	Mon, 10 Aug 2026 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362034; cv=none; b=OFFNwReklVywQZOvqFMcyEbJ8rs/qJGk5QCjVR3QnS17jaNrn7zqHYNifQP9Mno+WCitxhrnbQ9WD8JpO2yeuyvTO7lQfaQnI2MwLuQEX8ebURUbqHV4IBEh+i8eoGcuvWD5RkhWXjCMN/3T1acORiZvryId15ajYEyc9pMa2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362034; c=relaxed/simple;
	bh=Rvpy7KJlt2o2Tshj3r/yKbPrYMflM9zuWmxn/55AOhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QO4FV7Dm9y+kD2LIYg4NhZrFjlKWwuJA2MI0r3vnr8zzf7vuO+lIhxPeZAV4tWMLhDNNajQ3SJT0vw0OVHqHEi8E/F9t3/c7DT58GF+5BOO2cKmvpzz/iRYlX94csRvFj2VQpYSa6+AuLcCeW/H8vkfwx8nYs2R0aS3Dr0RwtaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aREIzZ60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aREIzZ60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43A71F000E9;
	Mon, 10 Aug 2026 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786362032;
	bh=O22CSa8G+2dNgkBniiNvjg//euMKmYXzub5vCNybg/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aREIzZ60WbzW4/k6RrJ3OSzN8u1OX5MleELiqgAKWqUy4AG3FSA9D6pWAXFo3RitH
	 UL1ffNiJ3/1c3ubJ6Fy3lP5C31lj9bpJ3oH7j1Q3Ls7s66SNAuje0iYBx0t2a9kWNl
	 uAicyOkw+cSQkD7iRF93uIhwKsYp9ydaXrfu7vIy1HFSJRDRxn+4lunDho2C5wfRMR
	 WjrEDoZTfCBritQGMwippFWEQCKti42kXgL5Qfdacg2ixDWmF2x4CPAXdEIIgK0YWd
	 xBNXLkHKMH55YetOL54dNz9ZCcVdRz02FbyTt2EaooesY4bFToJv+6KazyyV8x4uYk
	 yyyiJ6PMWy4Sg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 3/3] ACPI: scan: Use acpi_bus_get_primary_device()
Date: Mon, 10 Aug 2026 13:40:18 +0200
Message-ID: <10906414.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <4764923.LvFx2qVVIh@rafael.j.wysocki>
References: <4764923.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The acpi_get_first_physical_node() usage in acpi_create_video_bus_device()
is generally unsafe because in theory the device returned by it may be
freed at any time.

Address this issues by using acpi_bus_get_primary_device() instead of
acpi_get_first_physical_node() and dropping the device reference
acquired by it after registering the child.

Fixes: 6ab3532b4c98 ("ACPI: video: Switch over to auxiliary bus type")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2203,29 +2203,27 @@ static void acpi_create_video_bus_device
 	struct auxiliary_device *aux_dev;
 	static unsigned int aux_dev_id;
 
+	struct device *phys_parent __free(put_device) = acpi_bus_get_primary_device(parent);
+	if (!phys_parent)
+		return;
+
 	aux_dev = kzalloc_obj(*aux_dev);
 	if (!aux_dev)
 		return;
 
 	aux_dev->id = aux_dev_id++;
 	aux_dev->name = "video_bus";
-	aux_dev->dev.parent = acpi_get_first_physical_node(parent);
-	if (!aux_dev->dev.parent)
-		goto err;
-
+	aux_dev->dev.parent = phys_parent;
 	aux_dev->dev.release = acpi_video_bus_device_release;
 
-	if (auxiliary_device_init(aux_dev))
-		goto err;
+	if (auxiliary_device_init(aux_dev)) {
+		kfree(aux_dev);
+		return;
+	}
 
 	ACPI_COMPANION_SET(&aux_dev->dev, adev);
 	if (__auxiliary_device_add(aux_dev, "acpi"))
 		auxiliary_device_uninit(aux_dev);
-
-	return;
-
-err:
-	kfree(aux_dev);
 }
 
 struct acpi_scan_system_dev {



