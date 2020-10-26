Return-Path: <SRS0=lFH/=EB=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A228C4363A
	for <linux-acpi@archiver.kernel.org>; Mon, 26 Oct 2020 21:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F0320829
	for <linux-acpi@archiver.kernel.org>; Mon, 26 Oct 2020 21:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603748926;
	bh=R7zMDymsvhTfopdeoblEJpa47TFpLO5lTLpTKm/lObU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GCVP+Z4DzE43gGB20m3/fF8j6WJR8EnX8PQJb+GqUQp8WI2u8t2Ou00HOgOTcGjRr
	 CjdTAu52oZfebL1eqMndgk0rHpbjrb2sYHWaIWAiL4DXWxwC3qWGt299nTL2nS65AX
	 LY3MYPN/6dDCccbezbAV+7VBcyJ7YKZJPG9nFyPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390342AbgJZVsp (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390340AbgJZVsp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Oct 2020 17:48:45 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B123B207E8;
        Mon, 26 Oct 2020 21:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603748924;
        bh=R7zMDymsvhTfopdeoblEJpa47TFpLO5lTLpTKm/lObU=;
        h=From:To:Cc:Subject:Date:From;
        b=M1NDeXoK7s+A7e/qV2TipTvaMbyCdFn9rmPhQfFtkGEE+WLsz6dUA5bBa9eq4cGQi
         7NisPujAUpEBgQPdKNI6+2Iw841e9J/v6CDtRcvVi5XviiscjH10RBB54UB+tXIoNH
         TJ9BzYliB8YVx5TbF48VMknMIbvtKwtxbb2ZE7rQ=
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: dock: fix enum-conversion warning
Date:   Mon, 26 Oct 2020 22:48:34 +0100
Message-Id: <20201026214838.3892471-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc points out a type mismatch:

drivers/acpi/dock.c: In function 'hot_remove_dock_devices':
drivers/acpi/dock.c:234:53: warning: implicit conversion from 'enum <anonymous>' to 'enum dock_callback_type' [-Wenum-conversion]
  234 |   dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST, false);

This is harmless because 'false' still has the correct numeric value,
but passing DOCK_CALL_HANDLER documents better what is going on
and avoids the warning.

Fixes: 37f908778f20 ("ACPI / dock: Walk list in reverse order during removal of devices")
Fixes: f09ce741a03a ("ACPI / dock / PCI: Drop ACPI dock notifier chain")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/dock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 45d4b7b69de8..24e076f44d23 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -231,7 +231,8 @@ static void hot_remove_dock_devices(struct dock_station *ds)
 	 * between them).
 	 */
 	list_for_each_entry_reverse(dd, &ds->dependent_devices, list)
-		dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST, false);
+		dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST,
+				   DOCK_CALL_HANDLER);
 
 	list_for_each_entry_reverse(dd, &ds->dependent_devices, list)
 		acpi_bus_trim(dd->adev);
-- 
2.27.0

