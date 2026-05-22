Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E504611CE;
	Fri, 22 May 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461662; cv=none; b=caOxIvfEtu18L2y0rQTgMhzAF8QIBGiQlPo+u4khUWP2O5UtwmgB19li6KQ/Hq9jTTVTuKh2gCiltnqKsRMZ531m0EvOIFuqsYuHA4y7VsuzlhcWUElO5LikyLeklvCBt55wlBAWEKTbGdIIN4fMckUalh3+lcKV/ZcPSYWubpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461662; c=relaxed/simple;
	bh=DP//LBw9o/tiKAkr+ZbRvs2/trbRce9jKBNLdiU/9D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDQFUm5u/8DZGCpYDv1dJHKqg1d2IK27JVaE5V2HaP/ebK2Uwjd+UYlg8XssXDZ+lzsOqn18hFjyrG9m/CHldpLfSxL2Yf/N4xqZo0xSBxbtJXg7wMnFDPas0HaGKCez/ZdZbFkGOQnuBCNBOYFvQ4QjLI47Xu2N+dBlBgHpyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5RRSMa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5RRSMa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481831F000E9;
	Fri, 22 May 2026 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779461660;
	bh=L1tK+p9/Nsk761ONmhmoHNVLgj4BxG7lfdxEjHtcOBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y5RRSMa143H3gr/im4qjJyC+rcBNddn97HO7ETF5eIyRtK/PHNFAgB4gfypdA7bHE
	 9A38IMFTa04lfcdhXRSpCOta6+DYQBMZDjLzhNlyJDYoOETgzJRNBki6UuWGX7Jpjc
	 bdP9AmGrhr3ZGPifoCZmj2JSCLaCQGXVwL04/6uMyt+TswVgN4qQtotiO30qsXsYc8
	 gQ9UE5r8orjdTsNhUQKF3oTgqp96KAdrfVlXK+4FYyi9yIKVae+ajoNVtyRinzTaQL
	 hrqjKlIv2VWaZ3mcuuefkqlYc2GqmXCIGgkWcDQ8lx6TaDDCEw0/pEeQOmc0Pa2B3J
	 RpVPyU7zgzBgA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick <nick@kousu.ca>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v2 1/3] ACPI: button: Fix ACPI GPE handler leak during removal
Date: Fri, 22 May 2026 16:49:44 +0200
Message-ID: <7954431.EvYhyI6sBW@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2046403.PYKUYFuaPT@rafael.j.wysocki>
References: <2046403.PYKUYFuaPT@rafael.j.wysocki>
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
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Cc: 6.15+ <stable@vger.kernel.org> # 6.15+
---

v1 -> v2:
   * Add R-by from Mario
   * No other changes

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



