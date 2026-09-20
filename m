Received: from forward400a.mail.yandex.net (forward400a.mail.yandex.net [178.154.239.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F84352031;
	Sun, 20 Sep 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896915; cv=none; b=sefYrEyE3V67e1mECWgBnB/ewbyCQuKZL+X4MpSjMaQsjGLixAIXH11BVWWe1fUt9KJb+ERlotTfb/9aR9rq375/b1YOOI7j6S0MYm/kXDAj+EWsAzF6koaK2v4lsjd8cGbaU19TLTlMf+bgLz+Qz7pUDxlVuxgMT3hH7LHg3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896915; c=relaxed/simple;
	bh=woZI6uPGoA8KASrI3mT1kqL/a3UB0rXDWmryPhTwy+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmsiIyMTBIFXQ15Liq135K1o853rMe6fr3n65mPBx6XJ2T8RJpaWVrDKyp3C3S7f+hLvKxrv/f9cxYVbbPfwavqXAj0Vu0Zk18TA6No47DVKHIwxMjybMzvKnRSc1ib3OXN/eM1ns3HfMd+BWjxhoZNeJHJ0EectEBPE89hTa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=PRrnJOlp; arc=none smtp.client-ip=178.154.239.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="PRrnJOlp"
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward400a.mail.yandex.net (postfix) with ESMTPS id 117C4C064C;
	Sun, 20 Sep 2026 12:28:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id ASVxuRVdNKo0-aVVBHvJF;
	Sun, 20 Sep 2026 12:28:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1789896500; bh=Q/Y8k4bWmd1QSaHxBP9PRRfReRKW0CUt7aj4ZkfTEQU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=PRrnJOlpg3eGawGLTFPuzzSNTsHI0I2+8egeAZqz3QJl6zml0NfjJaA6Kwo4WOCkI
	 xJjuDgptbOwcro6K1UWlMLvXdWPTsUyirY+3bdMjQw9rbuz7GaCoav+uMusuVfp7/p
	 fwnYTD+oo7+QIwsFjDyLmpYJrXoQgg2hCjfuNiic=
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
Subject: [PATCH 0/4] Add support for the bass speakers of Lenovo Yoga Slim 7 Carbon 14ACN6
Date: Sun, 20 Sep 2026 12:28:04 +0300
Message-ID: <20260920092808.17234-1-i.pavluhin@ya.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo Yoga Slim 7 Carbon 14ACN6 (82L0, Ryzen 5000) has four
speakers. The two tweeters are driven directly by the ALC287, the two
bass speakers by a pair of CS35L41 amplifiers on I2C. On Linux only
the tweeters work [1].

The amplifiers are described by ACPI HID CLSA0102, without _DSD, in a
single node with both I2C addresses, the same way as CLSA0100/CLSA0101
on the Legion 7. Patches 1-3 add CLSA0102 next to them. The Windows
Cirrus driver configures CLSA0102 with an external speaker supply, so
external boost is used.

Patch 4 adds the codec quirk. The ALC287 only clocks the I2S bus to the
amplifiers while pin 0x17 is enabled, and the BIOS marks that pin as
unconnected.

Tested on a Yoga Slim 7 Carbon 14ACN6 (BIOS H5CN42WW) with all four
speakers playing. The DSP firmware (cs35l41-dsp1-spk-prot-17aa3856*)
is not in linux-firmware yet. For testing it was taken from the Lenovo
Windows driver package (tuning "Lenovo-S760-17AA383D"). Without it the
driver falls back to the default spk-prot firmware.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215632

Ilya Pavlukhin (4):
  ACPI: scan: Add CLSA0102 to the serial bus ignore list
  platform/x86: serial-multi-instantiate: Add CLSA0102
  ALSA: hda: cs35l41: Add support for CLSA0102
  ALSA: hda/realtek: Add quirk for Lenovo Yoga Slim 7 Carbon 14ACN6

 drivers/acpi/scan.c                           |  1 +
 .../platform/x86/serial-multi-instantiate.c   |  1 +
 sound/hda/codecs/realtek/alc269.c             | 28 +++++++++++++++++++
 .../hda/codecs/side-codecs/cs35l41_hda_i2c.c  |  3 ++
 .../codecs/side-codecs/cs35l41_hda_property.c | 28 +++++++++++++++++++
 5 files changed, 61 insertions(+)


base-commit: 4d4bc656580bcc448f8e6d6b3b3a903120eb29bb
-- 
2.43.0

