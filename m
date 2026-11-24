Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.72.42.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544477;
	b=z/Xxs/ZLufLn6tqg5S/VB04OqZuZB026DanIncv1Q6LlAReHjWAlcO22CoBbQ08XWvYX
	 JEBZbNu2jV1b3SoQ/RIuM+eFDCm+dmfEkP+w4Vx9+xNnLE08NhEilAyeNbSq/zOElo5Rt
	 BWe9/U2xrtEDHnhvgeH8f9Wf9HuTRJfSIvAV/ZuzTz5Y1L2n28SCkUmNkYPtDcblU5MIN
	 CXqDAj5bULytXpDH7ION5iyIxsAAabcQ/AQ/YO+BHwk0QJN51ryZiVxuMJISsJXt8Lg1T
	 jV+hsgCf1xWBf7Zas0XwNejiIb0dGSqRgcRChxW4jWf52Hq+rlEoW1Dzf7zM9jatPGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544477;
	h=DMARC-Filter:DKIM-Signature:X-Mailgun-Sid:Received:
	 X-Mailgun-Sending-Ip:Sender:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WR8QGD5bhxybtwKA83TYYiEEB/OOUPxVSpddEvqXgOk=;
	b=a+Wz1fqCx0Hd531T/A++lw9Gn2flKhd2uacJbB+IfhzfYQUdTVTvRSZwsyfM0H1t7U50
	 sGHW0X4GPtRjhUe1FaZeRgQKWHsUxgcKdqVRnRIL6OP0n6fnNCtxx/xSkitotSFGWpKez
	 Xpj9AA5scFu4jycUS549BdOZSyzMyj9gdn7B5NXjJc/KTijTAA3NqUSFZrZoCnaKCsv1C
	 o7BrGyWjkDJpzFs4VyRGjWDWo52P0yfUqXAHeB6htsgSJIzGXIVBf0kgR/6zUl0xRdXb+
	 U/Q6266QFg1D3vZoQJEnmrXSYaTIp2cwUYVjQnLVAErGF17z8A4R07OBuAbkSrdbUtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=elijahmock.com;
	spf=pass smtp.mailfrom=elijahmock.com;
	dkim=pass header.d=elijahmock.com header.i=@elijahmock.com header.a=rsa-sha256 header.s=k1 header.b=Byv8v3Lh;
	arc=none smtp.remote-ip=69.72.42.10
