Return-Path: <SRS0=q5NA=CR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C40C433E2
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BAF120658
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zGVSmZ8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgIHUFD (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgIHPXJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2020 11:23:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C83C0612F2
        for <linux-acpi@vger.kernel.org>; Tue,  8 Sep 2020 05:58:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so17178767wme.5
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2020 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQtqq8I3b88XI5RYkNp0j+Hhm0cs0BlkIjWpufTUkHo=;
        b=zGVSmZ8TUolLFNV/SsDchqySxOuN18r9lrsOARAJiX8qgn27HVUTobIjs+FYWvWZpK
         QJ9gcWtrP5eg2kUnaDlT/VIsKzYVJy5Tgjs6skknmbDBNfWKHIhhM8k92MWQP9grUzvx
         hO/bdDAA1TCeMktIhuyqFMepQssGn5M6ifZvgjb+ybyIOnK+CeRS5pIKUqZiL2Yvb8c3
         p+OxFlYmMmL/IPbMNHXlwiYsiND/zk/JjY2fKEW6VLjK0jG6FgBW4WFbYSkSyJtCUPCy
         uzKGXeFcqyrWDhyozGOeoo3YF6BqoGxKrANx3KnIVV/KCbwsQmkGjcW4P0RzNP+dYHVk
         PExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQtqq8I3b88XI5RYkNp0j+Hhm0cs0BlkIjWpufTUkHo=;
        b=qH/o7ca9svCPLrC+8cxy+iDdhuAOI8UsPf4lAmvZ11Ioawlhi8Mvrh9aSxDhFPO+CC
         BedaHcb4ZKGU8SDwCQTZ1ho1fpp9JdsWx5i/MN11aAKpJu/70T3YNaFElwwd8J/Y/vJj
         10zAg4RYr3YtuhhqD/XXOeJRznhDCYPgQr+z/N7nG0zQd1U6T86kH4VIkQEN49rv+Xc+
         XkD62mnH1aTFTFbLSsdHICsBvp+d/+dQAWalbyTNs2lrRSN+LrjSaR71Wd26AK9STgVN
         //sk3QaESkR9mjXz/jdv+mcPWHw4+IEWXaFQcY1RAfMHWHWmb4XEaw/fBWJcXyevainM
         t5kg==
X-Gm-Message-State: AOAM531l8TLrE6qtEdfgcsq9RNhhreh78xJ6o2Sk7PFoghgax6Diwjln
        0lAJsOV9xdHF56ujILVeMkaTDw==
X-Google-Smtp-Source: ABdhPJxQEsA3ZPJXdjC2LTeIeTB/KU9KtEAAN1nSB7wVImXoTAnYJJZmEA23KzFA8RTOBZvJqk+S9Q==
X-Received: by 2002:a7b:c4c4:: with SMTP id g4mr4396170wmk.110.1599569902933;
        Tue, 08 Sep 2020 05:58:22 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y207sm34817875wmc.17.2020.09.08.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:58:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/3] gpiolib: generalize GPIO line names property
Date:   Tue,  8 Sep 2020 14:58:10 +0200
Message-Id: <20200908125813.8809-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I initially sent this as part of the gpio-mockup overhaul but since
these patches are indepentent and the work on gpio-mockup may become
more complicated - I'm sending these separately.

The only change is adding additional property helpers to count strings
in array.

Bartosz Golaszewski (3):
  device: property: add helpers to count items in string arrays
  gpiolib: generalize devprop_gpiochip_set_names() for device properties
  gpiolib: unexport devprop_gpiochip_set_names()

 drivers/gpio/Makefile          |  1 -
 drivers/gpio/gpiolib-acpi.c    |  3 --
 drivers/gpio/gpiolib-devprop.c | 20 ++++++-------
 drivers/gpio/gpiolib-of.c      |  5 ----
 drivers/gpio/gpiolib.c         | 55 +++++++++++++++++++++++++++++++---
 include/linux/gpio/driver.h    |  3 --
 include/linux/property.h       | 13 ++++++++
 7 files changed, 74 insertions(+), 26 deletions(-)

-- 
2.26.1

