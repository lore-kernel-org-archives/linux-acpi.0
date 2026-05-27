Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06284657E7;
	Wed, 27 May 2026 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905518; cv=none; b=dE+3lRBxxZo1g/29gf3FBHeBg+T+lO5Y36NFR3yUMk36D5I4CO08DBRoFmIXP+DrGggN4r8bbm1ytrmfxw43fd2JUg0AbIpaja7dh8hP8ee3J4tIcgixLK6ej8eLeU2puJU7LfhHqgWxH02lc3QeYDSBKkt5+13onvAphmB3pXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905518; c=relaxed/simple;
	bh=Gxaq3dPYsheIVc0veuFX/D4F7ziNO5feXD2AY4/HV60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKKNOTzmBwjXvPLNiGKofcbBU/jX5LeGBrpOEQkBatEDy48cAYqKSK6lmhtO3GvWkI0EcWuHLnRZf4+kSTnXOgQUawRbnFO7WmfWjkKscQBWywMJQnxXtjIg8ftV2U4hkqzVhyxC/yNo95NOOP16HW1TbLu0WhNN29Zw/vHh/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8/NRL4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8/NRL4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6330B1F000E9;
	Wed, 27 May 2026 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905516;
	bh=EWFHzIUlWCGkheSUu5EPTmcOnxKvK5k+a5JX1gZk1kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U8/NRL4pOJtAEfWxdtYA28sn8HMnUB3GzxlYAm0sb/HaIHs8xNGohZWb8sIQ7gy5C
	 AwInKpqB9O1wn7AOEVk1OKIGly++QCy8zC9F96UbNDrK8CY6nYAbTObNR6s+xV22gl
	 3Bzgk6KxiXZ1yO0w35pNtWpH/nNOq0sxHNd40gxGee8H4V3okNUIxwrzDdc5Cz2/SJ
	 +5+TzY5YDL94CiH4c8c3l4gXNfZIDZIsk4MgsRkQSp4m1KskB+vRlC/EbEhBfAxZ9f
	 yb9+hueRm8LgK/k9wjxj1xaAsm2twq+rzIwTHfyorbrl+wjfmkyHge/6LBgHzYRk5q
	 lFXXOCJufetPA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 19/27] ACPICA: Add validation for node in
 acpi_ns_build_normalized_path()
Date: Wed, 27 May 2026 20:04:06 +0200
Message-ID: <118666237.nniJfEyVGO@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: ikaros <void0red@gmail.com>

Add validation for node in acpi_ns_build_normalized_path()
to prevent use-after-free vulnerabilities.

Link: https://github.com/acpica/acpica/commit/b35adf49e89a
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/nsnames.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 22aeeeb56cff..19802da865c5 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -222,6 +222,12 @@ acpi_ns_build_normalized_path(struct acpi_namespace_node *node,
 		goto build_trailing_null;
 	}
 
+	/* Validate the Node to avoid use-after-free vulnerabilities */
+
+	if (ACPI_GET_DESCRIPTOR_TYPE(node) != ACPI_DESC_TYPE_NAMED) {
+		goto build_trailing_null;
+	}
+
 	next_node = node;
 	while (next_node && next_node != acpi_gbl_root_node) {
 		if (next_node != node) {
-- 
2.51.0




