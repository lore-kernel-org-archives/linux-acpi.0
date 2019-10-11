Return-Path: <SRS0=e/yL=YE=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205C8C47404
	for <linux-acpi@archiver.kernel.org>; Fri, 11 Oct 2019 19:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FD021D56
	for <linux-acpi@archiver.kernel.org>; Fri, 11 Oct 2019 19:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCcyfvcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfJKTP1 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 11 Oct 2019 15:15:27 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:36556 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfJKTP1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 15:15:27 -0400
Received: by mail-yw1-f73.google.com with SMTP id r64so8314827ywb.3
        for <linux-acpi@vger.kernel.org>; Fri, 11 Oct 2019 12:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2LK7MZ/I1CyNASlk+qr5lnr5R+gCtp5cqesKvyijqAI=;
        b=dCcyfvcv3IsRhEQUEUjJI6r7Io7Gj9enAHtAz4TMJxBZoqWS6kUQsJuOJv+mvRxcaR
         W/57JYw5pOOFCADaMAdznF5d7agokzIqiCwbL7PK/MuuAl4FtJKuvMcMEFPF/n1QUtwG
         +AfFp3fOUi/+/DQSjvBx8vbs+hxrNro+H/GUUBf2upcEP7Gd5vBUKpEVUeYGYM5SYDyF
         Az91FrVj4G7UyKvJOjNaxljdgQckRvrNmn8+iVEQdn8kf5Be/nzGpdyT97dI7i1Py6TW
         nRZYVkNAKu7VlAW/GlY5+px+7mJiMMjK3cw2xMRNXGNvyEyQQkxUxxzOBckMyIoGcVu9
         rRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2LK7MZ/I1CyNASlk+qr5lnr5R+gCtp5cqesKvyijqAI=;
        b=jompQrCFMI7Y6OPB7gpJJzSe2beXVV5NhmhUy5pof6eyR1yRYtufWEA8f95Q+rjmqA
         rznBoEg+bLRGtt2Kt+OfY7zFwStNuxY9oJ+KZxLtvdjeFay+icIev0+yN7sz8yQnNK/K
         G2KgChEaZajcNWWu/PNqonFafZGuXbmI8EJTYRgKqqK9jGqDkN8UrSB27tQeDTMHQtGf
         CkqqZQPInashKJix3cGCEThZF8cPwWq71CHMExDTgPchEhIsZI31OvQK9NhkmXGjWfou
         T5w4JlCr6MBLzyYy1qC4klgSEvJjhWj0Ab80RROUKF6GkZ+0xVQ49ICdAKj+jZGllwU4
         7IuQ==
X-Gm-Message-State: APjAAAXBKm8OlAEpDFHNwoAXfwEeh/Nz2gsG00DrBtj/1Yka2yr0n/7G
        jiu6rcRqo+pCUn/SgKQuQjcMjGOt/lD6NA8=
X-Google-Smtp-Source: APXvYqxCwAr5/9joD+wnV488pzFB2G7pMoHdRW5ziKI7SO4MYaakbb/DVO337qNGCNybdnSYAfFybGH90A4h6Kc=
X-Received: by 2002:a81:441b:: with SMTP id r27mr3771738ywa.381.1570821325935;
 Fri, 11 Oct 2019 12:15:25 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:15:18 -0700
Message-Id: <20191011191521.179614-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v1 0/3] Documentation/minor coding style fix ups
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Addressing a few coding style comments and adding a bunch of
documentation.

Saravana Kannan (3):
  of: property: Minor code formatting/style clean ups
  driver: core: Improve documentation for fwnode_operations.add_links()
  docs: driver-model: Add documentation for sync_state

 .../driver-api/driver-model/driver.rst        | 43 +++++++++++++++++++
 drivers/of/property.c                         | 12 +++---
 include/linux/fwnode.h                        | 21 ++++++++-
 3 files changed, 68 insertions(+), 8 deletions(-)

-- 
2.23.0.700.g56cf767bdb-goog

