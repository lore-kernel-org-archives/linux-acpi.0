Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028F7C3F6B0
	for <linux-acpi@archiver.kernel.org>; Wed, 24 Aug 2022 19:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbiHXTAa (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 24 Aug 2022 15:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiHXTAP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 15:00:15 -0400
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 12:00:13 PDT
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7563D5
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 12:00:11 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 1A9A2142D4;
        Wed, 24 Aug 2022 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1661367009; bh=tOkc2591Bqps1R3HSvWBEkbHlpCAYpv21BJlIhSxVgE=;
        h=From:To:Cc:Subject:Date:From;
        b=kWwyUc5fIXq9hlHhyimycFmy+upmTaQeGHqqBxFFw9ynmdolGcYwpTqVnrCLod2bo
         GWKAoTxNrMuRjPSz7deUmyBVkJNb7XRJ1PZA7aSmiDbbuQyCFOkeFrNxYY3h0kWXGa
         Nd98mbS8ZYIzsWoNop+Wn7PXussBOQ4Nsoqjla22HavrWO6bWKE236EnuxSVwYYblj
         kYvYXzfu3IIHiy48yqTGOL0IragyiDEcHMSBcNIa+tY+HuUx96inzpFCTdskq23GPC
         eppV03F1YUGo3sCPCX9Kk2BW/t2zY5VX/SR2syBfNCxqHdTc3sePv3HIAvhR71Kz7/
         ddDMRltiP7ytA==
From:   Arvid Norlander <lkml@vorpal.se>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>, Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH 0/1] Fix backlight control on Toshiba Satellite Z830
Date:   Wed, 24 Aug 2022 20:49:49 +0200
Message-Id: <20220824184950.631520-1-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

First: I'm very new to this whole kernel development thing, so applogies in
advance for any mistakes.

I am submitting a patch that fixes backlight on Toshiba Satellite/Portege
Z830. This is a so called "ultrabook" from 2011. It needs the quirk
video_disable_backlight_sysfs_if. Without it backlight control breaks after
a suspend/resume cycle. However, control via intel_backlight still works.
If I disable acpi_video via acpi_backlight=none however, the backlight
never turns on at all after resume.

Thanks to Hans de Goede for suggesting this fix.

Reference:
* https://www.spinics.net/lists/platform-driver-x86/msg34394.html

Best regards,
Arvid Norlander

Arvid Norlander (1):
  ACPI: video: Add Toshiba Satellite/Portege Z830 quirk

 drivers/acpi/acpi_video.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)


base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
-- 
2.37.2

