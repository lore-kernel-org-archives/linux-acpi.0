Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2D2FD69D;
	Sun, 20 Sep 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896529; cv=none; b=AaUCs3Nc4/SXtDzqFpeHaGCckjG7nrCByTs6G58Gyjv+OuiCqqFc5dJ8k0LunaheCk7c15xk2BDlCAeIoD6bt8RmbNCoRby5yQ551cppvlQJe0ktAJUTWLJ/lEH2BgHUkyGewv6h1hsvxbzzGjIBC9PPKbR64asWn6NXAG/TMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896529; c=relaxed/simple;
	bh=oNyKHqjyScwXJJQ7Ewot/NDNXH3zuT7+mWkU2535y+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqdiTf4xfdFAziIM8E7uxoUkluEFa7yyQt3WyaSDR4jp1RDhYxmrBfpjkojpwYc0HNCkRACGm7FNKymSJVdL2Sdhzok+0LlkdP1clRdqpdV+xvczQkr8k2PnvHQylQbfgrh4hUl450USnB5bVj7IpHucQeeAQaFytQrvevPnL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=Y0FK9qEj; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="Y0FK9qEj"
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward500a.mail.yandex.net (postfix) with ESMTPS id 1E8B3C147B;
	Sun, 20 Sep 2026 12:28:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id ASVxuRVdNKo0-nUWTg5CF;
	Sun, 20 Sep 2026 12:28:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1789896516; bh=36ZUbDZxVroSbV9v3Xm3HcYk31AN564Ob58ZdtT80Dg=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Y0FK9qEj4/ykuzWvXAyCQIoCAZy9sgXc+uS5RoPnztCfaUqcqFKcRgfKuMdoN9XRC
	 nzqskoIH55JjuD9YPEeD1q/BuBlb9YeExgBcVIBC5UWVYD9U9/DakrsWmcY0w5zwUb
	 q5fwtCr4h7IloV9QdJCA0nDF3lkVlUcBtOyJYndc=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Ilya Pavlukhin <i.pavluhin@ya.ru>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ACPI: scan: Add CLSA0102 to the serial bus ignore list
Date: Sun, 20 Sep 2026 12:28:05 +0300
Message-ID: <20260920092808.17234-2-i.pavluhin@ya.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920092808.17234-1-i.pavluhin@ya.ru>
References: <20260920092808.17234-1-i.pavluhin@ya.ru>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo Yoga Slim 7 Carbon 14ACN6 (82L0) describes the two CS35L41
amplifiers of its bass speakers as a single ACPI node, HID CLSA0102,
with two I2cSerialBusV2 resources (0x40 and 0x41), like CLSA0100 and
CLSA0101 on the Legion 7. Skip the default I2C enumeration so that
serial-multi-instantiate can create a client for each amplifier.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215632
Assisted-by: Claude Opus 5
Signed-off-by: Ilya Pavlukhin <i.pavluhin@ya.ru>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f48715ed8..1d9698df9 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1768,6 +1768,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 		/* Non-conforming _HID for Cirrus Logic already released */
 		{"CLSA0100", },
 		{"CLSA0101", },
+		{"CLSA0102", },
 	/*
 	 * Some ACPI devs contain SerialBus resources even though they are not
 	 * attached to a serial bus at all.
-- 
2.43.0

