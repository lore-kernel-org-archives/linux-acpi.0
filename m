Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.72.42.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542470;
	b=nmxOv6Z+ob69hIbVIKklc4ElXld41k7qeOZhQcfGXYYmQnyZSN0HfJSwPtivClmwW1fi
	 uKUZniDYPMpuBH9O2XtmK7cAQPPP3Uo4u7j/pDb138T+YgZq+RhUF+zSvxMdYH/ZRJvHU
	 kQRL40O5+tHjCL7jXWNW5gN0XthS8Pc2dEbgPJls0jQc8R5J7lygtInbUshYz8tZKavnK
	 0ScYZrLAKxd8FNfULKbOYo2CeU+gocEXm8x1ZWCvX70oqoOMOPMh1NzQwHWWtw5Vqp3zG
	 pKhDpKR75n15VbRdHhYUXJ//f4NFwXrOuVIE61yzOFcwak054Z+yGEjuvcsS5+Xrvug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542470;
	h=DMARC-Filter:DKIM-Signature:X-Mailgun-Sid:Received:
	 X-Mailgun-Sending-Ip:Sender:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=WR8QGD5bhxybtwKA83TYYiEEB/OOUPxVSpddEvqXgOk=;
	b=aKBfw0309GCVBt0oE063UbWq1kUT6Rn/KEqv9LY5LtanW/0nFIL5QN6hcxRQhx2huEVW
	 7q+LHK3IBXCBlZ7LQI5Bhwt5XIXIYakxyi5qINAE7+8GqW9hx9ogs98F7OkxP0d322ooY
	 Ubw7TUVFZ3Buiu/cOSkL1ok05ngahrLHUe18yQF3afxdJe6IBWz9A/qTbtoc+NbMf2upC
	 PVKB+xhKy69ulTwnqK+E1SoDju+RiotJXQSDPwxMKBMhRHtg86MNVhkfKyfkdW5YrQ19N
	 rCLE9V6hk36HOFaICUKcsk999R9fFRs5gxQVvWVvx4MHtMbQwgbApkTVeZllG5EYGLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=elijahmock.com;
	spf=pass smtp.mailfrom=elijahmock.com;
	dkim=pass header.d=elijahmock.com header.i=@elijahmock.com header.a=rsa-sha256 header.s=k1 header.b=ZJO2HtbO;
	arc=none smtp.remote-ip=69.72.42.10
Received: from v510.v51e342bd.use4.send.mailgun.net (v510.v51e342bd.use4.send.mailgun.net [69.72.42.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E1B77606A31E
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 17:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1B77606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahmock.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahmock.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=elijahmock.com header.i=@elijahmock.com header.a=rsa-sha256 header.s=k1 header.b=ZJO2HtbO
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=elijahmock.com; q=dns/txt; s=k1; t=1795542468; x=1795549668;
 h=Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: From: From: MIME-Version: Sender: Sender;
 bh=WR8QGD5bhxybtwKA83TYYiEEB/OOUPxVSpddEvqXgOk=;
 b=ZJO2HtbOnWzJBLL9/l5HSSXEdERuYcbBa5gAeoVWRGt/P/dpmR/2SQnpiknKA1hyTq57MuAvpOINdg8eeYRJWJhPgT3V7jzFpAw/M+nT2YburRO0XtBXxDtDK3qITJ2wY3mluTXnPxrVNqCmaaKY258QtxrampOBo0IemcZEcrc=
X-Mailgun-Sid: WyJkMjhkYyIsImxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnIiwiMzdlMTdhYyJd
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182]) by
 89c784442a2c4c3643689298a4a7a185be77a10dfe81b7ea9bf477b149b5675d with SMTP id
 6b05cdc4a23a793d837429c6 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 24 Nov 2026 17:47:48 GMT
X-Mailgun-Sending-Ip: 69.72.42.10
Sender: elijah@elijahmock.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ae0a5c1715so53294681fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 09:47:48 -0800 (PST)
X-Gm-Message-State: APuU4Z9t82AQGNYiheP1CBJoL03QITLBZeMJBaQVCK64i9g3ZcNW87EC
	CJxJlEN2ZrVnrgyHhpc3AqWeN9ElxNhr5qf64rdlMdYqx1jWaK5tGtw8Ai20/2kankKgctwizwk
	2OyOG5CzMdQdn7v1VivgupdG6PbEyuJ4=
X-Received: by 2002:a2e:be87:0:b0:3ac:d116:1adb with SMTP id
 38308e7fff4ca-3ae7fb1e74dmr35117811fa.15.1795542467146; Tue, 24 Nov 2026
 09:47:47 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Elijah Mock <elijah@elijahmock.com>
Date: Tue, 24 Nov 2026 11:47:30 -0600
X-Gmail-Original-Message-ID: <CAELUYsg63KtWSfKvyywEyeUsWrfYcuko6+WnGgi4DJ_-pRHZFw@mail.gmail.com>
X-Gm-Features: Aa3M54oTf2ePHMrN23d7gHQseqxi9RB6Bk2hpfm6x-Z6QW3vNN5jQ6sdynvs5Cg
Message-ID: <CAELUYsg63KtWSfKvyywEyeUsWrfYcuko6+WnGgi4DJ_-pRHZFw@mail.gmail.com>
Subject: [PATCH] ACPI: button: Disable default lid wakeup on MSI MS-15FK
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
+ {
+ /*
+ * MSI Creator A16 AI+ A3HVFG (MS-15FK): LID0 declares a
+ * handlerless _PRW GPE (0x03) with S0 wake state whose status
+ * bit stays asserted regardless of lid state, aborting s2idle
+ * immediately when armed for wakeup.
+ */
+ .matches = {
+ DMI_MATCH(DMI_BOARD_VENDOR,
+  "Micro-Star International Co., Ltd."),
+ DMI_MATCH(DMI_BOARD_NAME, "MS-15FK"),
+ },
+ },
+ {}
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
- device_init_wakeup(dev, true);
+ if (button_type == ACPI_BUTTON_TYPE_LID &&
+    dmi_first_match(dmi_lid_no_wakeup_quirks)) {
+ dev_info(dev, "Disabling default wakeup due to DMI quirk\n");
+ device_set_wakeup_capable(dev, true);
+ } else {
+ device_init_wakeup(dev, true);
+ }
  return devm_add_action_or_reset(dev, acpi_button_wakeup_cleanup, dev);
 }

@@ -747,7 +770,7 @@ static int acpi_button_probe(struct platform_device *pdev)
  if (error)
  return error;

- error = devm_acpi_button_init_wakeup(dev);
+ error = devm_acpi_button_init_wakeup(dev, button_type);
  if (error)
  return error;


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1
