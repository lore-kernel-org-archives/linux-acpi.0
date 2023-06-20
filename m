Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ACFEB64D7
	for <linux-acpi@archiver.kernel.org>; Tue, 20 Jun 2023 06:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjFTGvc (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 20 Jun 2023 02:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFTGvc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jun 2023 02:51:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE4EEE;
        Mon, 19 Jun 2023 23:51:30 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QlcfC2PdwzMphw;
        Tue, 20 Jun 2023 14:48:19 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 20 Jun 2023 14:51:26 +0800
Subject: Re: [PATCH 1/3 v2] Documentation/arm64: Update ARM and arch reference
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Jose Marinho <jose.marinho@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
References: <20230606093528.1494344-1-jose.marinho@arm.com>
 <20230606093528.1494344-2-jose.marinho@arm.com>
 <c05323a8-5cda-5355-b701-e4acdae99f53@intel.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <bedea335-c27c-830b-fdf5-75f77f3baf50@huawei.com>
Date:   Tue, 20 Jun 2023 14:51:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c05323a8-5cda-5355-b701-e4acdae99f53@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023/6/19 20:22, Wilczynski, Michal wrote:
>>   Participation in this group is open to all UEFI members.  Please see
>>   http://www.uefi.org/workinggroup  for details on group membership.
 >
> Not part of this patch, but while at it maybe fix thehttp://www.uefi.org/workinggroup
> that doesn't work - it returns 404.

Thank you. I think it's https://uefi.org/membership now.

Thanks
Hanjun
