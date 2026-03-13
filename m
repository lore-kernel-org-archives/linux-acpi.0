Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764A239E6F;
	Fri, 13 Mar 2026 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407072; cv=none; b=SUjyXJJaGDa2izg70QD2rR6ns8wHKWpoElBt6paPjCJGIz8ZgzY4ZHyn9IwWJyslPp3NA9V0N60jZlgwVxvSBqjzj4adXw78LjwakUaqm+E8yXG5CZy8BMyeWuM7Vt+r6DIqDLNJhUuDlYYHv8Tkq2ZljJ3/1CNxa4KGZn9QZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407072; c=relaxed/simple;
	bh=43c8HNBmwpGqNdIC88rxx1cr+GmdGnfkSio8R3uRNqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUHAC71A84iHhcuLqY+vhI5wQ0ZQTpQ2JcjJ77RWYATYb277lBLYXw4BKaWksx3CI97LlSuk3BAgZoO0wlXs3RqmxnhtZbj/+8yFHvTTk15yrq1BoUTicoqax0sMQvKDa1P2KeBVplzq3fzWOPLW6BpEeoTCuDqSZmWI8QO3TaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rkz9zd/e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rkz9zd/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AC5C19421;
	Fri, 13 Mar 2026 13:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407072;
	bh=43c8HNBmwpGqNdIC88rxx1cr+GmdGnfkSio8R3uRNqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rkz9zd/eMavBUokL4g1rjhImwOOaFcA1dr4/apmJjCNeP4Y5i1ehDwnRbpeIVJeYP
	 8Dyf0n8t2IKpyKN/OXfBboT44byioGMB/erRHAap35sYpyCEheEXKXyMvC3sJnHpVX
	 9yAvjdxnqNKbmdFgnUlhazKzAkFf46ksRlJf9rHXqwtg/TLespn/Z7uis1IHTnUYBL
	 HqbUvGi+ia0UYWklRLSK1i8TNF88iwKw8nHxG4UxV9H+yeMQ0i4Bn1LfiueM4Jbkme
	 GwPPIU0AW8D/tOA5nGIHmpRNNi4qJ3PZZCF4MrDKksbakw2kIQXWmgxjX15821/rtD
	 Mb2ZFvQ2WeugQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v2 3/8] ACPI: video: Consolidate pnp.bus_id workarounds handling
Date: Fri, 13 Mar 2026 13:57:43 +0100
Message-ID: <3430879.44csPzL39Z@rafael.j.wysocki>
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

Reduce code duplication related to pnp.bus_id workarounds by combining
the two existing cases.

Also move the definition of static variable "instance" into
acpi_video_bus_probe() because it is only used there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1978,14 +1978,13 @@ static bool acpi_video_bus_dev_is_duplic
 	return device_for_each_child(dev->parent, dev, duplicate_dev_check);
 }
 
-static int instance;
-
 static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 				const struct auxiliary_device_id *id_unused)
 {
 	struct acpi_device *device = ACPI_COMPANION(&aux_dev->dev);
 	static DEFINE_MUTEX(probe_lock);
 	struct acpi_video_bus *video;
+	static int instance;
 	bool auto_detect;
 	int error;
 
@@ -2005,16 +2004,15 @@ static int acpi_video_bus_probe(struct a
 	if (!video)
 		return -ENOMEM;
 
-	/* a hack to fix the duplicate name "VID" problem on T61 */
-	if (!strcmp(device->pnp.bus_id, "VID")) {
-		if (instance)
-			device->pnp.bus_id[3] = '0' + instance;
-		instance++;
-	}
-	/* a hack to fix the duplicate name "VGA" problem on Pa 3553 */
-	if (!strcmp(device->pnp.bus_id, "VGA")) {
+	/*
+	 * A hack to fix the duplicate name "VID" problem on T61 and the
+	 * duplicate name "VGA" problem on Pa 3553.
+	 */
+	if (!strcmp(device->pnp.bus_id, "VID") ||
+	    !strcmp(device->pnp.bus_id, "VGA")) {
 		if (instance)
 			device->pnp.bus_id[3] = '0' + instance;
+
 		instance++;
 	}
 



