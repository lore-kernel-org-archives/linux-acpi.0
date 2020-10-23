Return-Path: <SRS0=VabV=D6=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D365C5517A
	for <linux-acpi@archiver.kernel.org>; Fri, 23 Oct 2020 16:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE292206B5
	for <linux-acpi@archiver.kernel.org>; Fri, 23 Oct 2020 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603471093;
	bh=aze7TjC84Uc8SJubYPng7vvu1DjXQUzWlcB1MzITV/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TOmJpyVrHJs8QDIWH3L8uAKh8MwaCc+A+gHHhJ9h/rkwfeAzwLg6eSaOOWfZyco4M
	 SHEwHZTUHX4DITp7s0+QhD4D/bEWO89R5G2H1Vwng2mO7Hkms7S2t0zWgrF/prgPf0
	 t/l3XcDtw93erKmyNGe40xAMuaRk+i1k6uOJIni0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbgJWQhy (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751830AbgJWQdt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:49 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76F52468E;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=aze7TjC84Uc8SJubYPng7vvu1DjXQUzWlcB1MzITV/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e90TF8VCkorCRtM6nS/rGaOYyNg8zUk9M0V26eTmEwfcYP8i1I7eTEyjPbvQxBG2u
         NmAa/1etwUe303x9xBYf7sUmmo1CTqadAmqO3LCWBMPpD9DyH4qFU4o0ZSp+S+Mbio
         DElJDr6y+gAb7CZ0YZ6sjbvjxfJFqeVgQGy1Ys2c=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00f-002AwN-Pl; Fri, 23 Oct 2020 18:33:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 24/56] PNP: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:11 +0200
Message-Id: <1e3d69e0890a36303f4c804ae9c523df9f098d6a.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It sounds that there were function renames. Update the kernel-doc
markups accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pnp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 3bf18d718975..a50ab002e9e4 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -51,7 +51,7 @@ static void pnp_remove_protocol(struct pnp_protocol *protocol)
 }
 
 /**
- * pnp_protocol_register - adds a pnp protocol to the pnp layer
+ * pnp_register_protocol - adds a pnp protocol to the pnp layer
  * @protocol: pointer to the corresponding pnp_protocol structure
  *
  *  Ex protocols: ISAPNP, PNPBIOS, etc
@@ -91,7 +91,7 @@ int pnp_register_protocol(struct pnp_protocol *protocol)
 }
 
 /**
- * pnp_protocol_unregister - removes a pnp protocol from the pnp layer
+ * pnp_unregister_protocol - removes a pnp protocol from the pnp layer
  * @protocol: pointer to the corresponding pnp_protocol structure
  */
 void pnp_unregister_protocol(struct pnp_protocol *protocol)
-- 
2.26.2

