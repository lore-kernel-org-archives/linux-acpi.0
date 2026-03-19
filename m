Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9B38F95E;
	Thu, 19 Mar 2026 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920025; cv=none; b=ZqwwU3tgxhxUr1zFerJyBDAIuHEHS+FCeOv2V0IocQCRSupseDTILPqwwpn4mtPe8tOIlmG6e06w3yZKd02NPZHHXkn43QU5TyjfyR3kxU2HCSXcqYrFmlSagF2ryJznfAiYlyTk5bTVKQ1xagb4t25oqqx7WVuTZyUUpe6xDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920025; c=relaxed/simple;
	bh=fSgbQzUnV0PvKHUbgo84A/Lbjhd6xf8Nd4B3SHXZAjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZmJ48VKwLCVJkmrc5loLdKdMR2tXVo4YtkiV82uFvJai5onYMk6x26RSOuwwvfluTxkpCol8jRYSp6tRbFQHUxKw2VLB1JKYHtM27fOc/H2T1btVKkKJ/5TifvBjeYbHh3O+DYBZnD7vSoepHxEBtfXAuA18YNG620MuIWcSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp7zhn3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp7zhn3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1486C2BC87;
	Thu, 19 Mar 2026 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920025;
	bh=fSgbQzUnV0PvKHUbgo84A/Lbjhd6xf8Nd4B3SHXZAjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rp7zhn3zHvyhveUjKwTVb2EzQVGWVAxry2svNsww1VFeLSWJKuduZjKus2qwXgTMz
	 IujBjAJzgKdDdA31YFfqAk4wGqo1ep2rUFEh50DhL1ex4LO1SnNCzPLf4IZl9tst7U
	 vkTbvnUgRAE5mJoKySPItZYOSf5CUqtXpMHL2mNNbRZ3qqocxMXsP0OhIaFJukcVJy
	 0fnPqJbIFk1FtsgYbnWlNB/fNlh4asglEDrdWjiZVhqRQDhyQojS2myiO3HNKWlbqp
	 mjYmqRq7P1NPDkzadmhp+d/Y5ERvG4NijROpKpxTu6FMAF2nJebJ/N2y4kFfRC1HiZ
	 BSB0snLMSW61Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v3 1/5] platform/x86: panasonic-laptop: Make
 pcc_register_optd_notifier() void
Date: Thu, 19 Mar 2026 12:25:29 +0100
Message-ID: <2409190.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12863246.O9o76ZdvQC@rafael.j.wysocki>
References: <12863246.O9o76ZdvQC@rafael.j.wysocki>
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




