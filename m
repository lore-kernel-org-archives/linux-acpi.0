Return-Path: <SRS0=PV1G=7W=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBC0C433DF
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Jun 2020 10:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43AA207F9
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Jun 2020 10:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRLTeeLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgFIKro (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgFIKrh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2020 06:47:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701EFC03E97C
        for <linux-acpi@vger.kernel.org>; Tue,  9 Jun 2020 03:47:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q13so15955632edi.3
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2020 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U9rt/3Vl/6zlHKoX8Sru+cTCnsVpfXdCh6OHWoOo9RE=;
        b=FRLTeeLV+htxuHSVemMkC/H0jDbDMDBVLljGbI5nXTP0IhqF5MnV9KiofVJzjeP4z4
         0zwVRhu75Q4no06LDdOJshGV1LHb0S3tOA05xbRD40Dma+wJmAO9YFhwn5dctpuYIEWq
         ZLG3B+MAt29+JMNIQpeV11RNkNvsbXBA5Qgnm/0GE1KBf7nXFDBsqux+9o5VA0MU1ZWv
         AXpnSTeeFLZAnaiYcjBmlBixwTTthdz+l8s1TM87XZiEztoLc5XuK1HttYXUW9jSdJRS
         axs60D+IuuCnv1d2SKcZyZLFlz73Q6gnl4DPgbVQDWWCv71BwouRU8hzz7qDRGuGQR6V
         gaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U9rt/3Vl/6zlHKoX8Sru+cTCnsVpfXdCh6OHWoOo9RE=;
        b=gkW8nVK+Ila+58XC/EcQFqC2t2fpKuRXh3afk+Y7NBrZltjv1Vcse/1m1gPhGcNB3f
         J3Mcr1EJPkB/gLoj2m5xRaDgIu9hVxyIaG12lTRbyFEuW8sJTzvow8F1hSSXIhkD00YN
         7bxHDU4IFXxG/QCsp65wvhh9j/8ML6ffYzGhQ+7FHfaKrVzg6mliI0e3kC3W7sIqPkId
         VTVW764lVJG4dJdY3BplFwFMpO+tEoZ+jbBqlr892C/pFW9GcjBj3IXutL2NRF3W841P
         la9CMZdq0GwgFh169HbQw3S5ptSLsuWs+P9C2VZNFPL4gR/ww20CVyqIOle32gGTie3Q
         YYDQ==
X-Gm-Message-State: AOAM531tBGlx5glGAoevhurd80yf5JlFillp+jrAJn+D/GVG3MIbVOpM
        ahhYcUNjZ89ddw8QrA6IkJ2uqg==
X-Google-Smtp-Source: ABdhPJz+fdaUtgiiLd8gXAw1zn+Ihd7jWg7g+4P4sGhrrGs3vMrDi8lIPiEbt8jFBzavbp4Ebo9fZw==
X-Received: by 2002:a50:b0e2:: with SMTP id j89mr26765993edd.257.1591699655083;
        Tue, 09 Jun 2020 03:47:35 -0700 (PDT)
Received: from localhost.localdomain (hst-221-69.medicom.bg. [84.238.221.69])
        by smtp.gmail.com with ESMTPSA id qt19sm12267763ejb.14.2020.06.09.03.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 03:47:34 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 1/7] Documentation: dynamic-debug: Add description of level bitmask
Date:   Tue,  9 Jun 2020 13:45:58 +0300
Message-Id: <20200609104604.1594-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This adds description of the level bitmask feature.

Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0dc2eb8e44e5..c2b751fc8a17 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -208,6 +208,12 @@ line
 	line -1605          // the 1605 lines from line 1 to line 1605
 	line 1600-          // all lines from line 1600 to the end of the file
 
+level
+    The given level will be a bitmask ANDed with the level of the each ``pr_debug()``
+    callsite. This will allow to group debug messages and show only those of the
+    same level.  The -p flag takes precedence over the given level. Note that we can
+    have up to five groups of debug messages.
+
 The flags specification comprises a change operation followed
 by one or more flag characters.  The change operation is one
 of the characters::
@@ -346,6 +352,10 @@ Examples
   // add module, function to all enabled messages
   nullarbor:~ # echo -n '+mf' > <debugfs>/dynamic_debug/control
 
+  // enable all messages in file with 0x01 level bitmask
+  nullarbor:~ # echo -n 'file foo.c level 0x01 +p' >
+                                <debugfs>/dynamic_debug/control
+
   // boot-args example, with newlines and comments for readability
   Kernel command line: ...
     // see whats going on in dyndbg=value processing
-- 
2.17.1

