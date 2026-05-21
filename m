Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C213D9670;
	Thu, 21 May 2026 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372739; cv=none; b=chWXIOy0QmDkTuS0kx3HXVxLVUDcWw/AXeoslL0NXUsNSg1/v9ejSKt4+bqgXVP8F4xlN8wJ1VgtV0sHjh5sagrkRLirW9ECdcrhvCrO82Byp/nLhVpDFsemIJZ/GOTtoqyYf/z831fGwMqEtvKKvIOxQ4YzgQuLWDox4nVfjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372739; c=relaxed/simple;
	bh=O1MuVtO/NILhT7B5CBo+QM64Usfu4bLCvVLdJHmjsIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaOrWMeE/psDZox+PkU3qno1CRzOu1Xievs76UGlmyKUB7lZcZdy/c+auBjVXO1UiRDL1z1XszIrYYLWSgLzY7n3m3jQBO6H5ZWcMpUvpXYfXD0wZLzVOjL+H18iX512du7q3C7b2La2RzRSbArlA6jXsm/t5yIUHtqSMXjWZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMVD+xsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMVD+xsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5351F000E9;
	Thu, 21 May 2026 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372738;
	bh=i9FX8AVNv2nnVD4clqaKWwPN6fTufHpEG/8sEU8wzPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SMVD+xsL7z2aj3bLajdNvK5OOuy81RwLZpgkiGFCYFBSLMwgVOPI8mSW+Q6pCETci
	 N6qzRxWfIy8oXvF7AvEQ477zH5UCaVNA3M5yxZtqsNi/vSLPC+YrrckZaiQT9kuDwO
	 6VtZUXyY3OQZdl+V1vlXEUmvRrhZX0CtVSgMpVV1i0+WKZS6l3Y8vrMEmJQJNRoboE
	 siWgVHKV9gDmnTz9VdOeW3F/mbb0TmWkYXOl7HM44lKflMh6/NFG+CmS9cDaLj+VLF
	 wpF7aycp3hTTmYuZwS7ZZqfkSMOJYo5tjilxoWsVWLXjvmdYAWkvC3TjOcFCP9T0iw
	 MP9pldxP7Om9Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 10/17] ACPI: PAD: Fix teardown ordering in acpi_pad_remove()
Date: Thu, 21 May 2026 16:06:48 +0200
Message-ID: <2064153.usQuhbGJ8B@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4739447.LvFx2qVVIh@rafael.j.wysocki>
References: <4739447.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The ACPI notify handler installed by acpi_pad_probe() needs to be
removed before calling acpi_pad_idle_cpus() in acpi_pad_remove()
so it doesn't schedule idle time injection on some CPUs again.

Fixes: 8e0af5141ab9 ("ACPI: create Processor Aggregator Device driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index b0a6723fb854..48c00ee61ed2 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -430,12 +430,12 @@ static int acpi_pad_probe(struct platform_device *pdev)
 
 static void acpi_pad_remove(struct platform_device *pdev)
 {
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, acpi_pad_notify);
+
 	mutex_lock(&isolated_cpus_lock);
 	acpi_pad_idle_cpus(0);
 	mutex_unlock(&isolated_cpus_lock);
-
-	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
-				       ACPI_DEVICE_NOTIFY, acpi_pad_notify);
 }
 
 static const struct acpi_device_id pad_device_ids[] = {
-- 
2.51.0




