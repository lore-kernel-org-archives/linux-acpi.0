Return-Path: <SRS0=x+Qm=6M=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A0C83000
	for <linux-acpi@archiver.kernel.org>; Tue, 28 Apr 2020 17:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5DB20B80
	for <linux-acpi@archiver.kernel.org>; Tue, 28 Apr 2020 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588094517;
	bh=nzJMTuSFPROth1NlDLQvcUO+nV0x7fXVJzHHhcpaQk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0gQJShtIkJEs+Yq7vDY9gbk1V1YIs2OrU2YJejvM525FyScJQV8a4Z+sJcMOJLO/4
	 Zu3G8pH5m7/+/rpD5UL5M/djH0Cc64gS44nAfJUGwBi9cD0uMhNgBv1vqwq3ZiDrRj
	 u2ATYWdkv1AffpokJ8Oz72CQdyw7CycxxWHVNh/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgD1RV5 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgD1RV4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Apr 2020 13:21:56 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE3F2082E;
        Tue, 28 Apr 2020 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588094516;
        bh=nzJMTuSFPROth1NlDLQvcUO+nV0x7fXVJzHHhcpaQk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJOjBWthKvniDH6z/EcMBa21tK7+WuCcE3id4La+LJBSpPNdpKYM1jDEC5aKBtCs7
         NeFo0x57X3xOJ+VEAJzUom80LMVoLEw0D+jOKqa87wUOV4frNdBkNa1CsL28lK+rbi
         XWZGNp7nx+C3P5PjAsoiB/skJznvyLZEv2UC8rrk=
From:   Will Deacon <will@kernel.org>
To:     linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        sudeep.holla@arm.com, rjw@rjwysocki.net,
        Andrei Warkentin <awarkentin@vmware.com>, guohanjun@huawei.com,
        lenb@kernel.org, lorenzo.pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI/IORT: take _DMA methods into account for named components
Date:   Tue, 28 Apr 2020 18:21:48 +0100
Message-Id: <158809356800.149651.3435193422736187713.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420092753.9819-1-ardb@kernel.org>
References: <20200420092753.9819-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 20 Apr 2020 11:27:53 +0200, Ard Biesheuvel wrote:
> Where IORT nodes for named components can describe simple DMA limits
> expressed as the number of address bits a device can drive, _DMA methods
> in AML can express more complex topologies, involving DMA translation in
> particular.
> 
> Currently, we only take this _DMA method into account if it appears on a
> ACPI device node describing a PCIe root complex, but it is perfectly
> acceptable to use them for named components as well, so let's ensure
> we take them into account in those cases too.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI/IORT: take _DMA methods into account for named components
      https://git.kernel.org/arm64/c/7fb89e1d44cb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
