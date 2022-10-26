Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435BCC433FE
	for <linux-acpi@archiver.kernel.org>; Wed, 26 Oct 2022 17:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiJZRf5 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 26 Oct 2022 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbiJZRfz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2022 13:35:55 -0400
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1111D2CDD
        for <linux-acpi@vger.kernel.org>; Wed, 26 Oct 2022 10:35:53 -0700 (PDT)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 26 Oct 2022 20:29:06 +0300
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 29QHSvL7015424;
        Wed, 26 Oct 2022 13:28:57 -0400
Received: (from asmaa@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 29QHSrSq027301;
        Wed, 26 Oct 2022 13:28:53 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        bgolaszewski@baylibre.com, linux-acpi@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 0/2] Add NVIDIA BlueField-3 GPIO driver and pin controller
Date:   Wed, 26 Oct 2022 13:28:41 -0400
Message-Id: <20221026172843.27236-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series of patches addresses maintainers' comments from a
previous patch which supported the GPIO driver for BlueField-3 SoC:
"[PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO controller"
Instead of creating v2 for that patch, I am creating a new series
starting patch v1 because there are 2 drivers involved.

It was suggested to follow the linux gpio standards, and separate the
pin controller functionality from the gpio functionality.
Instead of creating a followup v2 patch, I am creating a new series
because there are 2 drivers (2 patches) involved now:
1) NVIDIA BlueField-3 GPIO driver as front end
2) NVIDIA BlueField-3 pin controller as back end

Moved the FW_CONTROL_CLEAR/SET code to the pin controller so that
there are 2 GPIO mux selectors:
1) default hardware functionality
2) gpio functionality where software can control the GPIO value when
   the direction is set to output.

Removed support to the GPIO sysfs since its use is deprecated and risky.
Instead, used libgpiod to test this code.

Asmaa Mnebhi (2):
  Support NVIDIA BlueField-3 GPIO controller
  Support NVIDIA BlueField-3 pinctrl driver

 drivers/gpio/Kconfig            |   7 +
 drivers/gpio/Makefile           |   1 +
 drivers/gpio/gpio-mlxbf3.c      | 314 ++++++++++++++++++++++++++++
 drivers/pinctrl/Kconfig         |   9 +
 drivers/pinctrl/Makefile        |   1 +
 drivers/pinctrl/pinctrl-mlxbf.c | 353 ++++++++++++++++++++++++++++++++
 6 files changed, 685 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c
 create mode 100644 drivers/pinctrl/pinctrl-mlxbf.c

-- 
2.30.1

