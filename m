Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E5230270;
	Fri, 13 Mar 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407076; cv=none; b=Nu3pqG5JX5HZRvj/iLZFwyF5kYTvgfZ5aiDjanRN/HcNT1QNw5kJFn9RznO2WO25930UrErQQ7t19BxIchPtitKP9hGZwd88CTYvA4IXQvGDfJM43NuIkFC7gc85ZIgD5f8tWqhN0B/2yWlfNm5HtKPFXxP/Jgjv/WBcNaj/akQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407076; c=relaxed/simple;
	bh=tolF/JM2b0dllU7yzwcKdXka0D22HWa21wnEPnBPfDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BY5ynvwAouvmk40xRemHHlvxGPbC7n7Q73CvvRNeZd/IUEdKwNVf6FUQxJlXnDiN0IkyYCFJsTxetnRxMLFqQcL9mWrozJIAFV2b0JeFdYUpqr7pRIIPflFIe0b8m0Sp1OYQAYXKnzE7fjT9kWv2QonIdzAy/G2JDyAhwoUDZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF0uJ8Ce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF0uJ8Ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729DFC19421;
	Fri, 13 Mar 2026 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407075;
	bh=tolF/JM2b0dllU7yzwcKdXka0D22HWa21wnEPnBPfDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uF0uJ8CeQLYvaIUM5RdW3NyhtvjyTByDegx/PfUQm4CXN1Tk1RI946kSDksMQcX61
	 DhS/8OSJa51f69dfFVveSayfV1B+hiGGzvmXT0m/A+YveV29SzNYeRDUnjR2b/qdZN
	 PBzBCTp94JkWshCJnRXB7TffoAt3PjbJoaTBRUs+MzwBl52NTgigYPNG2HQhHQe63b
	 EhYR9v6fw4fRBtocf35sozK09VeK+63pmZ3prLL8oRsKYVLCk9Dry7owT+fKNtTUvh
	 zmKOaIuEj6yFjDA7aI34KEuQ6yxUFZzzbt1mykxJFsmDrh+YoFBQP7hwOapLGnkDR/
	 uQaKRUty9bSiw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject:
 [PATCH v2 2/8] ACPI: video: Rework checking for duplicate video bus devices
Date: Fri, 13 Mar 2026 13:56:19 +0100
Message-ID: <3058492.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
References: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current way of checking for duplicate video bus devices in
acpi_video_bus_probe() is based on walking the ACPI namespace which is
not necessary after recent driver conversions.  It is also susceptible
to race conditions (for example, if two video bus devices are probed at
the same time) and ordering issues.

Instead of doing it the old way, inspect the children of the parent of
the device being probed, excluding the latter and the children that are
not auxiliary devices.  For each of the remaining children, check if any
of the entries in the video_bus_head list is equal to its driver data
which can only happen if the given child has been processed by
acpi_video_bus_probe() successfully and so it is a duplicate of the
one being probed.

Moreover, to prevent acpi_video_bus_probe() from processing two devices
concurrently, which might defeat the above check, use a new internal
mutex in it.

Also, print the FW_BUG message only if allow_duplicates is unset which
allows the entire duplicates check to be skipped in that case (doing
it just to print the message about the case that is going to be
ignored anyway is kind of pointless).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c |   56 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1681,26 +1681,6 @@ static int acpi_video_resume(struct noti
 	return NOTIFY_DONE;
 }
 
-static acpi_status
-acpi_video_bus_match(acpi_handle handle, u32 level, void *context,
-			void **return_value)
-{
-	struct acpi_device *device = context;
-	struct acpi_device *sibling;
-
-	if (handle == device->handle)
-		return AE_CTRL_TERMINATE;
-
-	sibling = acpi_fetch_acpi_dev(handle);
-	if (!sibling)
-		return AE_OK;
-
-	if (!strcmp(acpi_device_name(sibling), ACPI_VIDEO_BUS_NAME))
-			return AE_ALREADY_EXISTS;
-
-	return AE_OK;
-}
-
 static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 {
 	struct backlight_properties props;
@@ -1976,29 +1956,49 @@ static int acpi_video_bus_put_devices(st
 	return 0;
 }
 
+static int duplicate_dev_check(struct device *sibling, void *data)
+{
+	struct acpi_video_bus *video;
+
+	if (sibling == data || !dev_is_auxiliary(sibling))
+		return 0;
+
+	guard(mutex)(&video_list_lock);
+
+	list_for_each_entry(video, &video_bus_head, entry) {
+		if (video == dev_get_drvdata(sibling))
+			return -EEXIST;
+	}
+
+	return 0;
+}
+
+static bool acpi_video_bus_dev_is_duplicate(struct device *dev)
+{
+	return device_for_each_child(dev->parent, dev, duplicate_dev_check);
+}
+
 static int instance;
 
 static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 				const struct auxiliary_device_id *id_unused)
 {
 	struct acpi_device *device = ACPI_COMPANION(&aux_dev->dev);
+	static DEFINE_MUTEX(probe_lock);
 	struct acpi_video_bus *video;
 	bool auto_detect;
 	int error;
-	acpi_status status;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
-				acpi_dev_parent(device)->handle, 1,
-				acpi_video_bus_match, NULL,
-				device, NULL);
-	if (status == AE_ALREADY_EXISTS) {
+	/* Probe one video bus device at a time in case there are duplicates. */
+	guard(mutex)(&probe_lock);
+
+	if (!allow_duplicates && acpi_video_bus_dev_is_duplicate(&aux_dev->dev)) {
 		pr_info(FW_BUG
 			"Duplicate ACPI video bus devices for the"
 			" same VGA controller, please try module "
 			"parameter \"video.allow_duplicates=1\""
 			"if the current driver doesn't work.\n");
-		if (!allow_duplicates)
-			return -ENODEV;
+		return -ENODEV;
 	}
 
 	video = kzalloc_obj(struct acpi_video_bus);



