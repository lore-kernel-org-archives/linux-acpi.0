Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF482C433EF
	for <linux-acpi@archiver.kernel.org>; Thu,  7 Jul 2022 01:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiGGBS3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 6 Jul 2022 21:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiGGBS2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2022 21:18:28 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A03AC59;
        Wed,  6 Jul 2022 18:18:25 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 61C561E80D82;
        Thu,  7 Jul 2022 09:16:05 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ryWmeIElm7AS; Thu,  7 Jul 2022 09:16:02 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 9965B1E80D74;
        Thu,  7 Jul 2022 09:16:02 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     rafael@kernel.org
Cc:     kernel@nfschina.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zeming@nfschina.com
Subject: Re: [PATCH] acpi/sbshc: Add header file macro definition
Date:   Thu,  7 Jul 2022 09:17:57 +0800
Message-Id: <20220707011758.3082-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <CAJZ5v0i4vuH7V-8UUESTOaC5MKuKycLUeC+MsR-Mwq-KE8-d9w@mail.gmail.com>
References: <CAJZ5v0i4vuH7V-8UUESTOaC5MKuKycLUeC+MsR-Mwq-KE8-d9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


I think the header file could avoid redefinition errors.
 at compile time by adding macro definitions.

