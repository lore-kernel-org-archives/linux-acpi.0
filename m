Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DAC3F6610;
	Thu, 21 May 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370862; cv=none; b=FxOgZSNlHZYje76PUdYmF1uBXhPPyd6kKP0n9aEmcGYC3fNwEw9uIFMJUG/l8AQ9gKmEIaIlvR/kcABCGDOpxGo1AiVjw4eyj4hG4kw7qLidn7j0qnWM9+X8flnZ/fun/GrFkQXjsXOQjYf16L4YyP/P3UBPaF/BJINokUnLoeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370862; c=relaxed/simple;
	bh=PCl2fb/DRa6PAZ03mBzvez9u4IZ5EQkCN+1LM73kYSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAzi8gGcb9vMJ9rRPLr7ExEnVkBDOUCeP21WSbjefLe0kwBSttCyYcGcstbaGsyRw9o0nDt1DR7rx4EyVqx+XUqW0+SA/QW1yiKneJFFWMVyFxVt7K27yxMKTIw7qXHOSdb5M6A9Wkd+0oaKjjrVw6FsNkH67Mu/uFOuU24D24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2Vu6QJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2Vu6QJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B8E1F000E9;
	Thu, 21 May 2026 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370860;
	bh=APTM5Oq5TPuoufgtRvOsr0UsXQMG1w/zXbxUeV9g474=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o2Vu6QJ0Yv9/7p644uINlXv39FVLvtjiAdc87c7dCBnedc5RzPSaxj2uvTeffagEB
	 aREghztSrVY7hic52FI49HHNRalEmS2n6ltlr3c+o8mw9k0IpwHB8UkZ7jybNN2umr
	 foNzZ1uSgD/eIYPX3f0FwLE45Jf7lB88t4FVxNoGRdoecSAmhVWfnrjDGvUL4WXNT1
	 KlddNWcNfZWTxd/zgVitrff2LsUCx4I1Vv5q5uTPuTm1KtaabpTvrWdRNEQYg0MMHB
	 Vk/Nc0s5vfDdyYt9GAiBAmzjRMKM1tHlTFCcIa3P6DTmoDr1AWcUMJYa/uh5nr+hJK
	 Nlvdls8LW0mrQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick <nick@kousu.ca>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v1 3/3] ACPI: button: Add missing device class clearing on probe
 failures
Date: Thu, 21 May 2026 15:39:29 +0200
Message-ID: <3046699.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5996185.DvuYhMxLoT@rafael.j.wysocki>
References: <5996185.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit e18947038bf4 ("ACPI: driver: Do not set acpi_device_class()
unnecessarily") modified acpi_button_remove() to clear the device class
field in struct acpi_device on driver removal, but it should also have
updated the rollback path in acpi_button_probe(), which it didn't do,
so do it now.

Fixes: e18947038bf4 ("ACPI: driver: Do not set acpi_device_class() unnecessarily")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -687,6 +687,7 @@ err_remove_fs:
 	acpi_button_remove_fs(button);
 err_free_button:
 	kfree(button);
+	memset(acpi_device_class(device), 0, sizeof(acpi_device_class));
 	return error;
 }
 



