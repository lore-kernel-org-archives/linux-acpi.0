Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC76C433E0
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Feb 2021 19:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D02E64E84
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Feb 2021 19:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhBHTDa (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:03:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60256 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbhBHTA7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 14:00:59 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id a286e0da6626053a; Mon, 8 Feb 2021 20:00:07 +0100
Received: from kreacher.localnet (89-64-80-68.dynamic.chello.pl [89.64.80.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BD6D46608B1;
        Mon,  8 Feb 2021 20:00:06 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hanjun Gou <gouhanjun@huawei.com>
Subject: [PATCH v1 0/2] ACPI: OSL: SImplify acpi_check_resource_confllict() and clean up printing messages
Date:   Mon, 08 Feb 2021 19:56:59 +0100
Message-ID: <4653881.kBYL0eE9gL@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevudefgfeguedtjedvhfetveegleduveeuvedvjeekleefhfduhfefheekffefveenucfkphepkeelrdeigedrkedtrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrieekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhouhhhrghnjhhunheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

These two patches clean up some code in osl.c.

The first one simplifies acpi_check_resource_confllict() and the second one deals with
message printing in this file.

See patch changelogs for details.

Thanks!



