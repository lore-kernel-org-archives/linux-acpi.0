Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0B3F8712;
	Thu, 21 May 2026 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370869; cv=none; b=C8h4uoM481i9Psd5PEzAtAsHdik21/CD6MWzAjlMlegBiU6x7wJp4re1n6SdnFD4Pp1OSRPhQDPQ9PZaNX0m1WoIOJvr9ufFuuMe3UdpI+32PAT5GvZuibeSIQe2NHzdusTiqeuaEE8gDFAFRP6I5zbuM0bIjA+ipz7uE2F5AdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370869; c=relaxed/simple;
	bh=FqFucRlB5ZD18wwfW/0DBLnHQ2gN1BOcktPaSG/ENi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXeT0dmRS08qAWf6yvnedMg9XXaWE7PiWBIGWW/dZrY9EPeUVP99mm5D4CDz8FSXYioiueSnHuVk/xq6F2rDgXJheRjjp8jOqHa3UHwkTOHbrdDMntJHxYiOS+7aEdUdBMlh8n6Y/tJJrSogjirCxfn2OGGVI+Fz5TK4yZoTAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAKCfvFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAKCfvFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E2A1F00A3B;
	Thu, 21 May 2026 13:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370867;
	bh=w6WGD7xhT+k5frytLhgawMfuuOsuPbnAfGZ8jfta+5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eAKCfvFxc7q4CBGi9S2htQjL484HLsR2s+xL+0mlIpMkdBUyiUcJXcZx2yi3Kficq
	 MfYVuvvMi4Y8uAUbvDtj/4c04fnfXIoa9VL/UuW4R/Nji15EWfdZMvTNj2Pdj2e0KB
	 w/R+NtiMHQI3o7eV1b6grTtqqkpDDAtrZWeHMvHmkRNgPaqYrmjuW0kZrSCQBM/5wV
	 YGQW2ZuZOAGbcVmevQ4mHUA6hgUblMa3R1+yzdnpji3C2CcZhie20vz5WNtLrJA2tO
	 xT/MEq2yBdAW0e0H8E6FHtBK1iZeVSptKO2rZBS252gnha6dUTt7hSOcwu7mzimY8t
	 2Oe6oKJUlMWqg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick <nick@kousu.ca>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v1 1/3] ACPI: button: Fix ACPI GPE handler leak during removal
Date: Thu, 21 May 2026 15:32:00 +0200
Message-ID: <5103522.31r3eYUQgx@rafael.j.wysocki>
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

Commit a7e23ec17fee ("ACPI: button: Install notifier for system events
as well") changed the ACPI notify handler type for ACPI buttons to
ACPI_ALL_NOTIFY, but it forgot to update acpi_button_remove() to reflect
that change.  This leads to leaking the notify handler past driver
removal, which may cause a kernel crash to occur if ACPI notify on
the given device is triggered after removing the driver, and causes a
subsequent probe of the given device with the same driver to fail.

Address this by updating the acpi_remove_notify_handler() call in
acpi_button_remove() as appropriate.

Fixes: a7e23ec17fee ("ACPI: button: Install notifier for system events as well")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 6.15+ <stable@vger.kernel.org> # 6.15+
---
 drivers/acpi/button.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -689,7 +689,7 @@ static void acpi_button_remove(struct pl
 						acpi_button_event);
 		break;
 	default:
-		acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   button->type == ACPI_BUTTON_TYPE_LID ?
 						acpi_lid_notify :
 						acpi_button_notify);



