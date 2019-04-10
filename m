Return-Path: <SRS0=P5bh=SM=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815C1C10F0E
	for <linux-acpi@archiver.kernel.org>; Wed, 10 Apr 2019 02:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485402082E
	for <linux-acpi@archiver.kernel.org>; Wed, 10 Apr 2019 02:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Y2u7weDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfDJCPB (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:15:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38952 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJCPB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Apr 2019 22:15:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so1114341qte.6
        for <linux-acpi@vger.kernel.org>; Tue, 09 Apr 2019 19:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2ez/m7iZt9Klypf562H3ieEuHRRYp81BN5M3IjV/EFg=;
        b=Y2u7weDPeIX3nwZ2R3A/UOhntYJbn7n31ZM/Axlh69OniKUJZ9gCwd+q7a9XE/jY7m
         KSTTEWbapa1zOTzRDAOL/ce4hmbRsW4nWqE/Ng1juIbD09VfTWOuag+n4hbPWoCX+AUu
         3HMvNgTou91/LHB1jvYBKs0h6CuveA41cup7EWTqaAyX46De8iSQceCK8HakWakNmf+9
         14HB+Usi8UB5FaPJy2NlFFpkp9ujXv2c73/J+ysOa/jN6o9sJVGfDfCPILxvS4Rw5+pB
         x/IHNRNEx24WbxuSn6dYDT/A0dLKdv/vR9kn1IvYVroeVHA3DQqO5kquL5hcjmOK4KEk
         iy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2ez/m7iZt9Klypf562H3ieEuHRRYp81BN5M3IjV/EFg=;
        b=kFsuYh/FtU6jQtQcdRxWNHLNaa1iCnqFmLNMzFrMqcXJrxvzq+PK1TbBxnbwX73MX2
         XiJx4axLaWmJ6j74+ZtQYHMLEJEeB2F8wgjDEaQB2Sbx3/OG9QVO/j017zunX3aIFtAz
         rldJXfPyXYAmKw4zxxNO1x6rk0ds4eq+/g/v9psi+JUJQDo5XSBbklm6MaZD6yUeTpLF
         8RkXNNBMyke59PH+VJ5jHvwibO1xyJLgWVNl2LTPimQ9kPhKNxZwj15egG+DN6C15LAl
         5x+7yWxqabM/XFbmq6kQa+EvHbLaWUSmsLyCkakya4M2a5tQBaS02YoUTrrjxjcoawDx
         PzKQ==
X-Gm-Message-State: APjAAAWkoQ+K7tRpGM1MFNpjpPrWs9IIvzDRp8Bu06bIjbBonJa3Q0uD
        Kx+RvUEiB1wk7zcay1YVdYEouw==
X-Google-Smtp-Source: APXvYqznSs2U0RDBGWPxwVCf+BNG2aJmBtRAUi4ZSPVar0L1ZOj1dAM3yVBu0IpnHx+o8mm8BRQjCg==
X-Received: by 2002:ac8:2aa7:: with SMTP id b36mr33709713qta.187.1554862500674;
        Tue, 09 Apr 2019 19:15:00 -0700 (PDT)
Received: from ovpn-120-242.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e18sm3613391qki.82.2019.04.09.19.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:14:59 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, keith.busch@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] acpi/hmat: fix memory leaks in hmat_init()
Date:   Tue,  9 Apr 2019 22:14:50 -0400
Message-Id: <20190410021450.1263-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410021450.lgvr6GYfTWSmy8dX8rsijNhR8_Sj7L94HbLHh9ISqhw@z>

The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
memory") introduced some memory leaks below due to it fails to release
the heap memory in an error path, and then those statically-allocated
__initdata memory which reference them get freed during boot renders
those heap memory as leaks. Since it is valid to pass NULL to
acpi_put_table(), it is fine to call it even if acpi_get_table() returns
an error.

unreferenced object 0xc8ff8008349e9400 (size 128):
  comm "swapper/0", pid 1, jiffies 4294709236 (age 48121.476s)
  hex dump (first 32 bytes):
    00 d0 9e 34 08 80 ff 84 d8 00 43 11 00 10 ff ff  ...4......C.....
    00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000869d4503>] __kmalloc+0x568/0x600
    [<0000000070fd6afb>] alloc_memory_target+0x50/0xd8
    [<00000000efa2081e>] srat_parse_mem_affinity+0x58/0x5c
    [<000000008bfaef74>] acpi_parse_entries_array+0x1c8/0x2c0
    [<0000000022804877>] acpi_table_parse_entries_array+0x11c/0x138
    [<00000000ffe9cd34>] acpi_table_parse_entries+0x7c/0xac
    [<00000000a7023afd>] hmat_init+0x90/0x174
    [<00000000694a86c1>] do_one_initcall+0x2d8/0x5f8
    [<0000000024889da9>] do_initcall_level+0x37c/0x3fc
    [<000000009be02908>] do_basic_setup+0x38/0x50
    [<0000000037b3ac0a>] kernel_init_freeable+0x194/0x258
    [<00000000f5741184>] kernel_init+0x18/0x334
    [<000000007b30f423>] ret_from_fork+0x10/0x18
    [<000000006c7147a8>] 0xffffffffffffffff

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: goto out_put per Rafael.

 drivers/acpi/hmat/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index b7824a0309f7..69cdb3cea545 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -637,7 +637,7 @@ static __init int hmat_init(void)
 
 	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
 	if (ACPI_FAILURE(status))
-		return 0;
+		goto out_put;
 
 	hmat_revision = tbl->revision;
 	switch (hmat_revision) {
-- 
2.17.2 (Apple Git-113)

