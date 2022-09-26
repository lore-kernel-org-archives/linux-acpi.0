Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB2EC07E9D
	for <linux-acpi@archiver.kernel.org>; Mon, 26 Sep 2022 20:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIZU2A (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiIZU17 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Sep 2022 16:27:59 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D529D50F;
        Mon, 26 Sep 2022 13:27:58 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id be5d33958004a656; Mon, 26 Sep 2022 22:27:57 +0200
Received: from kreacher.localnet (unknown [195.136.19.0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BB9D966D6A6;
        Mon, 26 Sep 2022 22:27:56 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [Update][PATCH] ACPI: Kconfig: Drop link to https://01.org/linux-acpi
Date:   Mon, 26 Sep 2022 22:27:56 +0200
Message-ID: <2255057.ElGaqSPkdT@kreacher>
In-Reply-To: <4771612.31r3eYUQgx@kreacher>
References: <4771612.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.0
X-CLIENT-HOSTNAME: 195.136.19.0
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgudehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvtdevuedvjeeuheegleeijefglefghffgfffgffekieekvdeijedvteektedugeenucffohhmrghinheptddurdhorhhgnecukfhppeduleehrddufeeirdduledrtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihh
 rghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the https://01.org/linux-acpi web site has become permanently
unreachable, drop the remaining link to it from the ACPI Kconfig.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

In the previous posting of this patch the subject didn't match the patch
content, sorry about that.

---
 drivers/acpi/Kconfig |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-pm/drivers/acpi/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -27,9 +27,6 @@ menuconfig ACPI
 	  Management (APM) specification.  If both ACPI and APM support 
 	  are configured, ACPI is used.
 
-	  The project home page for the Linux ACPI subsystem is here:
-	  <https://01.org/linux-acpi>
-
 	  Linux support for ACPI is based on Intel Corporation's ACPI
 	  Component Architecture (ACPI CA).  For more information on the
 	  ACPI CA, see:



