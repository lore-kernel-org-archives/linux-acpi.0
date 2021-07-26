Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F73C4338F
	for <linux-acpi@archiver.kernel.org>; Mon, 26 Jul 2021 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C8860F53
	for <linux-acpi@archiver.kernel.org>; Mon, 26 Jul 2021 07:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhGZHCI (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 26 Jul 2021 03:02:08 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38159 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231891AbhGZHCI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Jul 2021 03:02:08 -0400
Received: from [192.168.0.3] (ip5f5aeda7.dynamic.kabel-deutschland.de [95.90.237.167])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2BC5261E5FE00;
        Mon, 26 Jul 2021 09:42:35 +0200 (CEST)
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: New warning: PRMT not found
Message-ID: <64150c95-3f7d-d21f-d6fb-b9d478ed6798@molgen.mpg.de>
Date:   Mon, 26 Jul 2021 09:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Erik,


The new code added in commit cefc7ca462 (ACPI: PRM: implement 
OperationRegion handler for the PlatformRtMechanism subtype) causes 
Linux to log a warning on my desktop system Asus F2A85-M PRO.

     PRMT not found

The help text for the Kconfig option `ACPI_PRMT` suggests it’s mainly 
used for server systems, so the warning does not apply to a lot of 
systems. Therefore, in my opinion, the option should not be selected by 
default, or the warning be removed or demoted, and phrased in a way, 
that users can understand the consequences.


Kind regards,

Paul
