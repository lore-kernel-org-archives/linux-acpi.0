Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224E3ECAAD8
	for <linux-acpi@archiver.kernel.org>; Thu, 22 Sep 2022 02:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIVC3L (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 21 Sep 2022 22:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIVC3K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 22:29:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38729AB4F2;
        Wed, 21 Sep 2022 19:29:09 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXzdR2mwRzlXLY;
        Thu, 22 Sep 2022 10:24:59 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:29:07 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:29:06 +0800
Message-ID: <cb2f3c9c-ab45-357d-8a56-1c64b535633c@huawei.com>
Date:   Thu, 22 Sep 2022 10:29:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] ACPI: PCC: replace wait_for_completion()
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <huangdaode@huawei.com>
References: <20220920094500.11283-1-lihuisong@huawei.com>
 <20220920094500.11283-2-lihuisong@huawei.com>
 <20220921154737.az3d4ndxs3u3zwbl@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20220921154737.az3d4ndxs3u3zwbl@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


在 2022/9/21 23:47, Sudeep Holla 写道:
> On Tue, Sep 20, 2022 at 05:44:59PM +0800, Huisong Li wrote:
>> Currently, the function waiting for completion of mailbox operation is
>> 'wait_for_completion()'.  The PCC method will be permanently blocked if
>> this mailbox message fails to execute. So this patch replaces it with
>> 'wait_for_completion_timeout()'. And set the timeout interval to an
>> arbitrary retries on top of nominal to prevent the remote processor is
>> slow to respond to PCC commands.
>>
> Sounds good to me. The only concern(may be not serious) is what happens
> if we receive response from the platform after the timeout. I have tested
If OS still cann't receive response in noramal latency(must be filled 
accurately
as protocol said) + retries, there is a high probability that an 
exception occurs.
Even if we receive response after the timeout, I think there may be no 
impact,
but the response data in PCC share memory is ignored.
> for that in non ACPI non PCC context. I don't have a setup to trigger that
> with ACPI PCC + this patch to test. Other than that, I am fine with this:
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
