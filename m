Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F13EB64D8
	for <linux-acpi@archiver.kernel.org>; Wed, 14 Jun 2023 15:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjFNP6t (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 14 Jun 2023 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjFNP6s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jun 2023 11:58:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 405BB1721;
        Wed, 14 Jun 2023 08:58:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FEB81FB;
        Wed, 14 Jun 2023 08:59:31 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D4073F71E;
        Wed, 14 Jun 2023 08:58:45 -0700 (PDT)
Date:   Wed, 14 Jun 2023 16:58:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     rafael@kernel.org, rafael.j.wysocki@intel.com,
        robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH v4 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
Message-ID: <20230614155842.7j3d6hdx7mmnhghd@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230613125728.31279-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613125728.31279-1-lihuisong@huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Tue, Jun 13, 2023 at 08:57:26PM +0800, Huisong Li wrote:
> PCC supports processing platform notification for slave subspaces and
> shared interrupt for multiple subspaces.
> 

Can you pick up these patches please ?
It missed last merge window narrowly as I didn't want to push it that late.
So it would be good to get this in this time around.

-- 
Regards,
Sudeep
