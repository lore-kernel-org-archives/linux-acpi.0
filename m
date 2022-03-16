Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D210C433EF
	for <linux-acpi@archiver.kernel.org>; Wed, 16 Mar 2022 15:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357369AbiCPPsl (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357365AbiCPPsi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 11:48:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53F1D6D39F;
        Wed, 16 Mar 2022 08:47:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C1B71476;
        Wed, 16 Mar 2022 08:47:23 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AECE3F7D7;
        Wed, 16 Mar 2022 08:47:22 -0700 (PDT)
Date:   Wed, 16 Mar 2022 15:47:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mailbox: pcc: Fix spelling mistake "Plaform" ->
 "Platform"
Message-ID: <YjIGh3RUpvBQxWuo@bogus>
References: <20220315202756.2953329-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315202756.2953329-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 15, 2022 at 08:27:56PM +0000, Colin Ian King wrote:
> There is a spelling mistake in a pr_err error message. Fix it.
>

Not sure why you have tagged next, this is in the mainline too.
Anyways,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
