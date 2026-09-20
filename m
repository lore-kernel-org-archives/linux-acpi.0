Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6090378D89;
	Sun, 20 Sep 2026 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896530; cv=none; b=KGSV1VphVa50S3sAIK6Hc1rhqhSLDM9bId9C33Xf0sEvs6GNIEV+kpQ0X2t8HJXbegMq5+2vm1lkRySZj5a4VmAt7cr3A/2mwvf8tA50HbAV/9t507QU5qRkTWVVsLo1f3hovj05UkB5R+LsP6ZQgL8Y8Z9SXpvEs8gN5S91YlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896530; c=relaxed/simple;
	bh=12XGDR2rva/IpAWRYPi8umReSDWEYYybEMqmiKHU+8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVPtlheIY2ZLyza02f3RM82dn6yRQ42W5FVGCSPBOLd7eRQbq8tujLbD9tSCINK7HR385FFd0OUGV2f3tnAeO4cVA9tVkLOqJj2CCjBLnAGNALzWer07LCOa0uFMfCCTIdxD6ETCHpQ7nT+QC4cIQI4Ix8WwOaOnQuCi4ZGdSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=Qz2/LxYs; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="Qz2/LxYs"
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward500a.mail.yandex.net (postfix) with ESMTPS id 075F6C1495;
	Sun, 20 Sep 2026 12:28:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id ASVxuRVdNKo0-YpQIcxqA;
	Sun, 20 Sep 2026 12:28:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1789896519; bh=1zTjRZSG/PDuJdZoELM+FvZytFL3+esKxf73oey3Jdo=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Qz2/LxYsdo/hR4c3z5FYscQ6/+1E1uEodrnHDYD4MqWMPHETJ2Nw30Zn+QurluOyN
	 lAXIY1VMjm2062aT7jMGOmHAAbc6TjmT/fml0rfqBptAmxmeW/cvXr8IqMrYrdbk7Z
	 umLBj19Rd0BCw9W8keSPJTTeOGxVO7QumqHhihVk=
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
Subject: [PATCH 2/4] platform/x86: serial-multi-instantiate: Add CLSA0102
Date: Sun, 20 Sep 2026 12:28:06 +0300
Message-ID: <20260920092808.17234-3-i.pavluhin@ya.ru>
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

Instantiate both CS35L41 amplifiers of the CLSA0102 node found on the
Lenovo Yoga Slim 7 Carbon 14ACN6 (82L0), the same way as for CLSA0100
and CLSA0101.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215632
Assisted-by: Claude Opus 5
Signed-off-by: Ilya Pavlukhin <i.pavluhin@ya.ru>
---
 drivers/platform/x86/serial-multi-instantiate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 3e89fcdd4..d535025a3 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -426,6 +426,7 @@ static const struct acpi_device_id smi_acpi_ids[] = {
 	/* Non-conforming _HID for Cirrus Logic already released */
 	{ "CLSA0100", (unsigned long)&cs35l41_hda },
 	{ "CLSA0101", (unsigned long)&cs35l41_hda },
+	{ "CLSA0102", (unsigned long)&cs35l41_hda },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, smi_acpi_ids);
-- 
2.43.0

