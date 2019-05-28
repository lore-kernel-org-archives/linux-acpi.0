Return-Path: <SRS0=amFs=T4=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C56C04AB6
	for <linux-acpi@archiver.kernel.org>; Tue, 28 May 2019 23:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D11221019
	for <linux-acpi@archiver.kernel.org>; Tue, 28 May 2019 23:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=babayev.com header.i=@babayev.com header.b="ORAXNYMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfE1XCg (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 28 May 2019 19:02:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40845 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfE1XCf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2019 19:02:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so100393pgm.7
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2019 16:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=babayev.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsPnb68aqrZ2ZEL+Z6uQ/zgrptCfKlha02TX65CwO3k=;
        b=ORAXNYMduQ2zCqLfbl+PxYq02uNrg1zkNt12Vxh3KYFmCaONYogJWuwMacCSmBUB3z
         sUTcCbL2dIhxwLIWC8pm3Q1vlYhtC0pc+er+aNxdVUT0xOw1QAwpPv/mZHHGMeIglJmX
         abhnqKEuJEkn7LnH0WEWffxTmLD/g8IBJZPio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsPnb68aqrZ2ZEL+Z6uQ/zgrptCfKlha02TX65CwO3k=;
        b=RqYMzW3yzwWKFZEQLHrf40+7uEKmTFM5HHn6BgCMovA9RXc9DTlPdzi9+l48OfcQat
         VacFQ1k9CNBOGRsTZcGe7Bli46WOGJD4CX/WPAdaSLWPo+vopEuRvVMfJ4tsyAodWW7e
         QM9n/+RtTZckkBdIB3zzkPVuXHg2aSDSOd1R8ncFwYED2Hi3bUCbVGj40xcBkD5u0T7B
         5QWkVGJxQAJFFgjCDjn61oAgYkr38p8JDt7g/oIDRyaWOmxte1pIM945y6ihaJVIzokZ
         cbiRjWFDU+XEUFxcSX+b880o3feNU7XT4RvQRkddGPEd+wKthICQY8jXWgq9ML/HcWSz
         3KZg==
X-Gm-Message-State: APjAAAW6jm05Z8BUu6wWNd1RrFcRy4HZhzzHYXpqOgIHA2RKTc0Us75b
        F8Qwc4W2Flzo4moArp7fWwywJQ==
X-Google-Smtp-Source: APXvYqwoC/5IrkvcojJ1aNUdOQY1Rohcd2/rY0qY3WWwFrIz2yGjIqSW0v5fwGvlczNGaeU5LXG1cQ==
X-Received: by 2002:a63:1e62:: with SMTP id p34mr49696657pgm.49.1559084554448;
        Tue, 28 May 2019 16:02:34 -0700 (PDT)
Received: from p50.cisco.com ([128.107.241.183])
        by smtp.gmail.com with ESMTPSA id p16sm27028196pfq.153.2019.05.28.16.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:02:33 -0700 (PDT)
From:   Ruslan Babayev <ruslan@babayev.com>
To:     mika.westerberg@linux.intel.com, wsa@the-dreams.de,
        linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [net-next,v4 0/2] Enable SFP on ACPI based systems
Date:   Tue, 28 May 2019 16:02:31 -0700
Message-Id: <20190528230233.26772-1-ruslan@babayev.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes:
v2:
	- more descriptive commit body
v3:
	- made 'i2c_acpi_find_adapter_by_handle' static inline
v4:
	- don't initialize i2c_adapter to NULL. Instead see below...
	- handle the case of neither DT nor ACPI present as invalid.
	- alphabetical includes.
	- use has_acpi_companion().
	- use the same argument name in i2c_acpi_find_adapter_by_handle()
	  in both stubbed and non-stubbed cases.

Ruslan Babayev (2):
  i2c: acpi: export i2c_acpi_find_adapter_by_handle
  net: phy: sfp: enable i2c-bus detection on ACPI based systems

 drivers/i2c/i2c-core-acpi.c |  3 ++-
 drivers/net/phy/sfp.c       | 35 +++++++++++++++++++++++++++--------
 include/linux/i2c.h         |  6 ++++++
 3 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.19.2

