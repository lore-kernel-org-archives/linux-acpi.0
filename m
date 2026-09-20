Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C53DD516;
	Sun, 20 Sep 2026 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896529; cv=none; b=LAMMiASdDwPjEdnu0ZY/QTSm5nGF7LvOzuZSPR7T002mJSn/x8kjv1w3lsiQAQZhizpHPMlnu6G3JYVZ7CqtwA3x8aLrlZM1AjEb0nVzK7B+TxkPbDh5AB4K/KlML4uLsMcmeAEqJ0rJ7hDf8+2iGf5c7S11v4D5ZuyJLBu9ZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896529; c=relaxed/simple;
	bh=yTyBEhS1q5MXbENk9f9ENQ3RJtDy/Bwr+H2KpU42fAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiuXZP9UQY8BxXh0YsLnB/HLSKIRe1JH6FryHuiOfFFFfe9evDrJxBPW4fmew8oaOj4veS9BXn1TlTdL7Iet7ukIOXA24yluUKtpOfKJoEbz8gJ5aB7Gov/qUkO7VT1TShf/KRqsS6iC43KAFn2qGkVcBQD8bNzH5P85unsiUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=gmoyDYR7; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="gmoyDYR7"
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward500a.mail.yandex.net (postfix) with ESMTPS id 80292C14C7;
	Sun, 20 Sep 2026 12:28:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id ASVxuRVdNKo0-9P9dmTN4;
	Sun, 20 Sep 2026 12:28:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1789896524; bh=7uHzFs83OInMmuS6bd4a8PZ6o8dGwYn0VYGOPrrY8u8=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=gmoyDYR70lhI/z+glkASSC4VTllnBMnW5eRzDdRkDEw6ynJ6Wxp9tRMy3aRra0xl/
	 hNJfQFk5AkABT+aHbtIWgfY6v+eIDoBGkbncbhcGcrlVdScaOz7gfYwsho5BMSmIGD
	 Syk0nfbTeozUwmjxmx7ZWvgHv8ry4syZpL4XahlI=
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
Subject: [PATCH 4/4] ALSA: hda/realtek: Add quirk for Lenovo Yoga Slim 7 Carbon 14ACN6
Date: Sun, 20 Sep 2026 12:28:08 +0300
Message-ID: <20260920092808.17234-5-i.pavluhin@ya.ru>
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

The bass speakers of the Lenovo Yoga Slim 7 Carbon 14ACN6 (82L0) are
driven by two CS35L41 amplifiers, fed over I2S by the ALC287. The codec
only clocks the I2S bus while pin 0x17 is enabled, but the BIOS reports
the pin as unconnected (0x411111f0). The amplifiers then never see a
clock and fail to power up:

  cs35l41-hda i2c-CLSA0102:00-cs35l41-hda.0: Enable(1) failed: -110

Configure pin 0x17 as a speaker and keep it on DAC 0x02 together with
pin 0x14: with DAC 0x06 the path is powered down during stereo
playback, which stops the clock again. Then bind the two CS35L41
amplifiers.

The PCI SSID of this machine is 17aa:0000, so match on the codec SSID.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215632
Assisted-by: Claude Opus 5
Signed-off-by: Ilya Pavlukhin <i.pavluhin@ya.ru>
---
 sound/hda/codecs/realtek/alc269.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 8f55c3c00..7856c92df 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3448,6 +3448,28 @@ static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
 	comp_generic_fixup(cdc, action, "i2c", "CLSA0101", "-%s:00-cs35l41-hda.%d", 2);
 }
 
+static void alc287_fixup_yoga_slim7_carbon_speakers(struct hda_codec *cdc,
+						    const struct hda_fixup *fix, int action)
+{
+	/*
+	 * The bass speakers are driven by two CS35L41 amps fed over I2S. The codec only
+	 * clocks the I2S bus while pin 0x17 is enabled, but the BIOS marks it unconnected.
+	 * Keep the pin on DAC 0x02 with the other speakers: DAC 0x06 gets powered down
+	 * with stereo streams, which stops the clock and the amps fail to power up.
+	 */
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x17, 0x90170121 },
+		{ }
+	};
+	static const hda_nid_t conn[] = { 0x02 };
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		snd_hda_apply_pincfgs(cdc, pincfgs);
+		snd_hda_override_conn_list(cdc, 0x17, ARRAY_SIZE(conn), conn);
+	}
+	comp_generic_fixup(cdc, action, "i2c", "CLSA0102", "-%s:00-cs35l41-hda.%d", 2);
+}
+
 static void alc285_fixup_asus_ga403u(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
 	/*
@@ -4328,6 +4350,7 @@ enum {
 	ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE,
 	ALC295_FIXUP_FRAMEWORK_LAPTOP_LIMIT_INT_MIC_BOOST,
 	ALC287_FIXUP_LEGION_16ITHG6,
+	ALC287_FIXUP_YOGA_SLIM7_CARBON_SPEAKERS,
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK,
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
 	ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN,
@@ -6690,6 +6713,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc287_fixup_legion_16ithg6_speakers,
 	},
+	[ALC287_FIXUP_YOGA_SLIM7_CARBON_SPEAKERS] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_yoga_slim7_carbon_speakers,
+	},
 	[ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -8182,6 +8209,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
+	HDA_CODEC_QUIRK(0x17aa, 0x3856, "Lenovo Yoga Slim 7 Carbon 14ACN6", ALC287_FIXUP_YOGA_SLIM7_CARBON_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3862, "Lenovo IdeaPad Slim 3 15ABR8", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x3865, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3866, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.43.0

