Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214C242D97;
	Sun, 20 Sep 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896533; cv=none; b=du3vr7ikn1wx08YUEskvXx3FuXqfCdMfOjAsRzf0erxvzNYhuGNLPB84BZbrJ0TXDg4egvVu6fqCWN7De7x+CPYPXTWWbLe0OEUZMiOveAqbkWPHb2xLjWU1UUcOiDuWzIdvuJatoLUNiikTfZS5ozI+hZ1bStwFFQ8MOj2Jl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896533; c=relaxed/simple;
	bh=hgwPJRIczXoFYJijp2g4Y8z8LtCYgQWJfBQrybGU1Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bP148XQlT0hxcTGTN5CJV4CMIyX84iI/naJ/OPckvnsvQ5YBPVe76pxv93e/9JZgrqEWPVIKihgrhAFH0Uf9Y33AagLVkgAMLmIjwcKVa7gj7ejayJ/5nDZo4pn6AJBkMsqRIf661pLQhxhgDqsvGt1ZSHkM5YR0dRmHE6DE6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=C5dXQNLm; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="C5dXQNLm"
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward500a.mail.yandex.net (postfix) with ESMTPS id 62832C14B9;
	Sun, 20 Sep 2026 12:28:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id ASVxuRVdNKo0-jvq4vgGb;
	Sun, 20 Sep 2026 12:28:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1789896522; bh=xTyNvZgw1mxOYgf4UvrUhQwzHZVZ2OBTnlIpeAnubEA=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=C5dXQNLm6/Ahufk0GOCSBgI1wx7hmK2mYwm0D/AvNaECMNcU80a2UNoAKEbMX95lH
	 U8V82OtK6efa03bHf/KBsApJJ8AGq4964Kni9dS87+312K+iXfpl0BtpCUcahrZTrY
	 Ezp3DzWiIRtxaJBH0xciaEb4N/5zQSvieqIGncvw=
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
Subject: [PATCH 3/4] ALSA: hda: cs35l41: Add support for CLSA0102
Date: Sun, 20 Sep 2026 12:28:07 +0300
Message-ID: <20260920092808.17234-4-i.pavluhin@ya.ru>
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

The Lenovo Yoga Slim 7 Carbon 14ACN6 (82L0) drives its bass speakers
with two CS35L41 amplifiers, described by ACPI HID CLSA0102 without a
_DSD. The node has the same layout as CLSA0100/CLSA0101: both amps in
one node, reset on GPIO index 0 and the interrupt on a GpioInt. Unlike
the Legion 7 there is no speaker ID GPIO, index 2 is the interrupt line.

The Windows driver runs the amps from an external VSPK supply
(ExternalVspkControl, boost converter disabled), so use
CS35L41_EXT_BOOST with the VSPK switch on GPIO1. With the internal
boost converter enabled the amps report "Amp short error" during
playback.

There is no _SUB in the ACPI node, so the firmware files are looked up
by the codec SSID, 17aa3856.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215632
Assisted-by: Claude Opus 5
Signed-off-by: Ilya Pavlukhin <i.pavluhin@ya.ru>
---
 .../hda/codecs/side-codecs/cs35l41_hda_i2c.c  |  3 ++
 .../codecs/side-codecs/cs35l41_hda_property.c | 28 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_i2c.c b/sound/hda/codecs/side-codecs/cs35l41_hda_i2c.c
index fdf406e92..59b82238f 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda_i2c.c
@@ -23,6 +23,8 @@ static int cs35l41_hda_i2c_probe(struct i2c_client *clt)
 		device_name = "CLSA0100";
 	else if (strstr(dev_name(&clt->dev), "CLSA0101"))
 		device_name = "CLSA0101";
+	else if (strstr(dev_name(&clt->dev), "CLSA0102"))
+		device_name = "CLSA0102";
 	else if (strstr(dev_name(&clt->dev), "CSC3551"))
 		device_name = "CSC3551";
 	else
@@ -45,6 +47,7 @@ static const struct i2c_device_id cs35l41_hda_i2c_id[] = {
 static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
 	{"CLSA0100", 0 },
 	{"CLSA0101", 0 },
+	{"CLSA0102", 0 },
 	{"CSC3551", 0 },
 	{}
 };
diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
index 416d7bf3e..c4f2bbed0 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
@@ -439,6 +439,33 @@ static int lenovo_legion_no_acpi(struct cs35l41_hda *cs35l41, struct device *phy
 	return 0;
 }
 
+/*
+ * Device CLSA0102 (Lenovo Yoga Slim 7 Carbon 14ACN6) has the same ACPI layout as CLSA010(0/1):
+ * no _DSD, both amps in one node, reset on GPIO index 0. It has no speaker ID GPIO, the
+ * interrupt GPIO sits at index 2. The speakers use an external VSPK supply switched by GPIO1
+ * (the Windows driver sets ExternalVspkControl and keeps the boost converter off).
+ */
+static int lenovo_yoga_slim7_carbon_no_acpi(struct cs35l41_hda *cs35l41, struct device *physdev,
+					    int id, const char *hid)
+{
+	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
+
+	/* check I2C address to assign the index */
+	cs35l41->index = id == 0x40 ? 0 : 1;
+	cs35l41->channel_index = 0;
+	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
+	cs35l41->speaker_id = -ENOENT;
+	hw_cfg->spk_pos = cs35l41->index;
+	hw_cfg->bst_type = CS35L41_EXT_BOOST;
+	hw_cfg->gpio1.func = CS35l41_VSPK_SWITCH;
+	hw_cfg->gpio1.valid = true;
+	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
+	hw_cfg->gpio2.valid = true;
+	hw_cfg->valid = true;
+
+	return 0;
+}
+
 static int missing_speaker_id_gpio2(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
 				    const char *hid)
 {
@@ -463,6 +490,7 @@ struct cs35l41_prop_model {
 static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
+	{ "CLSA0102", NULL, lenovo_yoga_slim7_carbon_no_acpi },
 	{ "CSC3551", "10251826", generic_dsd_config },
 	{ "CSC3551", "1025182C", generic_dsd_config },
 	{ "CSC3551", "10251844", generic_dsd_config },
-- 
2.43.0

