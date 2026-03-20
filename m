Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA953947A2;
	Fri, 20 Mar 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003010; cv=none; b=RE9p8fOh9Vs/D4IaoLDQWDKxEZMK/yTZD446Wph+NxuRlaD36S/r7wWATtwGkDmJ2vXe/sjtJ2rFsivjclnH5ZwZ9BjJN1SAEmz5+1yt5g9xBat3jMMnRnXKwXPzgZrWMW2KiMUQ5XyGA3I7b9zENSlVLfnKxLXdRR1RbU+Za8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003010; c=relaxed/simple;
	bh=qO3B+5cNwTcXQrdp66fEq3Q4Z7hqGePF/HmKKI87Vqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuXXPDIiOsdSTrZpE3MewnWJNOHoTDhXClHLKrfqJoj87kpzNxIouSw8EKEItCZNXM+ehn+ZAEAXiHNaCuqx7/ybMmvMoSFXaFkSHVsIVODUTv4r6dMsCMC0AIaFVGJrY0tpZw7pRNDdkY+4i4lBlW5IULCzitJSaBb6/Lxlcgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdIR+xTJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdIR+xTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C09C2BC9E;
	Fri, 20 Mar 2026 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774003010;
	bh=qO3B+5cNwTcXQrdp66fEq3Q4Z7hqGePF/HmKKI87Vqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdIR+xTJllFr8I1lsWC73Czw3qEoz7+F4FxzgklbBMx3Yg1w/noo6CcqbtM1sOHF3
	 8OO/L+Ocwllekfosgk7QIYdpOOHw1sXogbAHcMVAVQSwl+3zsUtoc/SMV7ViEVc4Wj
	 6ermpmuVDgzLEgkFlL1RXalGfCATDi9xzhOmhLi4tqb5wfSBvEmSik035cOtf6ORzM
	 d+jJSyyzFiWv/HDR9QM2ivd9GYe6OKfTOpLZP5FsI9MXzko4Oi4ZnUtqgIcjEuzgJ3
	 CuDYJ3PgWE5CdIZohgC9JQho6SuqMKCUk0cWZW6QznUe+fQsvjcdQrW2rTMxio4tBw
	 UTlsHwQZnudLw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v4 1/5] platform/x86: panasonic-laptop: Make
 pcc_register_optd_notifier() void
Date: Fri, 20 Mar 2026 11:30:32 +0100
Message-ID: <5093613.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5983583.DvuYhMxLoT@rafael.j.wysocki>
References: <5983583.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Convert pcc_register_optd_notifier() whose return value is never used to
a void function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4: No changes

v2 -> v3: New patch

---
 drivers/platform/x86/panasonic-laptop.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index d923ddaa4849..a481f2602ce3 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -891,7 +891,7 @@ static void pcc_optd_notify(acpi_handle handle, u32 event, void *data)
 	set_optd_power_state(0);
 }
 
-static int pcc_register_optd_notifier(struct pcc_acpi *pcc, char *node)
+static void pcc_register_optd_notifier(struct pcc_acpi *pcc, char *node)
 {
 	acpi_status status;
 	acpi_handle handle;
@@ -904,10 +904,7 @@ static int pcc_register_optd_notifier(struct pcc_acpi *pcc, char *node)
 				pcc_optd_notify, pcc);
 		if (ACPI_FAILURE(status))
 			pr_err("Failed to register notify on %s\n", node);
-	} else
-		return -ENODEV;
-
-	return 0;
+	}
 }
 
 static void pcc_unregister_optd_notifier(struct pcc_acpi *pcc, char *node)
-- 
2.51.0




