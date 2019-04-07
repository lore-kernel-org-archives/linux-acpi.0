Return-Path: <SRS0=/dqn=SJ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4F9C282DA
	for <linux-acpi@archiver.kernel.org>; Sun,  7 Apr 2019 01:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB812133F
	for <linux-acpi@archiver.kernel.org>; Sun,  7 Apr 2019 01:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="f6HBt+BL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDGBNR (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:13:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41800 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDGBNR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Apr 2019 21:13:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id w30so11612331qta.8
        for <linux-acpi@vger.kernel.org>; Sat, 06 Apr 2019 18:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ToAuCI2UZu0RpD1Nbid/Kfs3hirNsiqiUv3gwCu4cTE=;
        b=f6HBt+BLBmT3vi50EWWf2NGusDfk/FoZDZ/0d4NGtyO2qfFX+h0DgB/bN+1zkYROCA
         BLrOYy4P3ZJ4A+9KLblNjaLL6Sm/LJ/8/Vx96ywQqm5++EY7t/P93lQPtThZHi/s0WE1
         GyyhnjKZOXnuMespn6qsADB/NxQ/HHxpRSOZZTB21G6//PIZVq6cvDhIPVJftmYQZlDZ
         qT9kqX0eW1Yx8iiS8hb8lAHeXTCjDBFRlCf5UlKdTpRQ82NUUReTeUi+yKSbE1OC6aRb
         ELXY2MQr+nWZYvZJJs658WMM4F3jz5NAhamWCHAT/kbWP54shkAXmQ8eEP/OuvQ23XKv
         cyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ToAuCI2UZu0RpD1Nbid/Kfs3hirNsiqiUv3gwCu4cTE=;
        b=WL7BVDcnAn8aHbXp9ihiSnORGJTeu1ozXpTA29bKnEs8eEP7MMvuA/6bBoAs48GABY
         08ik4U5BK4N3sNq7Dfujaf9JkaQ5hssZX2UhTmA854eai1/gifV+IkiagoAGJRnO4HZd
         6wxRAnwp4ZMSHv0PNobt79TDPzLu/ENT6p8H6wQzbqga5WpjmjJCIf3LHtNTgXkqZAbn
         kWrIGy6J7naiHZTbyS7Bnf1QHuNs1GEAAPI7cvUFS/X7JS6pat6HiSUk+Yx6i5dNq4AG
         v+olzTSK2q9usKzuGtC9GDETDzldu/tUWggocF4gdpWYQDc/hvLcs0EojV3xUt1UJ2fP
         2Tcg==
X-Gm-Message-State: APjAAAXc/zkNLT0W10Z85Q0vhpyYpHVEL5bvcJRk3jLV9goiAN6GVZsz
        H45Gfo/SxknUTC/wLT/CcGJIWw==
X-Google-Smtp-Source: APXvYqzj6V6+3hND60M5781OLAf+SiQOm7aIYwBKSQhobgp4jxkRezcIiT3+PeD91RpaY0tktbzylg==
X-Received: by 2002:a0c:ecca:: with SMTP id o10mr17195305qvq.197.1554599596196;
        Sat, 06 Apr 2019 18:13:16 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s43sm16875165qth.47.2019.04.06.18.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 18:13:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, keith.busch@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] acpi/hmat: fix an uninitialized memory_target
Date:   Sat,  6 Apr 2019 21:12:22 -0400
Message-Id: <20190407011222.38963-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190407011222.6hRm9I3GkUt3Pa_pqm-5w66ItpN6E2toy_nnh-nTuJY@z>

The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
memory") introduced an uninitialized "struct memory_target" that could
cause an incorrect branching.

drivers/acpi/hmat/hmat.c:385:6: warning: variable 'target' is used
uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]
        if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/hmat/hmat.c:392:6: note: uninitialized use occurs here
        if (target && p->flags & ACPI_HMAT_PROCESSOR_PD_VALID) {
            ^~~~~~
drivers/acpi/hmat/hmat.c:385:2: note: remove the 'if' if its condition
is always true
        if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/hmat/hmat.c:369:30: note: initialize the variable 'target'
to silence this warning
        struct memory_target *target;
                                    ^
                                     = NULL

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/acpi/hmat/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index c9b8abcf012c..6653dba3b377 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 					      const unsigned long end)
 {
 	struct acpi_hmat_proximity_domain *p = (void *)header;
-	struct memory_target *target;
+	struct memory_target *target = NULL;
 
 	if (p->header.length != sizeof(*p)) {
 		pr_notice("HMAT: Unexpected address range header length: %d\n",
-- 
2.17.2 (Apple Git-113)