Received: from v510.v51e342bd.use4.send.mailgun.net (v510.v51e342bd.use4.send.mailgun.net [69.72.42.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D7DD5606A337
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 18:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7DD5606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahmock.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahmock.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=elijahmock.com header.i=@elijahmock.com header.a=rsa-sha256 header.s=k1 header.b=Byv8v3Lh
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=elijahmock.com; q=dns/txt; s=k1; t=1795544471; x=1795551671;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=WR8QGD5bhxybtwKA83TYYiEEB/OOUPxVSpddEvqXgOk=;
 b=Byv8v3LhEexamkWsCJc4NB+2oSwMhVTn3NPKNWmy2xbUDBk+IBvp+ozh6c+BwKY814a1xSnI4hnnTgp0DKppdZ5j2zprHwMtBwEhZoM+y+8Pyoukn74Ypr5alDasDlpd+SYTVw37RSwf9l87djqeBHeJS6n849sjw90R9LryRBE=
X-Mailgun-Sid: WyJkMjhkYyIsImxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnIiwiMzdlMTdhYyJd
Received: from MENTATL04-3 (host-39-195.ilsjcolo.stjoesph.il.us.clients.pavlovmedia.net
 [173.230.39.195]) by
 29a238dadd1fbc3ccd5d6588bd9a5405787eb1b1c20b4eb859453fcbf27e5686 with SMTP id
 6b05d5961bb71291d89d0188 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 24 Nov 2026 18:21:10 GMT
X-Mailgun-Sending-Ip: 69.72.42.10
Sender: elijah@elijahmock.com
From: Elijah Mock <elijah@elijahmock.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: button: Disable default lid wakeup on MSI MS-15FK
Date: Tue, 24 Nov 2026 12:20:46 -0600
Message-ID: <20261124182046.33252-1-elijah@elijahmock.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the MSI Creator A16 AI+ A3HVFG (board MS-15FK), the system fails to
enter s2idle hardware sleep due to a firmware quirk exposed in v7.0.

ACPI behavior of the device: LID0 (PNP0C0D) defines a _PRW package
referencing GPE 0x03 with wake state S0 and no AML handler (_L03/_E03);
the status bit for GPE 0x03 remains 1 regardless of the physical lid
state. Lid open/close detection via the Embedded Controller (GPE 0x0A)
functions correctly.

Following commit 52d864019636 ("ACPI: button: Convert the driver to a
platform one") and commit 57c31e6d620f ("ACPI: scan: Use
acpi_setup_gpe_for_wake() for buttons"), GPE 0x03 is armed for wakeup
during suspend, which immediately causes a spurious wakeup (regardless
of whether the lid is open or closed) [1].

To prevent this issue, add a DMI quirk for board MS-15FK so that
devm_acpi_button_init_wakeup() marks LID0 as wakeup-capable via
device_set_wakeup_capable(dev, true) but does not enable wakeup by
default with device_init_wakeup(dev, true); instead, the ED lid
detection delivers necessary wakeup events. This fixes
suspend-to-idle while preserving normal lid state reporting and
preserving the lid wakeup event handler for user space.

Fixes: 52d864019636 ("ACPI: button: Convert the driver to a platform one")
Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for buttons")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5283 [1]
Cc: stable@vger.kernel.org
Signed-off-by: Elijah Mock <elijah@elijahmock.com>
---
Testing:
- Tested on MSI Creator A16 AI+ A3HVFG (BIOS E15FKAMS.321, 09/17/2026)
  on top of mainline (v7.4-rc4+)
- Verified hardware sleep with lid open and lid closed, using amd-s2idle
  test
- Verified awake lid state reporting (/proc/acpi/button/lid/LID0/state)

Notes for reviewers:
- I am supposing that this is a firmware quirk matching MS-15FK (largely
  due to this issue not being widely reported) and not a generic ACPI
  kernel issue
- The Fixes: tags reference the commits that exposed this firmware
  quirk; let me know if they are not appropriate

 drivers/acpi/button.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 91a4e9698f7..c80164283d6 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -170,6 +170,23 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 	{}
 };
 
+static const struct dmi_system_id dmi_lid_no_wakeup_quirks[] = {
+	{
+		/*
+		 * MSI Creator A16 AI+ A3HVFG (MS-15FK): LID0 declares a
+		 * handlerless _PRW GPE (0x03) with S0 wake state whose status
+		 * bit stays asserted regardless of lid state, aborting s2idle
+		 * immediately when armed for wakeup.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR,
+				  "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-15FK"),
+		},
+	},
+	{}
+};
+
 static int acpi_button_probe(struct platform_device *pdev);
 static void acpi_button_remove(struct platform_device *pdev);
 
@@ -570,9 +587,15 @@ static void acpi_button_wakeup_cleanup(void *data)
 	device_init_wakeup(data, false);
 }
 
-static int devm_acpi_button_init_wakeup(struct device *dev)
+static int devm_acpi_button_init_wakeup(struct device *dev, u8 button_type)
 {
-	device_init_wakeup(dev, true);
+	if (button_type == ACPI_BUTTON_TYPE_LID &&
+	    dmi_first_match(dmi_lid_no_wakeup_quirks)) {
+		dev_info(dev, "Disabling default wakeup due to DMI quirk\n");
+		device_set_wakeup_capable(dev, true);
+	} else {
+		device_init_wakeup(dev, true);
+	}
 	return devm_add_action_or_reset(dev, acpi_button_wakeup_cleanup, dev);
 }
 
@@ -747,7 +770,7 @@ static int acpi_button_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = devm_acpi_button_init_wakeup(dev);
+	error = devm_acpi_button_init_wakeup(dev, button_type);
 	if (error)
 		return error;
 

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1

